const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.post('/class', async (req, res) => {
    const login = req.session.username;

    try{
        
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        if(userData[0].isLecturer === 1){
            res.redirect('/lecturer/class/' + req.body['class-id']);
            return;
        }else{
            res.redirect('/student/class/' + req.body['class-id']);
            return;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

module.exports = router;