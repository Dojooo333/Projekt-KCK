const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.get('/student/class/:id', async (req, res) => {
    const classID = req.params.id;
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

        const [userClassesData] = await pool.query(
            `select c.id, c.className, c.description, u.title, u.firstName, u.lastName
            from classes c
            left join users u on c.creatorID = u.id
            where c.id = ?;`,
            classID
        );

        const [quizes] = await pool.query(
            "select * from quizes where classID = ?;",
            classID
        );

        res.render('student-class.ejs',{
            userInfo: userData[0],
            classInfo: userClassesData[0],
            usersSession: req.session.quizes,
            quizesList: quizes
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.get('/lecturer/class/:id', async (req, res) => {
    const classID = req.params.id;
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

        res.send("Wybrano przedmiot o ID: " + classID);
        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

module.exports = router;