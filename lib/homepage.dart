import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [_buildSearchwidget()],
      ),
    )));
  }

  Widget _buildSearchwidget() {
    return SearchBar();
  }
}
