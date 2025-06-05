import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:match_your_kitty/domain/models/cat.dart';
import 'package:url_launcher/url_launcher.dart';

class CatDetailsScreen extends StatelessWidget {
  static const routeName = '/cat-details';

  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final breed = cat.breeds.isNotEmpty ? cat.breeds.first : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: cat.url,
              height: 250,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 24),
            Text(
              breed?.name ?? 'Unknown Breed',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (breed != null) ...[
              _buildInfoRow('Origin:', breed.origin),
              _buildInfoRow('Temperament:', breed.temperament),
              _buildInfoRow('Life Span:', '${breed.lifeSpan} years'),
              if (breed.wikipediaUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: GestureDetector(
                    onTap: () => _launchUrl(breed.wikipediaUrl!),
                    child: Text(
                      'Learn more on Wikipedia',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: '$title ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
