const express = require('express');
const router = express.Router();
const pool = require('../db.js');

router.get('/login', async (req, res) => {

    if(req.session && req.session.username){
        res.redirect('/');
        return;
    }
    try{
        const query1 = 'select * from users;';
        const [users] = await pool.query(query1);

        res.render('login.ejs',{usersList: users});
    }catch(err){
        return res.status(500).send('Error fatching data.');
    }

});

router.post('/login', (req, res) => {
    req.session.isLoggedIn = true;
    req.session.username = req.body['user-login'];
    req.session.quizes = {};

    res.redirect('/');
});

router.get('/logout', (req, res) => {
    req.session.destroy((err) => {
        if(err){
            console.error('Error during logout:\n', err);
            return res.status(500).send('Napotkano na błąd: nie udało się wylogować.');
        }

        res.clearCookie('connect.sid');
        res.redirect('/login');
    });
});

module.exports = router;