import 'package:flutter/material.dart';

class DiagnosisPage extends StatefulWidget {
  final List<dynamic> conditions;
  final dynamic image;
  const DiagnosisPage({super.key, required this.conditions, required this.image});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Image.file(widget.image), Text(widget.conditions[0])],),);
  }
}