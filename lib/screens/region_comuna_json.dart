import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class RegionComuna extends StatefulWidget {
  const RegionComuna({super.key});

  @override
  State<RegionComuna> createState() => _RegionComunaState();
}

class _RegionComunaState extends State<RegionComuna> {
  late Map<dynamic, dynamic> json;
  bool cargando = true;
  String? region;
  String? comuna;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      obtenerJsonRegiones();
    });

    super.initState();
  }

  Future<void> obtenerJsonRegiones() async {
    json = await jsonDecode(
        await rootBundle.loadString('assets/comunas-regiones-chile.json'));

    setState(() {
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Región/Comuna JSON'),
        ),
        body: cargando
            ? const CircularProgressIndicator()
            : Center(
                child: Column(
                  children: [
                    const Text('Seleccione Region',
                        style: TextStyle(fontSize: 30)),
                    DropdownButton(
                        isExpanded: true,
                        value: region,
                        items: regiones(),
                        onChanged: (value) {
                          setState(() {
                            region = value.toString();
                            comuna = null;
                          });
                        }),
                    const Text('Seleccione Comuna',
                        style: TextStyle(fontSize: 30)),
                    DropdownButton(
                        isExpanded: true,
                        value: comuna,
                        items: comunas(region),
                        onChanged: (value) {
                          setState(() {
                            comuna = value.toString();
                          });
                        }),
                  ],
                ),
              ));
  }

  List<DropdownMenuItem<String>> regiones() {
    List<DropdownMenuItem<String>> lista = [];
    lista.add(const DropdownMenuItem(
      value: "Seleccione",
      child: Text(
        "Seleccione",
      ),
    ));
    json.forEach((key, value) {
      for (var element in value) {
        lista.add(DropdownMenuItem(
          value: element['region'],
          child: Text(
            element['region'],
          ),
        ));
      }
    });
    return lista;
  }

  List<DropdownMenuItem<String>> comunas(region) {
    List<DropdownMenuItem<String>> lista = [];

    lista.add(const DropdownMenuItem(
      value: "Seleccione",
      child: Text(
        "Seleccione",
      ),
    ));

    json.forEach((key, value) {
      for (var element in value) {
        if (region == element['region']) {
          for (var element in element['comunas']) {
            lista.add(DropdownMenuItem(
              value: element,
              child: Text(
                element,
              ),
            ));
          }
          print(element['comuna']);
        }
      }
    });
    return lista;
  }
}
