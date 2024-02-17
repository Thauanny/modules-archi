import 'dart:html' as html;

openInNewTab({required String url, required fileName}) =>
    html.window.open(url, fileName);
