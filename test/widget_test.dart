// Widget test untuk halaman menu utama MyPortfolio.

import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';

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
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('menekan ItemCard menampilkan SnackBar yang sesuai', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(
      find.text('Kamu telah menekan tombol Tambah Proyek!'),
      findsOneWidget,
    );
  });
}
