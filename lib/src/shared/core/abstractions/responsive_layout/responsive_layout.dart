import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/responsive_layout/templates/template.dart';
import 'package:flutter_application_1/src/shared/helpers/consts/constraints/layout_constraints.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.smallTemplate,
    required this.largeTemplate,
    required this.mediumTemplate,
  });

  final Template smallTemplate;
  final Template largeTemplate;
  final Template mediumTemplate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= SMALLLAYOUT) {
        return smallTemplate;
      } else if (constraints.maxWidth > SMALLLAYOUT &&
          constraints.maxWidth <= MEDIUMLAYOUT) {
        return mediumTemplate;
      } else {
        return largeTemplate;
      }
    });
  }
}
