const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.get('/student/class/:classID/quiz/:quizID', async(req, res) => {

    const classID = req.params.classID;
    const quizID = req.params.quizID;
    const login = req.session.username;

    try{
        
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        if(userData[0].isLecturer === 1){
            res.redirect('/');
            return;
        }

        const [quizData] = await pool.query(
            "select * from quizes where id = ?;",
            quizID
        );


        if(req.session.quizes[quizID] === undefined){
            req.session.quizes[quizID] = {
                currentQuestion: 0,
                allQuestions: quizData[0].questionsCount,
                lifelines: {
                    fiftyFifty: false,
                    audience: false,
                    hint: false
                },
                startedDate: new Date(),
                finishedDate: null
            }
        }
        
        const [questionsData] = await pool.query(
            "select question, answerA, answerB, answerC, answerD from questions where quizID = ? and questionNr = ?;",
            [quizID, (req.session.quizes[quizID].currentQuestion+1)]
        );
        
        res.render('student-quiz.ejs',{
            userInfo: userData[0],
            quizInfo: quizData[0],
            question: questionsData[0],
            sessionDetails: req.session.quizes[quizID]
        });


        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.get('/student/class/:classID/quiz/:quizID/ranking', async(req, res) => {

    const classID = req.params.classID;
    const quizID = req.params.quizID;
    const login = req.session.username;

    try{
        
        // Pobieranie danych o użytkowniku
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        // Sprawdzanie, czy użytkownik nie jest prowadzącym
        if(userData[0].isLecturer === 1){
            res.redirect('/');
            return;
        }

        // Pobieranie danych o quizie
        const [quizData] = await pool.query(
            "select * from quizes where id = ?;",
            quizID
        );

        // Pobieranie danych o przedmiocie
        const [classData] = await pool.query(
            "select * from classes where id = ?;",
            quizData[0].classID
        );

        // Pobieranie danych o rankingu
        const [rankingData] = await pool.query(
            "select u.login, u.firstName, u.lastName, u.imgName, g.result, g.correctQuestions, timestampdiff(second, g.startedDate, g.finishedDate) as durationSeconds, g.startedDate, g.finishedDate from games g join users u on g.userID = u.id where g.quizID = ? and g.id = ( select id from games g2 where g2.userID = g.userID and g2.quizID = g.quizID order by g2.correctQuestions desc, timestampdiff(second, g2.startedDate, g2.finishedDate) asc limit 1 ) order by g.correctQuestions desc, durationSeconds asc;",
            quizID
        );

        // Pobieranie danych o rankingu
        const [lastgamesData] = await pool.query(
            "select g.result, g.correctQuestions, g.startedDate, g.finishedDate, timestampdiff(second, g.startedDate, g.finishedDate) as durationSeconds from games g where g.quizID = ? and g.userID = ? order by g.finishedDate desc limit 10;",
            [quizID, userData[0].id]
        );

        console.log(rankingData, lastgamesData);

        // Generowanie strony
        res.render('ranking.ejs',{
            userInfo: userData[0],
            quizInfo: quizData[0],
            classInfo: classData[0],
            ranking: rankingData,
            lastgames: lastgamesData
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.get('/lecturer/class/:classID/quiz/:quizID/ranking', async(req, res) => {

    const classID = req.params.classID;
    const quizID = req.params.quizID;
    const login = req.session.username;

    try{
        
        // Pobieranie danych o użytkowniku
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        // Sprawdzanie, czy użytkownik nie jest studentem
        if(userData[0].isLecturer === 0){
            res.redirect('/');
            return;
        }

        // Pobieranie danych o quizie
        const [quizData] = await pool.query(
            "select * from quizes where id = ?;",
            quizID
        );

        // Pobieranie danych o przedmiocie
        const [classData] = await pool.query(
            "select * from classes where id = ?;",
            quizData[0].classID
        );

        // Pobieranie danych o rankingu
        const [rankingData] = await pool.query(
            "select u.login, u.firstName, u.lastName, u.imgName, g.result, g.correctQuestions, timestampdiff(second, g.startedDate, g.finishedDate) as durationSeconds, g.startedDate, g.finishedDate from games g join users u on g.userID = u.id where g.quizID = ? and g.id = ( select id from games g2 where g2.userID = g.userID and g2.quizID = g.quizID order by g2.correctQuestions desc, timestampdiff(second, g2.startedDate, g2.finishedDate) asc limit 1 ) order by g.correctQuestions desc, durationSeconds asc;",
            quizID
        );

        // Generowanie strony
        res.render('ranking.ejs',{
            userInfo: userData[0],
            quizInfo: quizData[0],
            classInfo: classData[0],
            ranking: rankingData,
            lastgames: null
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }

});

router.get('/lecturer/class/:classID/quiz/:quizID/edit', async(req, res) => {

    const classID = req.params.classID;
    const quizID = req.params.quizID;
    const login = req.session.username;

    try{
        
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        if(userData[0].isLecturer === 0){
            res.redirect('/');
            return;
        }

        const [classData] = await pool.query(
            "select * from classes where id = ?;",
            classID
        );

        const [quizData] = await pool.query(
            "select * from quizes where id = ?;",
            quizID
        );

        const [quizQuestions] = await pool.query(
            "select * from questions where quizID = ? order by questionNr;",
            quizID
        );
        
        res.render('lecturer-quiz.ejs',{
            userInfo: userData[0],
            classInfo: classData[0],
            quizInfo: quizData[0],
            allQuestions: quizQuestions
        });


        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.get('/lecturer/class/:classID/new_quiz', async(req, res) => {

    const classID = req.params.classID;
    const login = req.session.username;

    try{
        
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        if(userData[0].isLecturer === 0){
            return res.redirect('/');
        }

        const [classData] = await pool.query(
            "select * from classes where id = ?;",
            classID
        );

        if(classData[0].creatorID !== userData[0].id){
            return res.redirect('/');
        }
        
        res.render('add-new-quiz.ejs',{
            userInfo: userData[0],
            classInfo: classData[0]
        });


        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

module.exports = router;