// app.js (ini API pake express)
const express = require("express");
const pool = require("./db.js"); // koneksi ke PostgreSQL

const app = express();
app.use(express.json());
const path = require("path");
const bodyParser = require("body-parser");

require("dotenv").config();

// Contoh penggunaan
console.log(process.env.DB_HOST); // Output: localhost

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Enable CORS (untuk development)
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

// Serve static files (html, css, images, js) dari folder 'public'
app.use(express.static(path.join(__dirname, "public")));

// Endpoint pencarian fasilitas kesehatan berdasarkan keyword
app.get("/search", async (req, res) => {
  const keyword = req.query.q;
  try {
    const result = await pool.query(
      `SELECT fk.id_fasilitas, fk.nama_fasilitas, fk.jam_operasional, fk.jumlah_ulasan, fk.url_foto, ST_X(ST_Transform(fk.koordinat_fasilitas, 4326)) AS longitude,
  ST_Y(ST_Transform(fk.koordinat_fasilitas, 4326)) AS latitude
       FROM fasilitas_kesehatan fk
       JOIN kategori k ON fk.id_kategori = k.id_kategori
       WHERE LOWER(fk.nama_fasilitas) LIKE LOWER($1)`,
      [`%${keyword}%`]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint Semua Fasilitas
app.get("/semua-fasilitas", async (req, res) => {
  const idsemua = req.query.semua;
  try {
    const result = await pool.query(
      `SELECT fk.id_fasilitas, fk.nama_fasilitas, fk.jam_operasional, fk.jumlah_ulasan, ST_X(ST_Transform(fk.koordinat_fasilitas, 4326)) AS longitude,
  ST_Y(ST_Transform(fk.koordinat_fasilitas, 4326)) AS latitude
       FROM fasilitas_kesehatan fk`,
      [idsemua]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint Berdasarkan kategori
app.get("/by-kategori", async (req, res) => {
  const idKategori = req.query.kategori;
  try {
    const result = await pool.query(
      `SELECT fk.id_fasilitas, fk.nama_fasilitas, fk.jam_operasional, fk.jumlah_ulasan, ST_X(ST_Transform(fk.koordinat_fasilitas, 4326)) AS longitude,
  ST_Y(ST_Transform(fk.koordinat_fasilitas, 4326)) AS latitude
       FROM fasilitas_kesehatan fk
       WHERE fk.id_kategori = $1`,
      [idKategori]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint Detail Fasilitas
app.get("/detail", async (req, res) => {
  const id = parseInt(req.query.id, 10);
  if (isNaN(id)) {
    return res.status(400).json({ error: "ID tidak valid" });
  }

  try {
    const result = await pool.query(
      `SELECT 
        fk.id_fasilitas,
        fk.nama_fasilitas,
        fk.jam_operasional,
        fk.jumlah_ulasan,
        fk.kontak,
        fk.website,
        fk.alamat,
        fk.url_foto,
        k.nama_kategori,
        ST_X(ST_Transform(fk.koordinat_fasilitas, 4326)) AS longitude,
  ST_Y(ST_Transform(fk.koordinat_fasilitas, 4326)) AS latitude
      FROM 
        fasilitas_kesehatan fk
      JOIN 
        kategori k ON fk.id_kategori = k.id_kategori
      WHERE fk.id_fasilitas = $1`,
      [id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk menambahkan ulasan
app.post("/ulasan", async (req, res) => {
  const { username, komentar, rating } = req.body;
  const id_fasilitas = parseInt(req.query.id, 10); // Mengambil id_fasilitas dari query parameter

  if (!username || !komentar || !rating || !id_fasilitas) {
    return res.status(400).json({
      error: "Username, komentar, rating, and id_fasilitas are required.",
    });
  }

  // Mendapatkan tanggal saat ini
  const tanggal_ulasan = new Date().toISOString().slice(0, 10); // Format YYYY-MM-DD

  // Generate id_ulasan otomatis (misalnya, menggunakan timestamp atau UUID)
  // Untuk contoh ini, kita akan menggunakan timestamp sederhana + beberapa digit random
  const id_ulasan = `ulasan_${Date.now()}_${Math.floor(Math.random() * 1000)}`;

  try {
    const client = await pool.connect();
    const query = `
            INSERT INTO ulasan (id_ulasan, id_fasilitas, username, komentar, rating, tanggal_ulasan)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING *;
        `;
    const values = [
      id_ulasan,
      id_fasilitas,
      username,
      komentar,
      rating,
      tanggal_ulasan,
    ];
    const result = await client.query(query, values);
    client.release(); // Melepaskan koneksi kembali ke pool

    res
      .status(201)
      .json({ message: "Ulasan berhasil ditambahkan", data: result.rows[0] });
  } catch (err) {
    console.error("Error saat menambahkan ulasan:", err);
    res
      .status(500)
      .json({ error: "Terjadi kesalahan server saat menambahkan ulasan." });
  }
});

app.listen(3000, () => {
  console.log("Server jalan di http://localhost:3000");
});

pool
  .query("SELECT NOW()")
  .then(() => console.log("Connected to PostgreSQL"))
  .catch((err) => console.error("Database connection failed:", err));
