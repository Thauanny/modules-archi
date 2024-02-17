import 'package:flutter/material.dart';

void handlerExpiredAcessToken() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  navigatorKey.currentState?.popUntil((route) => route.isFirst);
  navigatorKey.currentState?.pushReplacementNamed("/home");
}
