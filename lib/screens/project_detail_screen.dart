import 'package:material_ui/material_ui.dart';

import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = project.projectImageUrl.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 220,
                    color: theme.colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image_outlined, size: 48),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(project.title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Chip(
              avatar: const Icon(Icons.code, size: 18),
              label: Text(project.techStack),
            ),
            const SizedBox(height: 16),
            Text('Deskripsi', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(project.description, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text('Tautan Proyek', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            SelectableText(
              project.projectUrl,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
