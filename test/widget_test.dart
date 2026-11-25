// Widget test untuk halaman menu, autentikasi, daftar proyek, dan form.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

const _jsonHeaders = {'content-type': 'application/json; charset=utf-8'};

Project _sampleProject({String id = 'p1', String title = 'Portofolio Mobile'}) {
  return Project(
    id: id,
    title: title,
    description: 'Aplikasi portofolio berbasis Flutter',
    techStack: 'Flutter, Django',
    projectUrl: 'https://example.com/$id',
  );
}

ApiClient _buildApiClient({
  List<Project> projects = const [],
  http.Response? Function(http.Request request)? onProjectPost,
}) {
  return ApiClient(
    client: MockClient((request) async {
      final path = request.url.path;

      if (request.method == 'GET' && path == '/api/v1/projects/') {
        final data = projects
            .map((project) => {'id': project.id, ...project.toJson()})
            .toList();
        return http.Response(jsonEncode(data), 200, headers: _jsonHeaders);
      }
      if (request.method == 'POST' && path == '/api/v1/auth/token/') {
        return http.Response(
          jsonEncode({'token': 'test-token'}),
          200,
          headers: _jsonHeaders,
        );
      }
      if (request.method == 'POST' && path == '/api/v1/auth/logout/') {
        return http.Response('', 204);
      }
      if (request.method == 'POST' && path == '/api/v1/projects/') {
        final custom = onProjectPost?.call(request);
        if (custom != null) {
          return custom;
        }
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response(
          jsonEncode({'id': 'generated-id', ...body}),
          201,
          headers: _jsonHeaders,
        );
      }
      return http.Response('Not found', 404);
    }),
  );
}

Future<void> _pumpApp(
  WidgetTester tester, {
  ApiClient? apiClient,
  String? token,
}) async {
  final client = apiClient ?? _buildApiClient();
  await tester.pumpWidget(
    MyApp(
      apiClient: client,
      authState: AuthState(client, initialToken: token),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _openEducationForm(WidgetTester tester) async {
  await _pumpApp(tester);
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

Future<void> _openProjectForm(WidgetTester tester) async {
  await tester.tap(find.text('Tambah Proyek'));
  await tester.pumpAndSettle();
}

Future<void> _fillProjectForm(WidgetTester tester) async {
  final fields = find.byType(TextFormField);
  await tester.enterText(fields.at(0), 'Portofolio Mobile');
  await tester.enterText(fields.at(1), 'Aplikasi portofolio berbasis Flutter');
  await tester.enterText(fields.at(2), 'Flutter, Django');
  await tester.enterText(fields.at(3), 'https://example.com');
  await tester.enterText(fields.at(4), '');
  await tester.pumpAndSettle();
}

Future<void> _tapSaveProject(WidgetTester tester) async {
  final saveButton = find.widgetWithText(ElevatedButton, 'Save');
  await tester.ensureVisible(saveButton);
  await tester.pumpAndSettle();
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('menampilkan informasi profil dan tombol aksi', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester);

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('2506624461'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Wien Muhammad Hafizhurrohman'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);

    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Tambah Pendidikan'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Logout'), findsNothing);
  });

  testWidgets('menampilkan daftar proyek dari API', (
    WidgetTester tester,
  ) async {
    final api = _buildApiClient(
      projects: [
        _sampleProject(id: 'p1', title: 'Portofolio Mobile'),
        _sampleProject(id: 'p2', title: 'Web Portofolio'),
      ],
    );
    await _pumpApp(tester, apiClient: api);

    await tester.tap(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Achievements: Projects'), findsOneWidget);
    expect(find.text('Portofolio Mobile'), findsOneWidget);
    expect(find.text('Web Portofolio'), findsOneWidget);
  });

  testWidgets('menampilkan pesan kosong saat tidak ada proyek', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('No projects found.'), findsOneWidget);
  });

  testWidgets('Tambah Proyek saat belum login membuka halaman Login', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester);

    await _openProjectForm(tester);

    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
    expect(find.byType(TextFormField).at(0), findsOneWidget);
    expect(find.byType(TextFormField).at(1), findsOneWidget);
  });

  testWidgets('login berhasil membuka form proyek', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester);
    await _openProjectForm(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Add Project Form'), findsOneWidget);
  });

  testWidgets('form proyek kosong menampilkan pesan validasi', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester, token: 'test-token');
    await _openProjectForm(tester);

    await _tapSaveProject(tester);

    expect(find.text('Judul proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tech stack tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Project URL tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('form proyek valid mengirim POST dan menampilkan dialog', (
    WidgetTester tester,
  ) async {
    String? authHeader;
    final api = _buildApiClient(
      onProjectPost: (request) {
        authHeader = request.headers['Authorization'];
        return null;
      },
    );
    await _pumpApp(tester, apiClient: api, token: 'test-token');
    await _openProjectForm(tester);
    await _fillProjectForm(tester);

    await _tapSaveProject(tester);

    expect(authHeader, 'Token test-token');
    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Judul: Portofolio Mobile'), findsOneWidget);
    expect(find.text('Tech Stack: Flutter, Django'), findsOneWidget);
    expect(find.text('Tautan: https://example.com'), findsOneWidget);
  });

  testWidgets('POST 401 mengakhiri sesi dan meminta login ulang', (
    WidgetTester tester,
  ) async {
    final api = _buildApiClient(
      onProjectPost: (request) => http.Response('Unauthorized', 401),
    );
    await _pumpApp(tester, apiClient: api, token: 'expired-token');
    await _openProjectForm(tester);
    await _fillProjectForm(tester);

    await _tapSaveProject(tester);

    expect(find.text('Sesi berakhir. Silakan login kembali.'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
  });

  testWidgets('menekan Tambah Pendidikan membuka form pendidikan', (
    WidgetTester tester,
  ) async {
    await _openEducationForm(tester);

    expect(find.text('Add Education Form'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(5));
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

    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Add Education Form'), findsOneWidget);
  });
}
