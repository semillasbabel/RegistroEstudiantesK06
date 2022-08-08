import 'package:flutter/material.dart';
import 'package:studentregistration/Models/BD.dart';
import 'package:studentregistration/Views/NewStudent.dart';
import 'package:studentregistration/Views/StudentsInfo.dart';
import 'package:studentregistration/objectbox.g.dart';

class StudentView extends StatefulWidget {
  StudentView({Key? key}) : super(key: key);
  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  final studentlist = <Students>[];
  var ListStudents = <String>[];
  late final Store store;
  late final Box<Students> studentBox;

  Future<void> loadStore() async {
    store = await openStore();
    studentBox = store.box<Students>();
    loadStudents();
  }

  void loadStudents() {
    studentlist.clear();
    setState(() {
      studentlist.addAll(studentBox.getAll());
    });
  }

  @override
  void initState() {
    loadStore();
    super.initState();
  }

  Future<void> addStudent() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddStudentScreen(),
    );
    if (result != null && result is Students) {
      studentBox.put(result);
      loadStudents();
    }
  }

  Future<void> verInfo(Students estudiante) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => studeninf(
              boxstudent: studentBox,
              estudiante: estudiante,
            )));
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 33, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 33, 41),
        title: const Text("Estudiantes"),
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: studentlist.isEmpty
          ? const Center(
              child: Text(
                "No hay ningun estudiante registrado",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: studentlist.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        title: Text(
                          "Nombre: ${studentlist[i].name} edad: ${studentlist[i].age}",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onTap: () {
                          verInfo(studentlist[i]);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 19, 49, 60),
          onPressed: addStudent,
          label: const Text("Nuevo Estudiante")),
    );
  }

  void logOut() {
    store.close();
    Navigator.popAndPushNamed(context, "Loggin");
  }
}
