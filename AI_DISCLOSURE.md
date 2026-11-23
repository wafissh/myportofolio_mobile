# AI Disclosure

Proyek ini dikembangkan dengan bantuan AI sebagai alat bantu pikir. AI membantu
menemukan penyebab masalah, menjelaskan langkah penyelesaian secara bertahap, serta
menyusun dokumentasi yang rapi.

## Penggunaan AI

- Menyusun struktur README, CHANGELOG, dan dokumen pendukung.
- Merapikan jawaban reflektif agar mudah dibaca.
- Membantu membuat `EducationFormPage`, aturan validasi bersama, dan widget test.
- Membantu menyesuaikan tata letak agar tetap dapat digulir pada layar sempit.

## Verifikasi Manual

Seluruh saran AI ditinjau dan diverifikasi secara manual sebelum di-commit:

```bash
dart format lib test
flutter analyze
flutter test
flutter build web
```

Alur formulir juga diuji dari kartu aksi dan drawer, termasuk input tidak valid,
input valid, penutupan dialog, dan kembali ke halaman utama.
