import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/utils/validators.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";
  bool _isSubmitting = false;

  String? _validateProjectUrl(String? value) {
    final required = validateRequired(
      value,
      label: "Project URL",
      maxLength: 200,
    );
    if (required != null) {
      return required;
    }
    return validateOptionalUrl(value, label: "Project URL");
  }

  Future<void> _showSuccessDialog(Project project) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul: ${project.title}'),
                Text('Deskripsi: ${project.description}'),
                Text('Tech Stack: ${project.techStack}'),
                Text('Tautan: ${project.projectUrl}'),
                if (project.projectImageUrl.isNotEmpty)
                  Text('Gambar: ${project.projectImageUrl}'),
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) {
      return;
    }

    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final project = Project(
        title: _title.trim(),
        description: _description.trim(),
        techStack: _techStack.trim(),
        projectUrl: _projectUrl.trim(),
        projectImageUrl: _projectImageUrl.trim(),
      );
      final created = await context.read<ApiClient>().createProject(
        project,
        token: token,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _isSubmitting = false;
      });
      await _showSuccessDialog(created);
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      if (error.statusCode == 401) {
        await authState.logout();
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi berakhir. Silakan login kembali.'),
          ),
        );
        setState(() {
          _isSubmitting = false;
        });
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan proyek (${error.statusCode}).'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(5.0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
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
                    hintText: "Nama proyek",
                    labelText: "Title",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _title = value ?? "";
                  },
                  validator: (String? value) => validateRequired(
                    value,
                    label: "Judul proyek",
                    minLength: 3,
                    maxLength: 100,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi proyek",
                    labelText: "Description",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _description = value ?? "";
                  },
                  validator: (String? value) => validateRequired(
                    value,
                    label: "Deskripsi proyek",
                    minLength: 10,
                    maxLength: 500,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, Figma",
                    labelText: "Tech Stack",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _techStack = value ?? "";
                  },
                  validator: (String? value) => validateRequired(
                    value,
                    label: "Tech stack",
                    minLength: 2,
                    maxLength: 100,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://contoh.com",
                    labelText: "Project URL",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _projectUrl = value ?? "";
                  },
                  validator: _validateProjectUrl,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://contoh.com/gambar.png (opsional)",
                    labelText: "Project Image URL (Optional)",
                    border: border,
                  ),
                  onChanged: (String? value) {
                    _projectImageUrl = value ?? "";
                  },
                  validator: (String? value) =>
                      validateOptionalUrl(value, label: "Project image URL"),
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
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text("Save"),
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
