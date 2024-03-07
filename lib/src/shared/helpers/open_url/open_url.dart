import 'package:url_launcher/url_launcher.dart';

void openUrl(Uri uri, {bool newTab = true}) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: newTab ? '_blank' : '_self');
  } else {
    throw 'Não foi possível abrir a URL: $uri';
  }
}
