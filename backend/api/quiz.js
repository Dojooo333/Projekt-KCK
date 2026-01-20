const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.post('/quiz', async(req, res) => {

    const login = req.session.username;

    try{
        
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        const [classID] = await pool.query(
            "select classID from quizes where id = ?;",
            req.body['quiz-id']
        );

        if(userData[0].isLecturer === 1){
            res.redirect('/lecturer/class/' + classID[0].classID + "/quiz/" + req.body['quiz-id']);
            return;
        }else{
            res.redirect('/student/class/' + classID[0].classID + "/quiz/" + req.body['quiz-id']);
            return;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

module.exports = router;