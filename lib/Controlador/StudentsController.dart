import '../Models/BD.dart';
import '../objectbox.g.dart';

class StudentController {
  late final Box<Students> _studentBox;

  late int id;
  late String name;
  late int age;
  late String dateofbirth;
  late String hobbits;
  late String descriptions;

  set setboxBD(Box<Students> box) {
    _studentBox = box;
  }

  void newStudent() {
    final result = Students(
        name: name,
        age: age,
        dateofbirth: dateofbirth,
        hobbits: hobbits,
        descriptions: descriptions);

    _studentBox.put(result);
  }

  void onUpdate(Students estudiante) {
    estudiante.name = name;
    estudiante.age = age;
    estudiante.dateofbirth = dateofbirth;
    estudiante.hobbits = hobbits;
    estudiante.descriptions = descriptions;
    _studentBox.put(estudiante);
  }

  void onDelete(int id) {
    _studentBox.remove(id);
  }
}
