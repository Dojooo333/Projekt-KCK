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

router.post('/edit-quiz', async(req, res) => {

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
            res.redirect('/lecturer/class/' + classID[0].classID + "/quiz/" + req.body['quiz-id'] + '/edit');
            return;
        }else{
            res.redirect('/');
            return;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }
});

router.post('/quiz-edit/:quizID', async(req, res) => {
    
    const login = req.session.username;
    const newQuizData = req.body;
    const quizID = req.params.quizID;

    let connection;

    try{

        // Sprawdzenie, czy użytkownik przesyłający formularz, na pewno jest jego autorem
        const [quizAuthor] = await pool.query(
            "select q.id, q.classID, u.login from quizes q left join classes c on q.classID = c.id left join users u on c.creatorID = u.id where q.id = ?;",
            quizID
        );

        const classID = quizAuthor[0].classID;

        if(quizAuthor[0].login !== login){
            return res.send("Błąd! Nie jesteś autorem tego quizu.");
        }

        // Sprawdzenie, czy na pewno przesłano dane
        if(!newQuizData || !newQuizData.title || !newQuizData.difficulty || !newQuizData.questions || newQuizData.questions.length < 1 || !Array.isArray(newQuizData.questions)){
            return res.send("Błąd! Brakuje danych.");
        }

        // Sprawdzenie, czy przesłany tytuł jest poprawny
        if(typeof newQuizData.title !== 'string' || newQuizData.title.trim() === '' || newQuizData.title.length > 100){
            return res.send("Błąd! Przesłany tytuł jest niepoprawny.");
        }

        // Sprawdzenie, czy przesłany poziom trudności jest poprawny
        if(newQuizData.difficulty !== 'easy' && newQuizData.difficulty !== 'medium' && newQuizData.difficulty !== 'hard'){
            return res.send("Błąd! Przesłano niepoprawny poziom trudności.");
        }

        // Sprawdzenie, czy przesłano poprawny zbiór pytań
        for(const [index, q] of newQuizData.questions.entries()){
            // Treść pytania
            if(!q.question || q.question.trim() === '' || q.question.length > 500){
                return res.send("Błąd! Wykryto błędne pytania w zbiorze pytań.");
            }

            // Odpowiedzi na pytanie
            ['a','b','c','d'].forEach(letter => {
                if(!q[letter] || q[letter].trim() === '' || q[letter].length > 200){
                    return res.send("Błąd! Wykryto błędne odpowiedzi na pytania.");
                }
            });

            // Poprawna odpowiedź
            if(!q.correct || (q.correct !== 'a' && q.correct !== 'b' && q.correct !== 'c' && q.correct !== 'd')){
                return res.send("Błąd! Wykryto błędne poprawne odpowiedzi.");
            }
        };

        // Rozpoczęcie transakcji
        connection = await pool.getConnection();
        await connection.beginTransaction();

        try{

            // Update danych w tabeli quizes
            await connection.query(
                "update quizes set title = ?, difficulty = ?, questionsCount = ? where id = ?;",
                [newQuizData.title, newQuizData.difficulty, newQuizData.questions.length, quizID]
            );

            // Usunięcie danych z tabeli games
            await connection.query('delete from games where quizID = ?;', quizID);

            // Usunięcie starych danych z tabeli questions
            await connection.query(
                'delete from questions where quizID = ?;',
                quizID
            );

            // Przygotowanie nowych danych
            const newQuestions = newQuizData.questions.map((q, index) => [
                quizID,
                index + 1,
                q.question,
                q.a,
                q.b,
                q.c,
                q.d,
                q.correct
            ]);

            // Wstawnienie nowych danych
            await connection.query(
                "insert into questions (quizID, questionNr, question, answerA, answerB, answerC, answerD, correctAnswer) values ?;",
                [newQuestions]
            );

            // Zakończenie transakcji
            await connection.commit();

            return res.redirect(`/lecturer/class/${classID}`);


        }catch(error){
            await connection.rollback();
            throw transactionError;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }finally{
        if(connection) connection.release();
    }

});

router.post('/add-quiz/:classID', async(req, res) => {
    
    const login = req.session.username;
    const newQuizData = req.body;
    const classID = req.params.classID;

    let connection;

    try{

        // Sprawdzanie, czy użytkownik przesyłający formularz jest twórcą przedmiotu
        const [classAuthor] = await pool.query(
            "select c.id, c.creatorID, u.login from classes c left join users u on c.creatorID = u.id where c.id = ?;",
            classID
        );

        if(login !== classAuthor[0].login){
            return res.send("Błąd! Nie masz uprawnień do dodawania quizów w tym przedmiocie.");
        }

        // Sprawdzenie, czy na pewno przesłano dane
        if(!newQuizData || !newQuizData.title || !newQuizData.difficulty || !newQuizData.questions || newQuizData.questions.length < 1 || !Array.isArray(newQuizData.questions)){
            return res.send("Błąd! Brakuje danych.");
        }

        // Sprawdzenie, czy przesłany tytuł jest poprawny
        if(typeof newQuizData.title !== 'string' || newQuizData.title.trim() === '' || newQuizData.title.length > 100){
            return res.send("Błąd! Przesłany tytuł jest niepoprawny.");
        }

        // Sprawdzenie, czy przesłany poziom trudności jest poprawny
        if(newQuizData.difficulty !== 'easy' && newQuizData.difficulty !== 'medium' && newQuizData.difficulty !== 'hard'){
            return res.send("Błąd! Przesłano niepoprawny poziom trudności.");
        }

        // Sprawdzenie, czy przesłano poprawny zbiór pytań
        for(const [index, q] of newQuizData.questions.entries()){
            // Treść pytania
            if(!q.question || q.question.trim() === '' || q.question.length > 500){
                return res.send("Błąd! Wykryto błędne pytania w zbiorze pytań.");
            }

            // Odpowiedzi na pytanie
            ['a','b','c','d'].forEach(letter => {
                if(!q[letter] || q[letter].trim() === '' || q[letter].length > 200){
                    return res.send("Błąd! Wykryto błędne odpowiedzi na pytania.");
                }
            });

            // Poprawna odpowiedź
            if(!q.correct || (q.correct !== 'a' && q.correct !== 'b' && q.correct !== 'c' && q.correct !== 'd')){
                return res.send("Błąd! Wykryto błędne poprawne odpowiedzi.");
            }
        };

        // Rozpoczęcie transakcji
        connection = await pool.getConnection();
        await connection.beginTransaction();

        try{

            console.log(newQuizData);

            // Dodanie nowego quizu
            const [insertedQuiz] = await connection.query(
                "insert into quizes (classID, title, difficulty, questionsCount) values (?, ?, ?, ?);",
                [classID, newQuizData.title, newQuizData.difficulty, newQuizData.questions.length]
            );
            const quizID = insertedQuiz.insertId;

            // Przygotowanie nowych danych
            const newQuestions = newQuizData.questions.map((q, index) => [
                quizID,
                index + 1,
                q.question,
                q.a,
                q.b,
                q.c,
                q.d,
                q.correct
            ]);

            // Wstawnienie nowych danych
            await connection.query(
                "insert into questions (quizID, questionNr, question, answerA, answerB, answerC, answerD, correctAnswer) values ?;",
                [newQuestions]
            );

            // // Zakończenie transakcji
            await connection.commit();

            return res.redirect(`/lecturer/class/${classID}`);


        }catch(error){
            await connection.rollback();
            throw transactionError;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }finally{
        if(connection) connection.release();
    }

});


router.post('/delete-quiz/:quizID', async(req, res) => {
    
    const login = req.session.username;
    const quizID = req.params.quizID;

    let connection;

    try{

        // Sprawdzanie, czy użytkownik przesyłający formularz jest twórcą przedmiotu
        const [quizAuthor] = await pool.query(
            "select q.id, q.classID, u.login from quizes q left join classes c on q.classID = c.id left join users u on c.creatorID = u.id where q.id = ?;",
            quizID
        );

        if(login !== quizAuthor[0].login){
            return res.send("Błąd! Nie masz uprawnień do usuwania quizów w tym przedmiocie.");
        }

        // Rozpoczęcie transakcji
        connection = await pool.getConnection();
        await connection.beginTransaction();

        try{

            // Usunięcie pytań quizu
            await connection.query('delete from questions where quizID = ?;', quizID);

            // Usunięcie gier
            await connection.query('delete from games where quizID = ?;', quizID);

            // Usunięcie quizu
            await connection.query('delete from quizes where id = ?;', quizID);

            // Zakończenie transakcji
            await connection.commit();

            return res.redirect(`/lecturer/class/${quizAuthor[0].classID}`);

        }catch(error){
            await connection.rollback();
            throw transactionError;
        }

    }catch(err){
        return res.status(500).send('Error fatching data.');
    }finally{
        if(connection) connection.release();
    }

});

module.exports = router;