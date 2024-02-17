import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/responsive_layout/templates/template.dart';

class MediumTemplate extends StatelessWidget implements Template {
  const MediumTemplate({
    super.key,
    required this.body,
    this.drawer,
    required this.appBar,
    required this.endDrawer,
    this.appBarSize,
  });

  final Widget body;
  final Widget? drawer;
  final Widget? appBar;
  final Widget? endDrawer;
  final double? appBarSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) {},
      onEndDrawerChanged: (isOpened) {},
      endDrawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarSize ?? 66),
        child: appBar ?? const SizedBox.shrink(),
      ),
      drawer: drawer,
      key: key,
      body: body,
      endDrawer: endDrawer,
    );
  }
}
