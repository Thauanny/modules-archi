import 'package:url_launcher/url_launcher.dart';

void abrirURL(Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Não foi possível abrir a URL: $uri';
  }
}
