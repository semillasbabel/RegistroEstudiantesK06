// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:studentregistration/Controlador/StudentsController.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:intl/intl.dart';
import 'package:studentregistration/Views/widgets.dart';

class studeninf extends StatefulWidget {
  studeninf({
    Key? key,
    required this.boxstudent,
    required this.estudiante,
  }) : super(key: key);

  final Box<Students> boxstudent;
  final Students estudiante;
  @override
  State<studeninf> createState() => _studeninfState();
}

class _studeninfState extends State<studeninf> {
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final dateofbirthcontroller = TextEditingController();
  final hobbitscontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  var bdc = StudentController();

  final llaveform = GlobalKey<FormState>();

  @override
  void initState() {
    namecontroller.text = widget.estudiante.name;
    agecontroller.text = widget.estudiante.age.toString();
    dateofbirthcontroller.text = widget.estudiante.dateofbirth;
    hobbitscontroller.text = widget.estudiante.hobbits;
    descriptioncontroller.text = widget.estudiante.descriptions;
    super.initState();
  }

  void onUpdate() {
    bdc.setboxBD = widget.boxstudent;
    bdc.name = namecontroller.text;
    bdc.age = int.parse(agecontroller.text);
    bdc.dateofbirth = dateofbirthcontroller.text;
    bdc.hobbits = hobbitscontroller.text;
    bdc.descriptions = descriptioncontroller.text;
    bdc.onUpdate(widget.estudiante);
    Navigator.of(context).pop();
  }

  void ondelete() {
    bdc.setboxBD = widget.boxstudent;
    bdc.onDelete(widget.estudiante.id);
    Navigator.of(context).pop();
  }

  void Validar() {
    if (llaveform.currentState!.validate()) {
      llaveform.currentState!.save();
      //------------------------------------------------------
      onUpdate();
      //------------------------------------------------------
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
          title: Text("Estudiante ${namecontroller.text}"),
        ),
        body: Center(
          child: Form(
            key: llaveform,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextForm(namecontroller, TextInputType.text, "Nombre", 1),
                TextForm(agecontroller, TextInputType.number, "Edad", 1),
                // DateForm(dateofbirthcontroller, "Fecha Nacimiento"),
                TextForm(
                    hobbitscontroller, TextInputType.text, "Pasatiempos", 1),
                TextForm(descriptioncontroller, TextInputType.text,
                    "Descripción", 1),
                Btnfecha(obtfecha, "FechaNac", dateofbirthcontroller),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BtnGen(ondelete, "Eliminar"),
                    SizedBox(
                      width: 25,
                    ),
                    BtnGen(onUpdate, "Modificar")
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
