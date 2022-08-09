// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:studentregistration/Controlador/StudentsController.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:intl/intl.dart';
import 'package:studentregistration/Views/widgets.dart';

import '../objectbox.g.dart';

class AddStudentScreen extends StatefulWidget {
  AddStudentScreen({required this.boxstudent, Key? key}) : super(key: key);
  final Box<Students> boxstudent;
  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final dateofbirthcontroller = TextEditingController();
  final hobbitscontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  var bdc = StudentController();

  final llaveform = GlobalKey<FormState>();

  @override
  void initState() {
    dateofbirthcontroller.text = "Click";
    super.initState();
  }

  void Validar() {
    try {
      if (llaveform.currentState!.validate()) {
        llaveform.currentState!.save();
        if (dateofbirthcontroller.text != "Click") {
          int edad = int.parse(agecontroller.text);
          bdc.setboxBD = widget.boxstudent;
          bdc.name = namecontroller.text;
          bdc.age = int.parse(agecontroller.text);
          bdc.dateofbirth = dateofbirthcontroller.text;
          bdc.hobbits = hobbitscontroller.text;
          bdc.descriptions = descriptioncontroller.text;

          bdc.newStudent();
          Navigator.of(context).pop();
        } else {
          mostrarAviso(context,
              "Debes seleccionar una fecha de nacimiento para añadir un estudiante");
        }
      }
    } on FormatException {
      mostrarAviso(context, "La edad debe ser un numero");
      agecontroller.text = "";
    }
  }

  void obtfecha() async {
    try {
      await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1700),
              lastDate: DateTime(2050))
          .then((pickedDate) {
        dateofbirthcontroller.text =
            DateFormat("dd-MM-yyyy").format(pickedDate!);
      });
      setState(() {});
    } on CastError {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 33, 41),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 33, 41),
          title: const Text("Nuevo Estudiante"),
        ),
        body: Center(
          child: Form(
            key: llaveform,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextForm(namecontroller, TextInputType.text, "Nombre", 1),
                TextForm(agecontroller, TextInputType.number, "Edad", 1),
                TextForm(
                    hobbitscontroller, TextInputType.text, "Pasatiempos", 1),
                TextForm(descriptioncontroller, TextInputType.text,
                    "Descripción", 1),
                Btnfecha(obtfecha, "FechaNac", dateofbirthcontroller),
                Boton(Validar),
              ],
            )),
          ),
        ));
  }

  void mostrarAviso(BuildContext context, String info) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 19, 49, 60),
            title: const Text("¡Información!",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center),
            content: Text(
              info,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 10, 33, 41),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  child: const Text('Entendido'),
                ),
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
        barrierDismissible: true);
  }
}
