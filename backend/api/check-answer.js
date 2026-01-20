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

        if(correct[0].correctAnswer === req.body['answer']){
            req.session.quizes[quizID].currentQuestion += 1;
            if(req.session.quizes[quizID].currentQuestion === req.session.quizes[quizID].allQuestions){
                delete req.session.quizes[quizID];
                res.json({
                    correct: true,
                    finished: true
                });
            }else{
                res.json({
                    correct: true,
                    finished: false
                });
            }
        }else{
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