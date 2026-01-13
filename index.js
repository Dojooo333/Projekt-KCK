// Express
const express = require('express');
const app = express();
const port = 3000;
const path = require('path');

// Express session
const session = require('express-session');
app.use(session({
    secret: 'cQ@=0j9IdL74',
    resave: false,
    saveUninitialized: true,
    cookie: {
        secure: false,
        maxAge: 3600000
    }
}));

app.use(express.static('frontend'));
app.use('/bootstrap',express.static(path.join(__dirname,'node_modules/bootstrap/dist')));
app.use(express.urlencoded({ extended: true }));

// EJS
app.set('view engine', 'ejs');
app.set('views',path.join(__dirname,'/backend'));

// MySQL
const mysql = require('mysql2/promise')

const pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'kck',
    password: 'l4ce+=f$I$Rc',
    database: 'kck'
});

pool.getConnection()
    .then(conn => {
        console.log('Connected to MySQL database.');
        conn.release();
    }).catch(err => {
        console.error('Database connection failed:\n' + err);
        return;
    });

//RESTful
app.get('/', async (req, res) => {
    if(!(req.session && req.session.username)){
        res.redirect('/login');
        return;
    }

    const login = req.session.username;

    try{
        
        const [userData] = (await pool.query(
            "select * from users where login = ?;",
            login
        ));

        const [userClassesData] = await pool.query(
            `select c.id, c.className, c.description, cr.title, cr.firstName, cr.lastName
            from class_members
            left join users u on class_members.userID = u.id
            left join classes c on class_members.classID = c.id
            left join users cr on c.creatorID = cr.id where u.id = ?;`,
            [userData[0].id]
        );

        //console.log(userClassesData);

        console.log(userClassesData);

        res.render('index.ejs',{
            userInfo: userData[0],
            userClasses: userClassesData
        });

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
    
});

app.get('/login', async (req, res) => {

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

app.post('/login', (req, res) => {
    req.session.isLoggedIn = true;
    req.session.username = req.body['user-login'];

    res.redirect('/');

    console.log(req.body);
});

app.get('/logout', (req, res) => {
    req.session.destroy((err) => {
        if(err){
            console.error('Error during logout:\n', err);
            return res.status(500).send('Napotkano na błąd: nie udało się wylogować.');
        }

        res.clearCookie('connect.sid');
        res.redirect('/login');
    });
});

app.listen(port, () => {
    console.log(`Started listening at http://localhost:${port}`);
});