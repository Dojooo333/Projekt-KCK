const express = require('express');
const router = express.Router();
const pool = require('../db.js');

const requireLogin = require('../auth.js');
router.use(requireLogin);

router.get('/', async (req, res) => {

    const login = req.session.username;

    try{
        
        const [userData] = await pool.query(
            "select * from users where login = ?;",
            login
        );

        if(userData[0].isLecturer == 0){

            // Zwykły uczeń
            const [userClassesData] = await pool.query(
                `select c.id, c.className, c.description, cr.title, cr.firstName, cr.lastName
                from class_members
                left join users u on class_members.userID = u.id
                left join classes c on class_members.classID = c.id
                left join users cr on c.creatorID = cr.id where u.id = ?;`,
                [userData[0].id]
            );

            res.render('index.ejs',{
                userInfo: userData[0],
                userClasses: userClassesData
            });
            return;

        }else{

            // Prowadzący
            const [userClassesData] = await pool.query(
                `select id, className, description from classes where creatorID = ?;`,
                [userData[0].id]
            );

            res.render('index.ejs',{
                userInfo: userData[0],
                userClasses: userClassesData
            });
            return;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
    
});

module.exports = router;