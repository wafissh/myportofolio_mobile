// Widget test untuk halaman menu, navigasi, dan form MyPortfolio.

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';

Future<void> _openEducationForm(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.tap(find.text('Tambah Pendidikan'));
  await tester.pumpAndSettle();
}

Future<void> _pickDefaultDate(WidgetTester tester, Finder field) async {
  await tester.ensureVisible(field);
  await tester.pumpAndSettle();
  await tester.tap(field);
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('menampilkan informasi profil dan tombol aksi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('2506624461'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Wien Muhammad Hafizhurrohman'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);

    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Tambah Pendidikan'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('menekan ItemCard menampilkan SnackBar yang sesuai', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();

    expect(
      find.text('Kamu telah menekan tombol Lihat Proyek!'),
      findsOneWidget,
    );
  });

  testWidgets('menekan Tambah Proyek membuka halaman form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Add Project Form'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
  });

  testWidgets('menekan Tambah Pendidikan membuka form pendidikan', (
    WidgetTester tester,
  ) async {
    await _openEducationForm(tester);

    expect(find.text('Add Education Form'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(5));
  });

  testWidgets('drawer membuka form pendidikan', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    expect(find.text('Add Education Form'), findsOneWidget);
  });

  testWidgets('form proyek kosong menampilkan pesan validasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(ElevatedButton, 'Save');
    await tester.ensureVisible(saveButton);
    await tester.pumpAndSettle();
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('form proyek valid menampilkan ringkasan pada dialog', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Portofolio Mobile');
    await tester.enterText(
      fields.at(1),
      'Aplikasi portofolio berbasis Flutter',
    );
    await tester.enterText(fields.at(2), 'Flutter, Django');
    await tester.enterText(fields.at(3), 'https://example.com');
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(ElevatedButton, 'Save');
    await tester.ensureVisible(saveButton);
    await tester.pumpAndSettle();
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Nama Proyek: Portofolio Mobile'), findsOneWidget);
    expect(find.text('Kategori: Web Development'), findsOneWidget);
    expect(find.text('Teknologi: Flutter, Django'), findsOneWidget);
    expect(find.text('Tautan: https://example.com'), findsOneWidget);
  });

  testWidgets('form pendidikan kosong menampilkan pesan validasi', (
    WidgetTester tester,
  ) async {
    await _openEducationForm(tester);

    final saveButton = find.widgetWithText(ElevatedButton, 'Simpan');
    await tester.ensureVisible(saveButton);
    await tester.pumpAndSettle();
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Nama institusi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Jurusan tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tanggal mulai wajib diisi!'), findsOneWidget);
    expect(find.text('Tanggal selesai wajib diisi!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('form pendidikan menolak URL yang tidak valid', (
    WidgetTester tester,
  ) async {
    await _openEducationForm(tester);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Universitas Indonesia');
    await tester.enterText(fields.at(1), 'Ilmu Komputer');
    await _pickDefaultDate(tester, find.byType(TextFormField).at(2));
    await _pickDefaultDate(tester, find.byType(TextFormField).at(3));
    await tester.enterText(fields.at(4), 'bukan-url');
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(ElevatedButton, 'Simpan');
    await tester.ensureVisible(saveButton);
    await tester.pumpAndSettle();
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Website institusi harus diawali'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('form pendidikan valid menampilkan ringkasan dan bisa ditutup', (
    WidgetTester tester,
  ) async {
    await _openEducationForm(tester);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Universitas Indonesia');
    await tester.enterText(fields.at(1), 'Ilmu Komputer');
    await _pickDefaultDate(tester, find.byType(TextFormField).at(2));
    await _pickDefaultDate(tester, find.byType(TextFormField).at(3));
    await tester.enterText(fields.at(4), 'https://ui.ac.id');
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(ElevatedButton, 'Simpan');
    await tester.ensureVisible(saveButton);
    await tester.pumpAndSettle();
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Pendidikan berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Nama Institusi: Universitas Indonesia'), findsOneWidget);
    expect(find.text('Jenjang: S1'), findsOneWidget);
    expect(find.text('Jurusan: Ilmu Komputer'), findsOneWidget);
    expect(find.text('Website: https://ui.ac.id'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Add Education Form'), findsOneWidget);
  });

  testWidgets('opsi Home di drawer kembali ke halaman utama', (
    WidgetTester tester,
  ) async {
    await _openEducationForm(tester);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
    expect(find.text('Add Education Form'), findsNothing);
  });
}
