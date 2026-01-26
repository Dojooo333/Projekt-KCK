const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.post('/check-answer/:quizID', async(req, res) => {
    const quizID = req.params.quizID;
    const login = req.session.username;

    try{

        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        if(userData[0].isLecturer === 1 || req.session.quizes === undefined){
            res.redirect('/');
            return;
        }

        const [correct] = await pool.query(
            "select correctAnswer from questions where quizID = ? and questionNr = ?;",
            [quizID,(req.session.quizes[quizID].currentQuestion+1)]
        );

        const saveGameResult = async (isWin) => {
            await pool.query(
                'insert into games (quizID, userID, startedDate, finishedDate, result, correctQuestions) values (?, ?, ?, NOW(), ?, ?);',
                [
                    quizID,
                    userData[0].id,
                    new Date(req.session.quizes[quizID].startedDate),
                    isWin ? 1 : 0,
                    req.session.quizes[quizID].currentQuestion
                ]
            );
        };

        if(correct[0].correctAnswer === req.body['answer']){
            req.session.quizes[quizID].currentQuestion += 1;
            if(req.session.quizes[quizID].currentQuestion === req.session.quizes[quizID].allQuestions){

                // Wygrana
                await saveGameResult(true);
                delete req.session.quizes[quizID];
                res.json({
                    correct: true,
                    finished: true
                });

            }else{

                // Poprawne pytanie
                res.json({
                    correct: true,
                    finished: false
                });

            }
        }else{

            // Przegrana
            await saveGameResult(false);
            delete req.session.quizes[quizID];
            res.json({
                correct: false,
                finished: false
            });
        }

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

module.exports = router;