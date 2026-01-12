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
const mysql = require('mysql2')
const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'kck',
  password: 'l4ce+=f$I$Rc',
  database: 'kck'
});

connection.connect((err) => {
    if(err){
        console.error('Database connection failed:\n' + err);
        return;
    }
    console.log('Connected to MySQL database.');
});


//RESTful
app.get('/', (req, res) => {
    if(!(req.session && req.session.username)){
        res.redirect('/login');
    }else{
        res.send(`Zalogowano jako: ${req.session.username}`);
    }
});

app.get('/login', (req, res) => {

    if(req.session && req.session.username){
        res.redirect('/');
    }else{
        const query1 = 'select * from users;';
        connection.query(query1, (err, rows) => {
            if(err){
                return res.status(500).send('Error fatching data.');
            }

            //res.send(rows);
            res.render('login.ejs',{rows});
        });
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