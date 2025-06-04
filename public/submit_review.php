<?php
// Konfigurasi koneksi
$host = "localhost";
$user = "postgres"; // ganti sesuai server kamu
$pass = "121212";     // ganti sesuai server kamu
$db = "MedicGIS";

$conn = pg_connect("host=$host dbname=$db user=$user password=$pass");

if (!$conn) {
    echo json_encode(["status" => "error", "message" => "Koneksi gagal"]);
    exit;
}

// Ambil data dari frontend
$data = json_decode(file_get_contents("php://input"), true);

$username = $data["username"] ?? '';
$komentar = $data["komentar"] ?? '';
$id_fasilitas = $data["id_fasilitas"] ?? '';// ambil dari URL nantinya
$tanggal = date("Y-m-d");
$rating = 5; // default rating jika tidak disediakan

if ($username && $komentar && $id_fasilitas) {
    $id_ulasan = uniqid("rev_");

    $query = "INSERT INTO ulasan (id_ulasan, username, id_fasilitas, komentar, rating, tanggal_ulasan)
              VALUES ($1, $2, $3, $4, $5, $6)";
    
    $result = pg_query_params($conn, $query, [
        $id_ulasan, $username, $id_fasilitas, $komentar, $rating, $tanggal
    ]);

    if ($result) {
        echo json_encode(["status" => "success"]);
    } else {
        echo json_encode(["status" => "error", "message" => pg_last_error()]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Input tidak lengkap"]);
}
?>