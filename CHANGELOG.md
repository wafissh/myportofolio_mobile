# Changelog

Semua perubahan penting pada proyek ini didokumentasikan di berkas ini.

Format mengikuti [Keep a Changelog](https://keepachangelog.com/id/1.1.0/) dan
[Semantic Versioning](https://semver.org/lang/id/).

## [Unreleased]

### Rencana

- Navigasi ke halaman daftar dan form tambah portofolio.
- Penyimpanan data portofolio secara lokal (misalnya `shared_preferences`) atau
  melalui API.
- Menambahkan `ItemCard` keempat untuk bagian Education/Skills.

## [1.1.0] - 2026-11-15

Rilis Tutorial 09: pemisahan widget halaman utama, profil pemilik, warna aksi,
pengujian, dan dokumentasi repositori.

### Added

- `InfoCard` menampilkan identitas pemilik: NPM, nama lengkap, dan kelas.
- Warna latar unik untuk setiap `ItemCard` (biru, hijau, dan merah).
- Properti `color` pada model `ItemHomepage` sebagai sumber warna tiap kartu.
- Widget test untuk memverifikasi informasi profil, tombol aksi, dan `SnackBar`.
- Dokumentasi open-source: `README.md`, `CHANGELOG.md`, `CONTRIBUTING.md`,
  `LICENSE`, `docs/weekly-progress.md`, dan `AI_DISCLOSURE.md`.
- Jawaban enam pertanyaan reflektif pada `README.md`.

### Changed

- `main.dart` hanya menjadi bootstrap; seluruh widget halaman utama berada di
  `lib/menu.dart`.
- `MyHomePage` dipertahankan sebagai `StatelessWidget` karena data bersifat statis.
- Migrasi import dari `package:flutter/material.dart` ke
  `package:material_ui/material_ui.dart` dan menambahkan dependensi
  `material_ui: ^1.1.0`.
- Pesan `SnackBar` mengikuti nama tombol yang ditekan:
  `Kamu telah menekan tombol [Nama Tombol]!`.

### Fixed

- Menghilangkan tiga peringatan deprecation pada `flutter analyze` sehingga
  hasilnya `No issues found!`.
- Mengganti widget test bawaan (tes counter) yang sudah tidak relevan.

## [1.0.0] - 2026-11-11

Rilis Tutorial 08: aplikasi portofolio mobile pertama.

### Added

- Proyek Flutter `myportofolio_mobile` beserta konfigurasi platform Android,
  iOS, web, Windows, Linux, dan macOS.
- `MyHomePage` sebagai `StatelessWidget` di `lib/menu.dart`.
- Tiga `InfoCard` dan tiga `ItemCard` contoh: Lihat Proyek, Tambah Proyek,
  dan Logout.
- `SnackBar` sederhana saat `ItemCard` ditekan.
- Tema aplikasi melalui `MaterialApp` dan `ColorScheme.fromSeed`.

[Unreleased]: https://github.com/wafissh/myportofolio_mobile/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/wafissh/myportofolio_mobile/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/wafissh/myportofolio_mobile/releases/tag/v1.0.0
