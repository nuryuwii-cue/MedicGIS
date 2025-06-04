const { Pool } = require("pg"); // Ganti Client → Pool

// Inisialisasi pool koneksi
const pool = new Pool({
  host: "localhost",
  user: "postgres",
  port: 5432,
  password: "121212",
  database: "MedicGIS",
});

module.exports = pool;

//  ini untuk menghubungkan database ke vs code, jangan lupa ubah path terminal ke folder ini caranya
// ketik cd "document/...." di terminal ya

// urutan hubungin database
// 1. bikin databasepg.js npm init -y lalu npm install pg
// 2. bikin server.js npm install express
// 3. bikin API untuk endpoint kolom yang panggil
// 4. bikin script fetch data di html
