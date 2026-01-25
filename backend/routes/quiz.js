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
                allQuestions: quizData[0].questionsCount
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

        //console.log(quizData[0]);


        // if(req.session.quizes[quizID] === undefined){
        //     req.session.quizes[quizID] = {
        //         currentQuestion: 0,
        //         allQuestions: quizData[0].questionsCount
        //     }
        // }
        
        // const [questionsData] = await pool.query(
        //     "select question, answerA, answerB, answerC, answerD from questions where quizID = ? and questionNr = ?;",
        //     [quizID, (req.session.quizes[quizID].currentQuestion+1)]
        // );

        //console.log(classData[0]);
        
        res.render('lecturer-quiz.ejs',{
            userInfo: userData[0],
            classInfo: classData[0],
            quizInfo: quizData[0],
            allQuestions: quizQuestions
            //quizInfo: quizData[0],
            //question: questionsData[0],
            //sessionDetails: req.session.quizes[quizID]
        });


        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

module.exports = router;