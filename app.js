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
app.use(express.json());

// EJS
app.set('view engine', 'ejs');
app.set('views',path.join(__dirname,'/templates'));

// MySQL
const pool = require("./backend/db.js");

// Router
const index_route = require('./backend/routes/index.js');
const quiz_route = require('./backend/routes/quiz.js');
const class_route = require('./backend/routes/class.js');

const class_api = require('./backend/api/class.js');
const quiz_api = require('./backend/api/quiz.js');
const checkAnswer_api = require('./backend/api/check-answer.js');
const loginLogout_api = require('./backend/api/login-logout.js');

// Endpointy
app.get('/', index_route);
app.get('/student/class/:classID/quiz/:quizID', quiz_route);
app.get('/student/class/:classID/quiz/:quizID/ranking', quiz_route);
app.get('/student/class/:id', class_route);
app.get('/lecturer/class/:id', class_route);
app.get('/lecturer/class/:classID/quiz/:quizID/edit', quiz_route);
app.get('/lecturer/class/:classID/quiz/:quizID/ranking', quiz_route);
app.get('/lecturer/class/:classID/new_quiz', quiz_route);

app.post('/class', class_api);
app.post('/quiz', quiz_api);
app.post('/edit-quiz', quiz_api);
app.post('/quiz-edit/:quizID', quiz_api);
app.post('/check-answer/:quizID', checkAnswer_api);
app.post('/add-quiz/:classID', quiz_api);
app.post('/delete-quiz/:quizID', quiz_api);
app.post('/help/:quizID/5050', checkAnswer_api);
app.post('/help/:quizID/helpExpert', checkAnswer_api);
app.post('/help/:quizID/helpPublic', checkAnswer_api);

app.get('/login', loginLogout_api);
app.post('/login', loginLogout_api);
app.get('/logout', loginLogout_api);

// Uruchomienie aplikacji na porcie
app.listen(port, () => {
    console.log(`Started listening at http://localhost:${port}`);
});