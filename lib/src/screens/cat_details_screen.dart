import 'package:flutter/material.dart';
import 'package:match_your_kitty/src/models/cat.dart';
import 'package:url_launcher/url_launcher.dart';

class CatDetailPage extends StatelessWidget {
  static const routeName = '/catDetail';

  const CatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cat cat = ModalRoute.of(context)?.settings.arguments as Cat;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${cat.breeds[0].name} Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(cat.url)),
            SizedBox(height: 20),
            Text(
              'Breed: ${cat.breeds[0].name}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (cat.breeds[0].name.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Temperament: ${cat.breeds[0].temperament}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Origin: ${cat.breeds[0].origin}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Life Span: ${cat.breeds[0].lifeSpan}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      if (cat.breeds[0].wikipediaUrl?.isEmpty ?? true) {
                        return;
                      }
                      final url = Uri.parse(cat.breeds[0].wikipediaUrl!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        return;
                      }
                    },
                    child: Text(
                      'More Info: ${cat.breeds[0].wikipediaUrl}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
