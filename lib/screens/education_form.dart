import 'package:material_ui/material_ui.dart';

import 'package:myportofolio_mobile/utils/validators.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tanggalMulaiController = TextEditingController();
  final _tanggalSelesaiController = TextEditingController();

  String _namaInstitusi = "";
  String _jenjang = "S1";
  String _jurusan = "";
  String _website = "";
  DateTime? _tanggalMulai;
  DateTime? _tanggalSelesai;

  final List<String> _jenjangOptions = [
    'SMA/SMK',
    'D3',
    'D4',
    'S1',
    'S2',
    'S3',
    'Bootcamp',
    'Lainnya',
  ];

  @override
  void dispose() {
    _tanggalMulaiController.dispose();
    _tanggalSelesaiController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day-$month-${date.year}';
  }

  Future<void> _pickTanggalMulai() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalMulai ?? DateTime(now.year - 4),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 10),
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      _tanggalMulai = picked;
      _tanggalMulaiController.text = _formatDate(picked);
    });
  }

  Future<void> _pickTanggalSelesai() async {
    final now = DateTime.now();
    final batasAwal = _tanggalMulai ?? DateTime(1950);
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalSelesai ?? _tanggalMulai ?? now,
      firstDate: batasAwal,
      lastDate: DateTime(now.year + 10),
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      _tanggalSelesai = picked;
      _tanggalSelesaiController.text = _formatDate(picked);
    });
  }

  void _showSummary(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Pendidikan berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Institusi: $_namaInstitusi'),
                Text('Jenjang: $_jenjang'),
                Text('Jurusan: $_jurusan'),
                Text('Tanggal Mulai: ${_formatDate(_tanggalMulai!)}'),
                Text('Tanggal Selesai: ${_formatDate(_tanggalSelesai!)}'),
                Text('Website: ${_website.trim().isEmpty ? '-' : _website}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(5.0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Education Form'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Universitas Indonesia",
                    labelText: "Nama Institusi",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _namaInstitusi = value ?? "";
                  },
                  validator: (String? value) => validateRequired(
                    value,
                    label: "Nama institusi",
                    minLength: 3,
                    maxLength: 100,
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Jenjang / Gelar",
                    border: border,
                  ),
                  initialValue: _jenjang,
                  items: _jenjangOptions
                      .map(
                        (jenjang) => DropdownMenuItem(
                          value: jenjang,
                          child: Text(jenjang),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _jenjang = newValue ?? "S1";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Jenjang tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Ilmu Komputer",
                    labelText: "Jurusan / Program Studi",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _jurusan = value ?? "";
                  },
                  validator: (String? value) => validateRequired(
                    value,
                    label: "Jurusan",
                    minLength: 3,
                    maxLength: 100,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tanggalMulaiController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pilih tanggal mulai",
                    labelText: "Tanggal Mulai",
                    border: border,
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                  onTap: _pickTanggalMulai,
                  validator: (String? value) {
                    if (_tanggalMulai == null) {
                      return "Tanggal mulai wajib diisi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tanggalSelesaiController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pilih tanggal selesai",
                    labelText: "Tanggal Selesai",
                    border: border,
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                  onTap: _pickTanggalSelesai,
                  validator: (String? value) {
                    if (_tanggalSelesai == null) {
                      return "Tanggal selesai wajib diisi!";
                    }
                    if (_tanggalMulai != null &&
                        _tanggalSelesai!.isBefore(_tanggalMulai!)) {
                      return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://kampus.ac.id (opsional)",
                    labelText: "Website Institusi",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _website = value ?? "";
                  },
                  validator: (String? value) =>
                      validateOptionalUrl(value, label: "Website institusi"),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSummary(context);
                      }
                    },
                    child: const Text("Simpan"),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
