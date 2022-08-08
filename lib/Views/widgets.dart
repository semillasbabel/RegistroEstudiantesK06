// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget TextForm(
  TextEditingController controller,
  TextInputType tipo,
  String texto,
  int numlines,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      maxLines: numlines,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      keyboardType: tipo,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
        labelText: texto,
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value == "") {
          return 'Ingrese un dato';
        }
      },
    ),
  );
}

Widget DateForm(
  BuildContext context,
  TextEditingController controller,
  String texto,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 50),
    child: TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.datetime,
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1700),
                lastDate: DateTime(2050))
            .then((pickedDate) {
          controller.text = DateFormat("dd-MM-yyyy").format(pickedDate!);
        });
      },
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        labelText: texto,
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese un dato';
        }
      },
    ),
  );
}

Widget Btnfecha(
  Function(),
  String texto,
  TextEditingController controller,
) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Fecha Nacimiento:  ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 19, 49, 60),
              ),
              onPressed: () {
                Function();
              },
              child: Text(controller.text)),
        ],
      ));
}

Widget BtnGen(Function(), String texto) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 19, 49, 60),
      ),
      onPressed: () {
        Function();
      },
      child: Text(texto));
}

Widget Boton(Function()) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 19, 49, 60),
      ),
      onPressed: () {
        Function();
      },
      child: const Text("Agregar"));
}
