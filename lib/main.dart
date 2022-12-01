import 'package:flutter/material.dart';

import 'package:app_lab_region_comuna/screens/inicial.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        title: 'Desafio Flutter',
        debugShowCheckedModeBanner: false,
        home: InicialScreen());
  }
}
