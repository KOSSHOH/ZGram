import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/app_theme.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExploreScreenState();
  }
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
    );
  }
}
