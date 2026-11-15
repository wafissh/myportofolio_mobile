# Contributing

Terima kasih atas minatmu untuk berkontribusi pada MyPortfolio Mobile. Panduan ini
menjelaskan alur kerja, standar kode, dan hal-hal yang perlu diperhatikan sebelum
mengirimkan perubahan.

## Prasyarat

- Flutter SDK 3.50 atau lebih baru.
- Dart 3.14 atau lebih baru.
- Git.

## Menyiapkan Lingkungan

```bash
git clone https://github.com/wafissh/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
flutter analyze
flutter test
```

## Alur Kontribusi

1. Buat branch baru dari `main`:

   ```bash
   git checkout -b feat/nama-fitur
   ```

2. Lakukan perubahan secara terfokus. Hindari mencampur refactor besar dengan
   perbaikan kecil dalam satu commit.
3. Jalankan pemeriksaan kualitas sebelum commit:

   ```bash
   dart format lib test
   flutter analyze
   flutter test
   ```

4. Commit dengan pesan yang jelas (lihat konvensi di bawah).
5. Push branch dan buka Pull Request ke `main`.
6. Jelaskan apa yang diubah, mengapa, dan bagaimana cara memverifikasinya.

## Konvensi Commit

Gunakan [Conventional Commits](https://www.conventionalcommits.org/):

| Tipe       | Penggunaan                                      |
| ---------- | ----------------------------------------------- |
| `feat`     | Fitur baru                                      |
| `fix`      | Perbaikan bug                                   |
| `docs`     | Perubahan dokumentasi                           |
| `test`     | Menambah atau memperbaiki test                  |
| `refactor` | Perubahan kode tanpa mengubah perilaku          |
| `chore`    | Pemeliharaan, dependensi, konfigurasi           |
| `style`    | Formatting, spasi, titik koma (bukan logika)    |

Contoh:

```text
feat: tambahkan ItemCard untuk halaman Education
fix: cegah overflow pada InfoCard di layar sempit
docs: perbarui progres mingguan
```

## Standar Kode

- Ikuti gaya Dart resmi (`dart format`).
- Pertahankan `flutter analyze` tanpa issues.
- Setiap widget baru sebaiknya memiliki test widget bila memungkinkan.
- Gunakan `const` saat memungkinkan dan hindari logika berat di dalam `build`.
- Jangan menambahkan komentar yang hanya mengulang kode; jelaskan alasan, bukan
  cara.
- Jangan commit data pribadi, kunci API, atau berkas rahasia.

## Checklist Pull Request

- [ ] `flutter analyze` menghasilkan `No issues found!`.
- [ ] `flutter test` lulus.
- [ ] Perubahan sudah diuji pada minimal satu perangkat/emulator.
- [ ] Dokumentasi (`README.md`, `CHANGELOG.md`, `docs/`) diperbarui bila perlu.
- [ ] Tidak ada perubahan yang tidak terkait dalam diff.
- [ ] Jika menggunakan bantuan AI, baca dan lengkapi `AI_DISCLOSURE.md`.

## Melaporkan Masalah

Saat membuka issue, sertakan:

- Langkah untuk mereproduksi.
- Perilaku yang diharapkan dan yang terjadi.
- Versi Flutter/Dart (`flutter --version`).
- Platform (Android/iOS/web/desktop) dan tangkapan layar bila relevan.

## Lisensi Kontribusi

Dengan berkontribusi, kamu setuju bahwa hasil kontribusimu dilisensikan di bawah
lisensi MIT yang sama dengan proyek ini (lihat `LICENSE`).
