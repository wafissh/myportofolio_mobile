# Progres Mingguan

Dokumen ini mencatat progres pengembangan proyek **MyPortfolio Mobile** per minggu.
Tujuannya agar riwayat pekerjaan mudah ditelusuri, baik oleh penulis, dosen, maupun
kontributor lain.

- **Repositori:** <https://github.com/wafissh/myportofolio_mobile>
- **Mata kuliah:** Pengembangan Berbasis Platform (PBP)
- **Penulis:** Wien Muhammad Hafizhurrohman (2506624461, PBP E)

## Ringkasan

| Minggu | Tanggal | Fokus | Status |
| ------ | ------- | ----- | ------ |
| 1 | 11 November 2026 | Setup Flutter dan Tutorial 08 | Selesai |
| 2 | 15 November 2026 | Tutorial 09 dan dokumentasi open-source | Selesai |

## Minggu 1 — 11 November 2026

**Fokus:** menyiapkan lingkungan Flutter dan menyelesaikan Tutorial 08.

### Aktivitas

- Memasang Flutter SDK dan memeriksa lingkungan dengan `flutter doctor`.
- Membuat proyek `myportofolio_mobile` dan menginisialisasi repositori Git.
- Menyusun `lib/main.dart` sebagai bootstrap (`runApp` + `MaterialApp`).
- Memisahkan widget halaman utama ke `lib/menu.dart`.
- Membuat `MyHomePage` sebagai `StatelessWidget`.
- Membuat tiga `InfoCard` (data contoh) dan tiga `ItemCard`:
  Lihat Proyek, Tambah Proyek, dan Logout.
- Menambahkan `SnackBar` saat `ItemCard` ditekan.

### Komit

- `5e7737f` — first commit
- `c9a505b` — install flutter
- `38bebbd` — tutorial flutter selesai

### Kendala

- Konfigurasi awal Flutter pada Windows memerlukan penyesuaian `PATH` dan
  penerimaan lisensi Android.
- Pemahaman awal tentang `BuildContext` dan widget tree masih terbatas.

### Pelajaran

- `MaterialApp` harus menjadi root agar `Scaffold`, tema, dan navigasi bekerja.
- `StatelessWidget` cukup untuk halaman yang datanya tidak berubah.

## Minggu 2 — 15 November 2026

**Fokus:** menyelesaikan Tutorial 09, merapikan kualitas kode, dan menyiapkan
dokumentasi repositori.

### Aktivitas

- Mengisi identitas pemilik yang sebenarnya pada `InfoCard`: NPM, nama, dan kelas.
- Menambahkan properti `color` pada `ItemHomepage` agar setiap `ItemCard` memiliki
  warna latar unik (biru, hijau, merah).
- Memastikan `SnackBar` menampilkan
  `Kamu telah menekan tombol [Nama Tombol]!`.
- Menjalankan `flutter analyze` dan memperbaiki tiga peringatan deprecation dengan
  bermigrasi ke paket `material_ui`.
- Mengganti widget test bawaan dengan test untuk profil, tombol, dan `SnackBar`.
- Menulis ulang `README.md`: cara menjalankan, struktur proyek, dan enam jawaban
  pertanyaan reflektif.
- Menambahkan dokumentasi open-source: `CHANGELOG.md`, `CONTRIBUTING.md`,
  `LICENSE`, `docs/weekly-progress.md`, dan `AI_DISCLOSURE.md`.

### Komit

- `c989c35` — feat: perbarui data profil pemilik portofolio
- `70dd9aa` — chore: migrasi ke package material_ui
- `e503bc6` — feat: warna unik untuk setiap ItemCard
- `9a8f8b7` — test: perbarui widget test untuk halaman menu
- `f3dda25` — docs: README panduan menjalankan proyek dan jawaban reflektif

### Hasil Verifikasi

| Pemeriksaan | Hasil |
| ----------- | ----- |
| `flutter analyze` | `No issues found!` |
| `flutter test` | 2 test lulus |
| `git status` | Bersih dan sinkron dengan `origin/main` |

### Kendala

- Flutter 3.50 mendeprekasi `package:flutter/material.dart`; solusi yang benar adalah
  migrasi ke `package:material_ui/material_ui.dart`, bukan menyembunyikan peringatan.
- Perubahan line ending (CRLF/LF) pada berkas generated Windows/Linux/macOS sempat
  muncul sebagai diff palsu dan perlu dibersihkan.

### Pelajaran

- Peringatan analyzer harus diverifikasi terhadap versi SDK yang benar-benar
  terpasang, bukan diasumsikan dari pengetahuan umum.
- Perubahan kecil sebaiknya di-commit secara bertahap agar riwayat mudah dibaca.
- Dokumentasi dan pengujian adalah bagian dari definisi "selesai", bukan tambahan.

## Rencana Minggu Berikutnya

- [ ] Menambahkan navigasi dari `ItemCard` ke halaman daftar portofolio.
- [ ] Membuat form tambah portofolio dan menyimpan data.
- [ ] Menambahkan `ItemCard` untuk Education/Skills.
- [ ] Menguji tampilan pada perangkat fisik dan memeriksa aksesibilitas
      (kontras warna, ukuran target sentuh, TalkBack/VoiceOver).
- [ ] Memperbarui `AI_DISCLOSURE.md` bila bantuan AI digunakan kembali.

## Cara Memperbarui Dokumen Ini

1. Tambahkan bagian `## Minggu N — <tanggal>` di atas bagian rencana.
2. Isi aktivitas, komit terkait, kendala, dan pelajaran.
3. Perbarui tabel ringkasan.
4. Jalankan `flutter analyze` dan `flutter test` sebelum commit.
5. Commit dengan tipe `docs`, misalnya `docs: perbarui progres minggu 3`.
