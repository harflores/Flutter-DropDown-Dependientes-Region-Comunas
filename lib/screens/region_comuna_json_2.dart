import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class RegionComuna2 extends StatefulWidget {
  const RegionComuna2({super.key});

  @override
  State<RegionComuna2> createState() => _RegionComuna2State();
}

class _RegionComuna2State extends State<RegionComuna2> {
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
                    DropdownSearch(
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Seleccione Región",
                            labelStyle: TextStyle(fontSize: 20),
                            hintText: "Regiones",
                          ),
                        ),
                        items: regiones(),
                        onChanged: (value) {
                          setState(() {
                            region = value.toString();
                            comuna = comunas(region)[0].toString();
                          });
                        }),
                    DropdownSearch(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Seleccione Comuna",
                          labelStyle: TextStyle(fontSize: 20),
                          hintText: "Comunas",
                        ),
                      ),
                      selectedItem: comuna,
                      items: comunas(region),
                      onChanged: (value) {
                        setState(() {
                          comuna = value.toString();
                        });
                      },
                    )
                  ],
                ),
              ));
  }

  List<String> regiones() {
    List<String> list = [];
    json.forEach((key, value) {
      for (var element in value) {
        list.add(
          element['region'],
        );
      }
    });
    return list;
  }

  List<String> comunas(region) {
    List<String> list = [];
    json.forEach((key, value) {
      for (var element in value) {
        if (region == element['region']) {
          for (var element in element['comunas']) {
            list.add(element);
          }
        }
      }
    });

    return list;
  }
}
