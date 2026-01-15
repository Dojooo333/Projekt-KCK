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

app.post('/class', async (req, res) => {

    if(!(req.session && req.session.username)){
        res.redirect('/login');
        return;
    }
    
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

app.post('/quiz', async(req, res) => {
    if(!(req.session && req.session.username)){
        res.redirect('/login');
        return;
    }
    
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

app.get('/student/class/:classID/quiz/:quizID', async(req, res) => {
    const classID = req.params.classID;
    const quizID = req.params.quizID;

    if(!(req.session && req.session.username)){
        res.redirect('/login');
        return;
    }
    
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
            "select * from questions where quizID = ?;",
            quizID
        );
        
        const [questions] = await pool.query(
            "select * from questions where quizID = ?;",
            quizID
        );

        console.log(questions);

        res.send(`Wybrano quiz o ID: ${quizID} w ramach przedmiotu o ID: ${classID}`);
        
        res.render('student-quiz.ejs',{
            userInfo: userData[0],
            classInfo: userClassesData[0],
            quizesList: quizes
        });


        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

app.get('/student/class/:id', async (req, res) => {
    const classID = req.params.id;

    if(!(req.session && req.session.username)){
        res.redirect('/login');
        return;
    }
    
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

        //res.send("Wybrano przedmiot o ID: " + classID);
        const [quizes] = await pool.query(
            "select * from quizes where classID = ?;",
            classID
        );

        console.log(quizes[0].id);

        res.render('student-class.ejs',{
            userInfo: userData[0],
            classInfo: userClassesData[0],
            quizesList: quizes
        });

        return;

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});


app.get('/lecturer/class/:id', async (req, res) => {
    const classID = req.params.id;

    if(!(req.session && req.session.username)){
        res.redirect('/login');
        return;
    }
    
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