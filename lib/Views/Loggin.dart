// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:studentregistration/Controlador/LogginController.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:studentregistration/objectbox.g.dart';

class Loggin extends StatefulWidget {
  Loggin({Key? key}) : super(key: key);

  @override
  State<Loggin> createState() => _LogginState();
}

class _LogginState extends State<Loggin> {
  late final Store store;
  late final Box<Login> LoginBox;

  var lbdc = LogginController();

  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  Future<void> loadStore() async {
    store = await openStore();
    LoginBox = store.box<Login>();
    lbdc.setboxBD = LoginBox;
    lbdc.nuevoadmin();
    lbdc.loadStudents();
  }

  @override
  void initState() {
    loadStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 33, 41),
      appBar: AppBar(
        title: const Text("Loggin"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 33, 41),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                children: [
                  Image.asset('assets/Loggin.png'),
                  const SizedBox(height: 20),
                  //---------------Divición---------------
                  _formsCreator(
                      txtUser, TextInputType.emailAddress, false, "Usuario"),
                  //---------------Divición---------------
                  const SizedBox(height: 20),
                  //---------------Divición---------------
                  _formsCreator(
                      txtPassword, TextInputType.text, true, "Contraseña"),
                  //---------------Divición---------------
                  const SizedBox(height: 40),
                  //---------------Divición---------------
                  ElevatedButton(
                    onPressed: () {
                      validar(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 19, 49, 60),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('Ingresar'),
                  ),
                  //---------------Divición---------------
                ],
              ),
            ),
          ]),
    );
  }

  Widget _formsCreator(TextEditingController controlador, TextInputType tipo,
      bool oscutext, String label) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
      controller: controlador,
      keyboardType: tipo,
      obscureText: oscutext,
      decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 3, color: Color.fromARGB(255, 19, 49, 60)),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }

  void validar(BuildContext context) {
    if (txtUser.text != "") {
      if (txtPassword.text != "") {
        if (lbdc.valiuser(txtUser.text)) {
          if (lbdc.valipassword(txtPassword.text)) {
            //Codigo en caso que el loggin sea exitoso
            txtUser.text = "";
            txtPassword.text = "";
            store.close();
            Navigator.popAndPushNamed(context, "ViewStudents");
          } else {
            mostrarAviso(
                context, "Usuario y contraseña incorrectos, favor reintente");
          }
        } else {
          mostrarAviso(
              context, "Usuario y contraseña incorrectos, favor reintente");
        }
      } else {
        mostrarAviso(context, "El campo contraseña no puede estar vacío");
      }
    } else {
      mostrarAviso(context, "El campo usuario no puede estar vacío");
    }
    // txtUser.text = "";
    // txtPassword.text = "";
    // store.close();
    // Navigator.popAndPushNamed(context, "ViewStudents");
  }
}

void mostrarAviso(BuildContext context, String info) {
  //AlertDialog en caso que no se encuentre ningún auto en el parqueo
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
            //----------------------------------
            //Buton OK para salir del AlertDialog
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
            //----------------------------------
          ],
          // Codigo para darle border redondos al cuadro del AlertDialog
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
      //Ocultar el dialogo al precionar fuera de el
      barrierDismissible: true);
}
