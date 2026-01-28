const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.post('/help/:quizID/5050', async(req, res) => {
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

        if(req.session.quizes[quizID].lifelines.fiftyFifty === true){

            res.json({
                hide: null
            });
            return;
        }

        req.session.quizes[quizID].lifelines.fiftyFifty = true;

        const onlyWrongAnswers = ['a','b','c','d'].filter(letter => letter !== correct[0].correctAnswer)
        const randomWrongAnswer = onlyWrongAnswers[Math.floor((Math.random() * 3))];
        const twoWrong = onlyWrongAnswers.filter(letter => letter !== randomWrongAnswer);

        res.json({
            hide: twoWrong
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.post('/help/:quizID/helpExpert', async(req, res) => {
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

        if(req.session.quizes[quizID].lifelines.hint === true){
            res.json({
                hint: null
            });
            return;
        }
        req.session.quizes[quizID].lifelines.hint = true;

        let responseText;

        // Dobra odpowiedź
        if(Math.random() < 0.8){
            let randomMessage = Math.random();
            if(randomMessage < 0.25){
                responseText = `Jestem pewny, że będzie to odpowiedź ${(correct[0].correctAnswer).toUpperCase()}!`;
            }else if(randomMessage < 0.50){
                responseText = `Na pewno to ${(correct[0].correctAnswer).toUpperCase()}.`;
            }else if(randomMessage < 0.75){
                responseText = `Wiem! Definitywnie zaznacz ${(correct[0].correctAnswer).toUpperCase()}!`;
            }else{
                responseText = `Jestem przekonany, że ${(correct[0].correctAnswer).toUpperCase()} jest poprawne.`;
            }

        // Zła odpowiedź
        }else{
            const onlyWrongAnswers = ['a','b','c','d'].filter(letter => letter !== correct[0].correctAnswer);
            let suggested = (onlyWrongAnswers[Math.floor(Math.random() * 3)]).toUpperCase();
            
            let randomMessage = Math.random();
            if(randomMessage < 0.25){
                responseText = `Nie wiem, może ${suggested}...?`;
            }else if(randomMessage < 0.50){
                responseText = `Hm..., strzelam  ${suggested}.`;
            }else if(randomMessage < 0.75){
                responseText = `To może ${suggested}???`;
            }else{
                responseText = `Źle trafiłeś... nie znam na to odpowiedzi.`;
            }
        }

        res.json({
            hint: responseText
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.post('/help/:quizID/helpPublic', async(req, res) => {
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

        if(req.session.quizes[quizID].lifelines.audience === true){
            res.json({
                chartData: null
            });
            return;
        }

        req.session.quizes[quizID].lifelines.audience = true;

        let charts = {};

        // Poprawna odpowiedź ma między 40, a 70 głosów
        let correctPercent = Math.floor(Math.random() * (60 - 40 + 1)) + 40;
        if(Math.random() < 0.3) correctPercent += 40;
        charts[correct[0].correctAnswer] = correctPercent;

        let remainingPercent = 100 - correctPercent;
        let onlyWrongAnswers = ['a','b','c','d'].filter(letter => letter !== correct[0].correctAnswer);

        let randomAnswer1 = onlyWrongAnswers[Math.floor(Math.random() * 3)];
        onlyWrongAnswers = onlyWrongAnswers.filter(letter => letter !== randomAnswer1);
        
        let randomAnswer2 = onlyWrongAnswers[Math.floor(Math.random() * 2)];
        onlyWrongAnswers = onlyWrongAnswers.filter(letter => letter !== randomAnswer2);

        let randomAnswer3 = onlyWrongAnswers[0];


        let remaningPercent1 = Math.floor(Math.random() * remainingPercent);
        remainingPercent -= remaningPercent1;

        let remaningPercent2 = Math.floor(Math.random() * remainingPercent);
        remainingPercent -= remaningPercent2;

        let remaningPercent3 = remainingPercent;

        charts[randomAnswer1] = remaningPercent1;
        charts[randomAnswer2] = remaningPercent2;
        charts[randomAnswer3] = remaningPercent3;

        const sorted = {
            'a': charts['a'],
            'b': charts['b'],
            'c': charts['c'],
            'd': charts['d']
        };

        res.json({
            chartData: sorted
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

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