# MyPortfolio Mobile

![Flutter](https://img.shields.io/badge/Flutter-3.50-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.14-0175C2?logo=dart&logoColor=white)
![flutter analyze](https://img.shields.io/badge/flutter%20analyze-passing-brightgreen)
![tests](https://img.shields.io/badge/tests-11%20passing-brightgreen)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

Aplikasi Flutter sederhana untuk menampilkan portofolio pribadi. Proyek ini merupakan
kelanjutan dari **Tutorial 08** dan tetap menggunakan repositori GitHub yang sama,
terpisah dari repositori proyek Django.

Pada **Tutorial 09**, aplikasi dilengkapi drawer menu, navigasi antarhalaman, serta
form tambah proyek dengan validasi input. Kode halaman dipisahkan ke direktori
`lib/screens/`, sedangkan widget yang dapat digunakan ulang berada di `lib/widgets/`.

Pada **Tutorial 10**, ditambahkan formulir baru untuk bagian portofolio **Pendidikan**
dengan input teks, dropdown, dan pemilih tanggal (`showDatePicker`). Formulir memakai
validasi wajib-isi, batas panjang, format URL, serta urutan tanggal, lalu menampilkan
ringkasan melalui `AlertDialog`. Formulir dapat dibuka dari kartu aksi di halaman utama
maupun dari drawer.

## Identitas Pemilik

| Informasi | Nilai |
| --------- | ----- |
| NPM       | 2506624461 |
| Nama      | Wien Muhammad Hafizhurrohman |
| Kelas     | PBP E |

## Fitur

- Tiga `InfoCard` di bagian atas: **NPM**, **Name**, dan **Class**.
- Empat `ItemCard` aksi: **Lihat Proyek**, **Tambah Proyek**, **Tambah Pendidikan**,
  dan **Logout**.
- Setiap `ItemCard` memiliki warna latar unik (biru, hijau, oranye, merah) agar kontras.
- Menekan `ItemCard` menampilkan `SnackBar` dengan pesan
  `Kamu telah menekan tombol [Nama Tombol]!`.
- Tombol **Tambah Proyek** membuka `ProjectFormPage` melalui `Navigator.push`.
- Tombol **Tambah Pendidikan** membuka `EducationFormPage` melalui `Navigator.push`.
- Drawer menu (`LeftDrawer`) berisi header aplikasi, navigasi **Home**,
  **Add Project**, dan **Add Education**; drawer yang sama dipakai di semua halaman.
- Opsi **Home** memakai `Navigator.pushAndRemoveUntil` sehingga kembali ke satu
  halaman utama dari halaman form mana pun.
- Form tambah proyek memiliki field nama, deskripsi, kategori (`DropdownButtonFormField`),
  teknologi, dan tautan; nama/deskripsi/teknologi wajib diisi dengan batas panjang,
  sedangkan tautan divalidasi format `http/https`.
- Form pendidikan memiliki field nama institusi, jenjang (`DropdownButtonFormField`),
  jurusan, tanggal mulai, tanggal selesai (`showDatePicker`), dan website opsional.
- Validasi pendidikan menolak isian kosong/spasi, membatasi panjang `3–100` karakter,
  memeriksa format URL, dan memastikan tanggal selesai tidak mendahului tanggal mulai.
- Halaman utama dan form memakai `SingleChildScrollView` agar semua input serta tombol
  Simpan tetap terjangkau pada layar sempit atau saat papan ketik tampil.
- Tombol **Save/Simpan** memanggil `FormState.validate()` lalu menampilkan seluruh isian
  melalui `AlertDialog` hanya jika valid; tombol **OK** menutup dialog dan kembali ke form.
- `MyHomePage` berupa `StatelessWidget` karena data profil dan daftar menu bersifat tetap.
- Widget test untuk memastikan profil, tombol, `SnackBar`, navigasi, akses form dari
  kartu/drawer, validasi, dialog ringkasan, dan alur kembali Home berjalan benar.

## Dokumentasi

| Dokumen | Isi |
| ------- | --- |
| [`docs/weekly-progress.md`](docs/weekly-progress.md) | Progres pengembangan per minggu |
| [`CHANGELOG.md`](CHANGELOG.md) | Riwayat rilis dan perubahan |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Panduan kontribusi dan konvensi commit |
| [`AI_DISCLOSURE.md`](AI_DISCLOSURE.md) | Keterbukaan penggunaan AI dan verifikasi manual |
| [`LICENSE`](LICENSE) | Lisensi MIT |

## Prasyarat

- Flutter SDK 3.50 atau lebih baru (proyek memakai paket `material_ui`).
- Dart 3.14 atau lebih baru (mengikuti Flutter SDK).
- Perangkat/emulator Android, browser (Chrome), atau desktop (Windows/macOS/Linux).

Cek versi yang terpasang:

```bash
flutter --version
flutter doctor
```

## Cara Menjalankan Proyek

1. Clone repositori:

   ```bash
   git clone https://github.com/wafissh/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

2. Pasang dependensi:

   ```bash
   flutter pub get
   ```

3. Lihat perangkat yang tersedia:

   ```bash
   flutter devices
   ```

4. Jalankan aplikasi:

   ```bash
   # Pilih perangkat secara otomatis
   flutter run

   # Atau tentukan perangkat tertentu
   flutter run -d chrome
   flutter run -d windows
   flutter run -d emulator-5554
   ```

5. Perintah kualitas kode dan pengujian:

   ```bash
   flutter analyze   # harus menampilkan "No issues found!"
   flutter test      # menjalankan widget test
   ```

6. Build aplikasi (opsional):

   ```bash
   flutter build web --release
   flutter build apk --release
   flutter build windows --release
   ```

## Struktur Proyek

```text
myportofolio_mobile/
├── lib/
│   ├── screens/
│   │   ├── menu.dart          # MyHomePage, InfoCard, ItemHomepage
│   │   ├── project_form.dart  # ProjectFormPage dan form tambah proyek
│   │   └── education_form.dart  # EducationFormPage dan form pendidikan
│   ├── utils/
│   │   └── validators.dart    # Validasi wajib isi, panjang, dan format URL
│   ├── widgets/
│   │   ├── left_drawer.dart   # Drawer menu navigasi
│   │   └── project_card.dart  # ItemCard untuk tombol aksi
│   └── main.dart              # Bootstrap aplikasi: runApp + MaterialApp
├── test/
│   └── widget_test.dart       # Widget test menu, navigasi, dan form
├── docs/
│   └── weekly-progress.md     # Catatan progres mingguan
├── AI_DISCLOSURE.md           # Keterbukaan penggunaan AI
├── CHANGELOG.md               # Riwayat perubahan
├── CONTRIBUTING.md            # Panduan kontribusi
├── LICENSE                    # Lisensi MIT
├── pubspec.yaml               # Dependensi (flutter, material_ui, cupertino_icons)
└── README.md
```

## Catatan Implementasi

- Sejak Flutter 3.47, `package:flutter/material.dart` dideprekasi dan digantikan oleh
  `package:material_ui/material_ui.dart`. Proyek ini memakai `material_ui` agar
  `flutter analyze` bersih tanpa peringatan.
- `main.dart` hanya bertugas menjalankan aplikasi dan menyiapkan `MaterialApp`,
  sedangkan halaman berada di `lib/screens/` dan widget bersama di `lib/widgets/`.
- Halaman form memakai `GlobalKey<FormState>` untuk validasi seluruh field sebelum
  menampilkan ringkasan data pada `AlertDialog`.
- Warna setiap tombol disimpan pada model `ItemHomepage` sehingga `ItemCard`
  cukup membaca `item.color`.
- Warna `AppBar` memakai `Theme.of(context).colorScheme.primary` pada halaman utama,
  form proyek, form pendidikan, dan header drawer sehingga tema konsisten.
- Form pendidikan memakai `showDatePicker` untuk tanggal mulai/selesai dan membandingkan
  kedua `DateTime` di validator; pemilih tanggal selesai dibatasi minimal tanggal mulai.
- Fungsi validasi bersama berada di `lib/utils/validators.dart` agar form proyek dan
  form pendidikan memakai aturan yang sama.
- Halaman utama dan kedua form memakai `SingleChildScrollView`; `GridView` di halaman
  utama memakai `physics: NeverScrollableScrollPhysics()` agar hanya satu penggulir aktif.
- Opsi Home di drawer memakai `Navigator.pushAndRemoveUntil` agar tumpukan route
  dibersihkan dan pengguna selalu kembali ke satu halaman utama.

---

## Pertanyaan Reflektif

### 1. Apa yang Dimaksud dengan Widget Tree dan Bagaimana Hubungan Parent-Child Bekerja Antar-Widget?

**Widget tree** adalah struktur hierarkis yang menggambarkan susunan seluruh widget
pada sebuah aplikasi Flutter. Setiap widget menempati satu simpul (node) pada pohon
tersebut, dimulai dari root (biasanya `MaterialApp`) lalu bercabang ke widget-widget
anak hingga ke elemen paling kecil seperti `Text` atau `Icon`. Flutter merender UI
dengan menelusuri pohon ini: setiap widget meminta anaknya untuk membangun dirinya
sendiri melalui metode `build`.

Hubungan **parent-child** bekerja dengan aturan berikut:

- **Parent** bertanggung jawab menyusun, membatasi, dan memberikan konteks kepada
  anaknya. Misalnya `Column` mengatur posisi vertikal anak-anaknya, `Padding`
  memberi jarak, dan `Scaffold` menyediakan area `body`.
- **Child** hanya mengetahui dirinya sendiri dan tidak boleh bergantung langsung
  pada parent. Komunikasi ke atas dilakukan lewat callback (misalnya `onTap`),
  sedangkan data ke bawah diberikan lewat konstruktor.
- **Constraints** mengalir dari parent ke child (lebar/tinggi maksimum), lalu child
  mengembalikan **size** ke parent. Inilah sebabnya widget seperti `Expanded`
  atau `MediaQuery` dapat memengaruhi ukuran anak.
- **BuildContext** pada dasarnya adalah posisi sebuah widget di dalam pohon; ia
  menghubungkan widget dengan parent dan leluhurnya.

Contoh pada proyek ini: `MaterialApp` → `MyHomePage` → `Scaffold` → `Padding` →
`Column` → `Row` → `InfoCard` → `Card` → `Container` → `Text`. `Column` sebagai
parent mengatur tata letak vertikal, sedangkan `InfoCard` sebagai child hanya
membangun kartu sesuai data yang diterimanya.

### 2. Sebutkan Semua Widget yang Digunakan dalam Proyek Ini dan Jelaskan Fungsinya

| Widget / Kelas | Fungsi |
| -------------- | ------ |
| `MyApp` (`StatelessWidget`) | Root aplikasi yang mengonfigurasi `MaterialApp`, judul, dan tema. |
| `MaterialApp` | Membungkus aplikasi dengan navigasi, tema, dan konfigurasi Material. |
| `MyHomePage` (`StatelessWidget`) | Halaman utama portofolio yang menyusun InfoCard dan ItemCard. |
| `Scaffold` | Menyediakan struktur dasar halaman: AppBar, body, dan area SnackBar. |
| `AppBar` | Menampilkan bilah judul di bagian atas halaman. |
| `Text` | Menampilkan teks seperti judul, NPM, nama, kelas, dan label tombol. |
| `Padding` | Memberikan jarak di sekeliling widget anak. |
| `SizedBox` | Memberikan jarak vertikal/horizontal tetap antar-elemen. |
| `Column` | Menyusun widget anak secara vertikal. |
| `Row` | Menyusun widget anak secara horizontal (dipakai untuk tiga InfoCard). |
| `Center` | Menempatkan widget anak di tengah area yang tersedia. |
| `GridView.count` | Menampilkan ItemCard dalam tata letak kisi dengan jumlah kolom tetap. |
| `Card` | Membungkus konten dalam kartu Material dengan elevasi/bayangan. |
| `Container` | Mengatur ukuran, padding, dan dekorasi isi kartu. |
| `MediaQuery` | Mengambil informasi ukuran layar untuk menentukan lebar InfoCard. |
| `Material` | Menyediakan permukaan berwarna dan dukungan efek ripple. |
| `InkWell` | Mendeteksi ketukan pada ItemCard dan menampilkan efek ripple. |
| `Icon` | Menampilkan ikon aksi (folder, tambah, logout). |
| `Theme` / `ThemeData` / `ColorScheme` | Menentukan dan membaca warna serta gaya visual aplikasi. |
| `ScaffoldMessenger` | Menampilkan dan mengelola `SnackBar` di atas Scaffold. |
| `SnackBar` | Menampilkan pesan singkat saat tombol ditekan. |
| `InfoCard` (custom) | Widget kartu informasi berisi judul dan isi (NPM/nama/kelas). |
| `ItemCard` (custom) | Widget kartu aksi dengan ikon, teks, warna, dan aksi ketukan. |
| `ItemHomepage` (model) | Kelas data berisi `name`, `icon`, dan `color`. Bukan widget, melainkan sumber data untuk `ItemCard`. |

### 3. Apa Fungsi Widget `MaterialApp` dan Mengapa Umumnya Digunakan sebagai Root Widget?

`MaterialApp` adalah widget yang membungkus seluruh aplikasi dan menyediakan
konfigurasi tingkat aplikasi berbasis Material Design. Fungsi utamanya:

- Menentukan **tema** aplikasi (`theme`, `darkTheme`, `colorScheme`).
- Menentukan **halaman awal** melalui `home`, atau daftar rute melalui `routes`.
- Menyediakan **Navigator** untuk perpindahan halaman.
- Menyediakan **Overlay** tempat dialog, SnackBar, dan tooltip ditampilkan.
- Mengatur **lokalisasi**, arah teks (`Directionality`), dan `MediaQuery`.
- Menentukan judul aplikasi, debug banner, dan pengaturan lainnya.

`MaterialApp` umum dipakai sebagai root karena widget-widget Material di bawahnya
(seperti `Scaffold`, `AppBar`, `Card`, dan `SnackBar`) membutuhkan konteks yang
disediakan olehnya, antara lain `Theme`, `Directionality`, `Navigator`, `Overlay`,
dan `MediaQuery`. Tanpa `MaterialApp` (atau `WidgetsApp`), widget tersebut tidak
memiliki konteks yang lengkap dan aplikasi bisa gagal dirender. Karena itu,
`main()` biasanya hanya memanggil `runApp()` dengan `MaterialApp` sebagai simpul
teratas widget tree.

### 4. Jelaskan Perbedaan antara `StatelessWidget` dan `StatefulWidget`! Kapan Sebaiknya Memilih Masing-Masing?

**`StatelessWidget`**

- Tidak memiliki state yang bisa berubah setelah dibuat.
- Properti bersifat `final`; UI hanya dibangun ulang jika parent membuatnya ulang.
- Lebih sederhana, ringan, dan mudah diuji.
- Cocok untuk tampilan statis: teks, ikon, kartu informasi, layout yang tidak berubah.

**`StatefulWidget`**

- Memiliki objek `State` terpisah yang dapat berubah selama widget hidup.
- Perubahan state ditandai dengan `setState()`, yang memicu `build()` ulang.
- Memiliki siklus hidup (`initState`, `didUpdateWidget`, `dispose`) untuk mengelola
  sumber daya, animasi, atau data async.
- Cocok untuk interaksi dinamis: form, penghitung, daftar yang bisa ditambah/dihapus,
  pemuatan data dari API, dan animasi.

**Kapan memilih:**

- Pilih `StatelessWidget` jika seluruh tampilan hanya bergantung pada data yang
  diterima lewat konstruktor dan tidak berubah sendiri.
- Pilih `StatefulWidget` jika ada data internal yang berubah dan perubahan itu harus
  memicu render ulang.

Pada proyek ini, `MyHomePage` dibuat sebagai `StatelessWidget` karena data profil dan
daftar menu bersifat tetap. Jika nantinya fitur "Tambah Proyek" benar-benar menambah
item ke daftar, `MyHomePage` perlu diubah menjadi `StatefulWidget` agar perubahan
daftar dapat memicu `setState()`.

### 5. Apa Itu `BuildContext` dan Mengapa Penting di Flutter? Bagaimana Penggunaannya di Dalam Metode `build`?

`BuildContext` adalah objek yang merepresentasikan **posisi sebuah widget di dalam
widget tree**. Ia menjadi penghubung antara widget dengan leluhur (ancestor) dan
lingkungannya. Lewat `BuildContext`, widget dapat:

- Membaca InheritedWidget di atasnya, misalnya `Theme.of(context)`,
  `MediaQuery.of(context)`, dan `ScaffoldMessenger.of(context)`.
- Mengakses `Navigator.of(context)` untuk berpindah halaman.
- Mengetahui ukuran layar, arah teks, serta konfigurasi lain yang diwariskan.

`BuildContext` penting karena Flutter tidak menyimpan referensi global untuk tema
atau navigasi; semuanya diberikan secara terarah melalui pohon widget. Tanpa context,
sebuah widget tidak tahu di mana ia berada dan tidak dapat mengambil konfigurasi
yang benar. Context juga memastikan setiap widget hanya membaca data dari leluhurnya,
sehingga perubahan tema atau ukuran layar dapat merambat dengan benar.

Di dalam metode `build`, `context` digunakan untuk membangun UI berdasarkan
lingkungan saat itu. Contohnya pada proyek ini:

- `MediaQuery.of(context).size.width` di `InfoCard` untuk menentukan lebar kartu.
- `Theme.of(context).colorScheme.primary` di `AppBar` untuk warna bilah judul.
- `ScaffoldMessenger.of(context)` di `ItemCard` untuk menampilkan `SnackBar`.

Perlu diingat: context hanya valid selama widget masih terpasang di pohon. Setelah
operasi async, sebaiknya periksa `mounted` sebelum memakai context, dan jangan
menyimpan context untuk dipakai setelah widget di-`dispose`.

### 6. Jelaskan Konsep Hot Reload dan Perbedaannya dengan Hot Restart! Kapan Kita Tidak Bisa Hanya Mengandalkan Hot Reload?

**Hot reload** adalah fitur Flutter yang menyuntikkan kode Dart terbaru ke aplikasi
yang sedang berjalan, lalu membangun ulang widget tree tanpa memuat ulang seluruh
aplikasi. State yang sedang aktif (misalnya isi form, posisi scroll, nilai variabel
di `State`) **tetap dipertahankan**. Hot reload sangat cepat (biasanya di bawah satu
detik) sehingga cocok untuk iterasi tampilan seperti mengubah teks, warna, padding,
atau menyusun ulang widget.

**Hot restart** menjalankan ulang isolate Dart dari awal. Kode baru dikompilasi penuh,
`main()` dieksekusi kembali, dan seluruh state aplikasi **direset**. Hot restart lebih
lambat daripada hot reload, tetapi lebih menyeluruh.

**Perbedaan utama:**

| Aspek | Hot Reload | Hot Restart |
| ----- | ---------- | ----------- |
| Menjalankan ulang `main()` | Tidak | Ya |
| State aplikasi | Dipertahankan | Direset |
| Kecepatan | Sangat cepat | Lebih lambat |
| Perubahan kode Dart | Umumnya didukung | Didukung |
| Perubahan native/plugin | Tidak | Ya (sering perlu full restart) |

**Kapan tidak bisa hanya mengandalkan hot reload:**

- Setelah mengubah `pubspec.yaml`, menambah/menghapus dependensi, atau mengubah aset.
- Setelah mengubah konfigurasi native (Android `build.gradle`, `AndroidManifest.xml`,
  iOS `Info.plist`, atau kode platform channel).
- Saat mengubah inisialisasi global, nilai `const`, atau struktur enum yang dibaca
  saat kompilasi sehingga hot reload tidak menerapkan perubahan dengan benar.
- Ketika hot reload gagal karena error kompilasi atau state lama membuat tampilan
  tidak sesuai; hot restart diperlukan untuk memulai bersih.
- Saat mengubah `main()`, root widget, atau logika yang hanya dijalankan sekali.

Pada proyek ini, mengubah warna `ItemCard` atau teks `SnackBar` cukup dengan hot
reload. Namun saat menambahkan paket `material_ui` ke `pubspec.yaml`, diperlukan
`flutter pub get` lalu **hot restart atau full restart** agar dependensi baru dan
import yang berubah benar-benar diterapkan.

---

## Pertanyaan Reflektif Tambahan (Tutorial 10)

### 7. Jelaskan Perbedaan Antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode Apa yang Digunakan untuk Membuka Formulir dari Kartu Aksi? Bagaimana Opsi Home di Drawer Membawa Pengguna Kembali ke Halaman Utama?

`Navigator` mengelola **tumpukan route** (stack) tempat setiap halaman ditumpuk.

- **`Navigator.push()`** menambahkan route baru di atas route yang sedang aktif.
  Halaman sebelumnya tetap berada di stack, sehingga tombol kembali (back) membawa
  pengguna ke halaman asal. Metode inilah yang dipakai kartu aksi:
  `Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationFormPage()))`
  (hal yang sama berlaku untuk `ProjectFormPage`).
- **`Navigator.pushReplacement()`** mengganti route teratas dengan route baru.
  Route lama dibuang, sehingga menekan back tidak kembali ke halaman sebelumnya.
- **`Navigator.pop()`** mengeluarkan route teratas dan kembali ke route di bawahnya.
  Selain dipakai tombol back perangkat, `Navigator.pop(dialogContext)` digunakan untuk
  menutup `AlertDialog` ringkasan dan kembali ke formulir.

Opsi **Home** di drawer memakai
`Navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => MyHomePage()), (route) => false)`.
Predikat `(route) => false` menyebabkan seluruh route lama dihapus sebelum halaman utama
ditampilkan. Hasilnya, dari halaman form mana pun pengguna kembali ke satu halaman utama
dan tidak menyisakan form di belakang. Alternatifnya adalah
`Navigator.popUntil((route) => route.isFirst)` bila halaman utama sudah berada di dasar stack.

### 8. Bagaimana Susunan Scaffold, AppBar, dan Drawer Membantu Menjaga Struktur Halaman Tetap Konsisten? Berikan Satu Contoh Penggunaan Warna Tema Portofolio di Lebih dari Satu Halaman.

`Scaffold` menyediakan kerangka halaman yang seragam: `appBar`, `body`, `drawer`,
area `SnackBar`, serta pengaturan `resizeToAvoidBottomInset`. Karena `MyHomePage`,
`ProjectFormPage`, dan `EducationFormPage` sama-sama memakai `Scaffold`, perilaku dasar
halaman (bilah atas, area konten, pembukaan drawer, dan penyesuaian saat keyboard muncul)
tetap sama. `AppBar` menjaga judul dan warna bilah atas konsisten, sedangkan `LeftDrawer`
yang sama dipakai di ketiga halaman sehingga daftar menu dan tujuan navigasinya identik.
Pengguna tidak perlu mempelajari pola navigasi berbeda di tiap halaman.

Contoh penggunaan warna tema di lebih dari satu halaman: `AppBar` pada halaman utama
(`menu.dart`), form proyek (`project_form.dart`), dan form pendidikan
(`education_form.dart`) sama-sama memakai
`backgroundColor: Theme.of(context).colorScheme.primary`. Header `LeftDrawer` juga memakai
`Theme.of(context).colorScheme.primary`. Jika `seedColor` di `main.dart` diganti, warna
ketiga halaman dan drawer ikut berubah tanpa mengedit satu per satu.

### 9. Mengapa Tata Letak Tersebut Dipilih untuk Formulir? Jelaskan Peran Widget Pengatur Jarak dan Widget Penggulir Ketika Ruang Layar Terbatas.

Formulir disusun sebagai `Scaffold` → `SafeArea` → `Form` → `SingleChildScrollView` →
`Column`, dengan setiap field dibungkus `Padding`/dipisahkan `SizedBox` dan tombol Simpan
di akhir kolom. Tata letak ini dipilih karena formulir memiliki banyak input sehingga
tingginya melebihi layar, terutama pada ponsel sempit atau saat papan ketik muncul.

- **Widget pengatur jarak** (`Padding`, `SizedBox`) memberi jarak antarelemen agar tidak
  berdesakan, memperbesar area sentuh, dan menjaga hierarki visual antara field, pesan
  error, serta tombol Simpan.
- **Widget penggulir** (`SingleChildScrollView`) membuat `Column` mengambil tinggi alami
  lalu menggeser konten ketika melebihi viewport. `Scaffold` dengan
  `resizeToAvoidBottomInset` (default `true`) mengecilkan body saat keyboard tampil,
  dan penggulir memastikan semua field serta tombol Simpan tetap dapat dijangkau.
  Tanpa penggulir, `Column` berisiko menghasilkan `RenderFlex overflow` pada layar sempit.

`SafeArea` juga mencegah konten tertutup notch/status bar. Di halaman utama, `GridView`
memakai `shrinkWrap` dan `NeverScrollableScrollPhysics` agar hanya
`SingleChildScrollView` terluar yang menggulir.

### 10. Apa Peran GlobalKey<FormState>, Validator, dan validate() Saat Tombol Simpan Ditekan? Berikan Satu Contoh Nilai yang Ditolak oleh Validasi dan Jelaskan Mengapa Memilih Jenis Input atau Papan Ketik Saja Belum Cukup.

- **`GlobalKey<FormState>`** memberi identitas pada `Form` sehingga `FormState` dapat
  diakses dari handler tombol di luar metode `build`, misalnya untuk memanggil
  `validate()` atau `reset()`.
- **`validator`** adalah fungsi per field yang mengembalikan `String` pesan kesalahan
  atau `null` jika nilainya valid. Validator memeriksa aturan seperti wajib isi,
  batas panjang, format URL, dan urutan tanggal.
- **`validate()`** menjalankan seluruh validator, menampilkan pesan error inline pada
  field terkait, dan mengembalikan `true` hanya jika semua validator mengembalikan
  `null`. Karena itu ringkasan hanya ditampilkan di dalam
  `if (_formKey.currentState!.validate()) { showDialog(...); }`.

Contoh nilai yang ditolak: Nama Institusi berisi `"   "` (hanya spasi). Validator
`value == null || value.trim().isEmpty` menghasilkan pesan
"Nama institusi tidak boleh kosong!". Contoh lain, Tanggal Selesai yang lebih awal
dari Tanggal Mulai ditolak dengan pesan
"Tanggal selesai tidak boleh sebelum tanggal mulai!".

Memilih jenis input atau papan ketik saja **belum cukup** karena `keyboardType`
dan `textInputAction` hanya memengaruhi tampilan serta petunjuk papan ketik, bukan
aturan data. Pengguna tetap dapat mengirim nilai kosong atau berisi spasi, menempel
teks (paste), memakai autofill/aksesibilitas, serta melanggar aturan semantik seperti
panjang minimum, format URL, dan urutan tanggal yang tidak bisa dijamin oleh tipe input.
Validator memeriksa aturan tersebut saat submit dan menampilkan pesan kesalahan yang
jelas pada field yang bermasalah.

---



## Kontribusi

Kontribusi terbuka untuk siapa saja. Baca [`CONTRIBUTING.md`](CONTRIBUTING.md) untuk
alur kerja, konvensi commit, standar kode, dan checklist Pull Request.

Ringkasan sebelum mengirim perubahan:

```bash
dart format lib test
flutter analyze
flutter test
```

## AI Disclosure

Proyek ini dikembangkan dengan bantuan AI. AI berperan sebagai alat bantu pikir,
membantu menemukan penyebab masalah, dan menjelaskan langkah penyelesaiannya secara
bertahap. AI digunakan untuk menyusun README yang rapi seperti proyek open-source,
merapikan jawaban reflektif agar mudah dibaca, serta membantu membuat formulir
pendidikan, aturan validasi, pengujian widget, dan penyesuaian tata letak agar tetap
dapat digulir pada layar sempit.

Semua saran AI ditinjau dan diverifikasi secara manual: kode dijalankan melalui
`dart format`, `flutter analyze`, `flutter test`, dan `flutter build web`, lalu alur
formulir diuji dari kartu aksi maupun drawer sebelum di-commit.

## Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

