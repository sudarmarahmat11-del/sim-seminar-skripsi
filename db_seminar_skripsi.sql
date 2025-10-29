
-- Database: db_seminar_skripsi
CREATE DATABASE IF NOT EXISTS db_seminar_skripsi;
USE db_seminar_skripsi;

-- Table: mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(20) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    prodi VARCHAR(100),
    angkatan YEAR,
    judul_skripsi TEXT
);

-- Table: dosen
CREATE TABLE dosen (
    id_dosen INT AUTO_INCREMENT PRIMARY KEY,
    nidn VARCHAR(20) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50),
    email VARCHAR(100),
    no_hp VARCHAR(20)
);

-- Table: seminar
CREATE TABLE seminar (
    id_seminar INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT,
    jenis ENUM('proposal', 'hasil', 'sidang') NOT NULL,
    tanggal DATE,
    waktu_mulai TIME,
    waktu_selesai TIME,
    ruangan VARCHAR(50),
    status ENUM('terjadwal', 'selesai', 'dibatalkan') DEFAULT 'terjadwal',
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa) ON DELETE CASCADE
);

-- Table: penguji
CREATE TABLE penguji (
    id_penguji INT AUTO_INCREMENT PRIMARY KEY,
    id_seminar INT,
    id_dosen INT,
    peran ENUM('pembimbing_1', 'pembimbing_2', 'penguji_1', 'penguji_2', 'ketua_penguji'),
    status_kehadiran ENUM('hadir', 'tidak hadir') DEFAULT 'hadir',
    FOREIGN KEY (id_seminar) REFERENCES seminar(id_seminar) ON DELETE CASCADE,
    FOREIGN KEY (id_dosen) REFERENCES dosen(id_dosen) ON DELETE CASCADE
);

-- Table: jadwal_conflict (optional)
CREATE TABLE jadwal_conflict (
    id_conflict INT AUTO_INCREMENT PRIMARY KEY,
    id_dosen INT,
    id_seminar_1 INT,
    id_seminar_2 INT,
    catatan TEXT,
    FOREIGN KEY (id_dosen) REFERENCES dosen(id_dosen),
    FOREIGN KEY (id_seminar_1) REFERENCES seminar(id_seminar),
    FOREIGN KEY (id_seminar_2) REFERENCES seminar(id_seminar)
);
