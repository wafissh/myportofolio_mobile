import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _handleTap(BuildContext context) async {
    if (item.name == "Lihat Proyek") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectListScreen()),
      );
      return;
    }
    if (item.name == "Tambah Proyek") {
      final loggedIn = await ensureLoggedIn(context);
      if (!context.mounted || !loggedIn) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectFormPage()),
      );
      return;
    }
    if (item.name == "Tambah Pendidikan") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EducationFormPage()),
      );
      return;
    }
    if (item.name == "Login") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }
    if (item.name == "Logout") {
      final messenger = ScaffoldMessenger.of(context);
      await context.read<AuthState>().logout();
      if (!context.mounted) {
        return;
      }
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Berhasil logout.')));
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Setiap kartu memakai warna latar unik yang ditentukan per item.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () => _handleTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
