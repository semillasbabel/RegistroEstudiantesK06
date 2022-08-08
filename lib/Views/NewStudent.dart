import 'package:flutter/material.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:intl/intl.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final dateofbirthcontroller = TextEditingController();
  final hobbitscontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  final llaveform = GlobalKey<FormState>();

  void onSave(
      String name, int age, String datebirth, String hobbit, String descrip) {
    final result = Students(
        name: name,
        age: age,
        dateofbirth: datebirth,
        hobbits: hobbit,
        descriptions: descrip);
    Navigator.of(context).pop(result);
  }

  void Validar(BuildContext context) {
    if (llaveform.currentState!.validate()) {
      llaveform.currentState!.save();
      //------------------------------------------------------
      onSave(
          namecontroller.text,
          int.parse(agecontroller.text),
          dateofbirthcontroller.text,
          hobbitscontroller.text,
          descriptioncontroller.text);
      //------------------------------------------------------
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 33, 41),
        body: Center(
          child: Form(
            key: llaveform,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextForm(namecontroller, TextInputType.text, "Nombre", 1),
                TextForm(agecontroller, TextInputType.number, "Edad", 1),
                DateForm(dateofbirthcontroller, "Fecha Nacimiento"),
                TextForm(
                    hobbitscontroller, TextInputType.text, "Pasatiempos", 2),
                TextForm(descriptioncontroller, TextInputType.text,
                    "Descripción", 2),
                Boton(),
              ],
            )),
          ),
        ));
  }

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
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        keyboardType: tipo,
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

  Widget DateForm(
    TextEditingController controller,
    String texto,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget Boton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 19, 49, 60),
        ),
        onPressed: () {
          Validar(context);
        },
        child: const Text("Agregar"));
  }
}
