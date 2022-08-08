// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:intl/intl.dart';

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

  void onSave() {
    widget.estudiante.name = namecontroller.text;
    widget.estudiante.age = int.parse(agecontroller.text);
    widget.estudiante.dateofbirth = dateofbirthcontroller.text;
    widget.estudiante.hobbits = hobbitscontroller.text;
    widget.estudiante.descriptions = descriptioncontroller.text;
    widget.boxstudent.put(widget.estudiante);
    Navigator.of(context).pop();
  }

  void ondelete() {
    widget.boxstudent.remove(widget.estudiante.id);
    Navigator.of(context).pop();
  }

  void Validar() {
    if (llaveform.currentState!.validate()) {
      llaveform.currentState!.save();
      //------------------------------------------------------
      onSave();
      //------------------------------------------------------
    }
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
                DateForm(dateofbirthcontroller, "Fecha Nacimiento"),
                TextForm(
                    hobbitscontroller, TextInputType.text, "Pasatiempos", 2),
                TextForm(descriptioncontroller, TextInputType.text,
                    "Descripción", 2),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BtnEliminar(),
                    SizedBox(
                      width: 25,
                    ),
                    BtnModificar(),
                  ],
                )
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

  Widget BtnEliminar() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 19, 49, 60),
        ),
        onPressed: () {
          ondelete();
        },
        child: Text("Eliminar"));
  }

  Widget BtnModificar() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 19, 49, 60),
        ),
        onPressed: () {
          Validar();
        },
        child: Text("Modificar"));
  }
}
