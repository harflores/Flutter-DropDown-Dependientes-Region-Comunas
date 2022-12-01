import 'package:app_lab_region_comuna/screens/region_comuna_json_2.dart';
import 'package:app_lab_region_comuna/screens/region_comuna_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InicialScreen extends StatelessWidget {
  const InicialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio Flutter'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        MaterialButton(
          onPressed: () => Get.to(() => const RegionComuna2()),
          minWidth: 300,
          height: 40,
          color: Colors.lightBlue,
          child: const Text('Región/Comuna JSON',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        MaterialButton(
          onPressed: () {},
          minWidth: 300,
          height: 40,
          color: Colors.lightBlue,
          child: const Text('Región/Comuna > API > DB',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ])),
    );
  }
}
