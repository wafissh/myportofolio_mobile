# AI Disclosure

Dokumen ini menjelaskan secara terbuka bagaimana kecerdasan artifisial (AI) digunakan
dalam proyek **MyPortfolio Mobile**, keterbatasan AI yang nyata, serta koreksi dan
verifikasi manual yang dilakukan. Tujuannya bukan sekadar formalitas, melainkan agar
pembaca dapat menilai kontribusi manusia dan mesin secara jujur.

## Ringkasan

Proyek ini dikerjakan dengan bantuan asisten AI untuk **brainstorming, penulisan
kode awal, migrasi API, dan penyusunan draf dokumentasi**. Keputusan akhir, data
identitas, pemilihan pendekatan, serta verifikasi hasil tetap dilakukan oleh penulis.

AI **tidak** dianggap sebagai penulis atau pengganti pemahaman. Seluruh kode dan
pernyataan dalam repositori ini tetap menjadi tanggung jawab penulis.

## Cakupan Bantuan AI

| Area | Bantuan AI | Peran manusia |
| ---- | ---------- | ------------- |
| Setup dan struktur | Menyarankan pemisahan `main.dart` dan `menu.dart` | Menjalankan, memeriksa, dan menerima struktur |
| Migrasi API | Menemukan deprecation dan menyiapkan perubahan ke `material_ui` | Memilih migrasi yang benar (bukan menonaktifkan lint) |
| Warna `ItemCard` | Menambahkan field `color` dan nilai awal | Menentukan warna dan memeriksa keterbacaan |
| Pengujian | Menyusun draf widget test | Menjalankan `flutter test` dan meninjau relevansi |
| Dokumentasi | Menyusun draf README, CHANGELOG, CONTRIBUTING, dan dokumen ini | Meninjau, mengoreksi, dan menyetujui isi |
| Data profil | Menempelkan data ke `InfoCard` | Menyediakan dan memverifikasi data yang benar |

## Keterbatasan AI yang Teridentifikasi

Bagian ini menyoroti keterbatasan secara kritis, bukan sekadar daftar umum.

### 1. Pengetahuan AI tidak otomatis sesuai lingkungan

Saat audit awal, AI menganggap `package:flutter/material.dart` adalah import yang
wajar. Kenyataannya, Flutter 3.50 yang terpasang **mendeprekasi** import tersebut.
Peringatan baru muncul setelah `flutter analyze` dijalankan. AI kemudian harus
memeriksa template resmi Flutter dan isi pub cache untuk memastikan
`package:material_ui/material_ui.dart` memang penggantinya.

**Implikasi:** jawaban AI bisa benar secara umum tetapi salah untuk versi SDK yang
sedang dipakai. Verifikasi dengan alat nyata wajib dilakukan.

### 2. AI dapat melewatkan persyaratan yang tampak jelas

Pada pembacaan awal, AI melihat `menu.dart` sudah "lengkap" dan hampir melewatkan
fakta bahwa **ketiga `ItemCard` memakai satu warna yang sama**, padahal tugas
mensyaratkan warna berbeda. Kekeliruan ini baru tertangkap saat mencocokkan kode
dengan checklist secara eksplisit.

**Implikasi:** AI cenderung memberi penilaian cepat berdasarkan pola, bukan audit
menyeluruh. Checklist manusia tetap penting.

### 3. AI memilih jalan pintas yang tidak selalu tepat

Ketika menghadapi peringatan deprecation, AI sempat menawarkan solusi
menonaktifkan lint `deprecated_member_use`. Solusi itu membuat analyzer "bersih"
tetapi menyembunyikan masalah. Penulis memilih migrasi ke `material_ui` yang lebih
benar dan berkelanjutan.

**Implikasi:** AI dapat mengoptimalkan metrik (misalnya "No issues found") tanpa
memperbaiki akar masalah. Keputusan arsitektural tetap milik manusia.

### 4. AI tidak dapat menilai tampilan secara visual

Widget test membuktikan bahwa teks dan tombol **ada**, tetapi tidak membuktikan
bahwa tampilan **enak dilihat**: kontras warna, tata letak saat layar sempit,
overlap, atau ukuran target sentuh. AI tidak dapat melihat emulator atau perangkat.

**Implikasi:** verifikasi visual dan aksesibilitas harus dilakukan manusia, idealnya
dengan pembaca layar dan alat pemeriksa kontras.

### 5. AI tidak memahami konteks akademik dan aturan penilaian

Instruksi tugas sempat terpotong (format README tidak lengkap). AI tidak boleh
menebak; ia harus bertanya atau memilih format yang wajar dan transparan. AI juga
tidak mengetahui batas penggunaan AI yang diizinkan dosen.

**Implikasi:** kepatuhan terhadap aturan akademik dan integritas karya adalah
tanggung jawab penulis. Dokumen ini disediakan sebagai bentuk keterbukaan.

### 6. AI tidak menjamin kebenaran data pribadi

NPM, nama, dan kelas tidak boleh dikarang. Data awal pada proyek masih memakai
contoh (Burhan) dan harus diganti dengan data pemilik yang sebenarnya.

**Implikasi:** data identitas diverifikasi manusia; AI hanya menempatkannya di kode.

### 7. AI dapat menghasilkan noise teknis

Saat dependensi berubah, berkas generated untuk Windows/Linux/macOS tampak berubah
karena perbedaan line ending (CRLF vs LF), meskipun isinya sama. Hal ini dapat
mengotori riwayat commit bila tidak dibersihkan.

**Implikasi:** penulis perlu memeriksa `git diff` dan membersihkan perubahan yang
tidak relevan sebelum commit.

## Perbaikan dan Verifikasi Manual

Berikut tindakan yang dilakukan manusia atau diverifikasi secara sadar, bukan
sekadar menerima keluaran AI:

1. **Data identitas** — NPM `2506624461`, nama, dan kelas `PBP E` diisi serta
   diverifikasi oleh penulis.
2. **Keputusan migrasi** — memilih migrasi ke `material_ui` alih-alih menonaktifkan
   lint deprecation.
3. **Pemeriksaan analyzer** — menjalankan `flutter analyze` hingga benar-benar
   menghasilkan `No issues found!` pada SDK yang terpasang.
4. **Pengujian** — menjalankan `flutter test` dan memastikan dua test relevan lulus.
5. **Kebersihan riwayat Git** — membersihkan perubahan line ending pada berkas
   generated dan memastikan `git status` bersih.
6. **Peninjauan dokumentasi** — membaca ulang README dan dokumen pendukung agar
   sesuai dengan kondisi proyek, bukan sekadar draf generik.
7. **Pemilihan warna** — memakai `shade600` dengan teks putih agar kontras lebih
   baik; tetap perlu dicek dengan alat kontras sebelum rilis.
8. **Commit bertahap** — memecah pekerjaan menjadi commit `feat`, `chore`, `test`,
   dan `docs` agar mudah ditelusuri.

## Yang Belum Diverifikasi oleh AI

- Tampilan pada perangkat/emulator nyata (layout, overflow, estetika).
- Kontras warna dengan alat ukur aksesibilitas (WCAG).
- Perilaku dengan TalkBack/VoiceOver dan ukuran font besar.
- Performa aplikasi dan penggunaan memori.
- Kesesuaian dengan ketentuan akademik mata kuliah.

Poin-poin tersebut perlu diselesaikan penulis sebelum menyerahkan tugas.

## Prinsip Penggunaan AI

- AI digunakan sebagai alat bantu, bukan pengganti pemahaman.
- Setiap keluaran AI dibaca, diuji, dan dipertanggungjawabkan.
- Data pribadi dan keputusan akhir tidak diserahkan kepada AI.
- Penggunaan AI didokumentasikan secara terbuka (dokumen ini).
- Jika bantuan AI digunakan lagi, bagian "Cakupan Bantuan AI" dan "Perbaikan dan
  Verifikasi Manual" akan diperbarui.

## Pernyataan

Saya menyatakan bahwa saya memahami kode dalam proyek ini, telah menjalankan serta
memverifikasi hasilnya, dan menggunakan AI secara bertanggung jawab sesuai ketentuan
yang berlaku.

— Wien Muhammad Hafizhurrohman, 15 November 2026
