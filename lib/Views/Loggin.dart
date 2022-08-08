// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:studentregistration/objectbox.g.dart';

class Loggin extends StatefulWidget {
  Loggin({Key? key}) : super(key: key);

  @override
  State<Loggin> createState() => _LogginState();
}

class _LogginState extends State<Loggin> {
  final Loginlist = <Login>[];

  late final Store store;

  late final Box<Login> LoginBox;

  TextEditingController txtUser = TextEditingController();

  TextEditingController txtPassword = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> loadStore() async {
    store = await openStore();
    LoginBox = store.box<Login>();
    nuevoadmin();
    loadStudents();
  }

  void nuevoadmin() {
    if (Loginlist.isEmpty) {
      var result =
          Login(User: "keiler.cortes@grupobabel.com", Password: "12345");
      LoginBox.put(result);
      result = Login(User: "andres.diaz@grupobabel.com", Password: "12345");
      LoginBox.put(result);
      result = Login(User: "hugo.chinchilla@grupobabel.com", Password: "12345");
      LoginBox.put(result);
    }
  }

  void loadStudents() {
    Loginlist.clear();
    setState(() {
      Loginlist.addAll(LoginBox.getAll());
    });
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
      body: Form(
        key: formKey,
        child: Column(
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
      ),
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
    if (valiuser()) {
      if (valipassword()) {
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
    // txtUser.text = "";
    // txtPassword.text = "";
    // store.close();
    // Navigator.popAndPushNamed(context, "ViewStudents");
  }

  bool valiuser() {
    for (var i = 0; i < Loginlist.length; i++) {
      if (txtUser.text == Loginlist[i].User) {
        return true;
      }
    }
    return false;
  }

  bool valipassword() {
    for (var i = 0; i < Loginlist.length; i++) {
      if (txtPassword.text == Loginlist[i].Password) {
        return true;
      }
    }
    return false;
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
