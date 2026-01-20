// Import modułów
const mysql = require('mysql2/promise')

// Informacje o połączeniu z bazą danych
const pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'kck',
    password: 'l4ce+=f$I$Rc',
    database: 'kck'
});

// Nawiązanie połączenia
pool.getConnection()
    .then(conn => {
        console.log('Connected to MySQL database.');
        conn.release();
    }).catch(err => {
        console.error('Database connection failed:\n' + err);
        return;
    });

// Export modułów
module.exports = pool;