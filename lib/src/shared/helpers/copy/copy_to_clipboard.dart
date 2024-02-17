import 'package:flutter/services.dart';

void copyToClipBoard(String text) =>
    Clipboard.setData(ClipboardData(text: text));
