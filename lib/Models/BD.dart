// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class Students {
  int id = 0;
  String name;
  int age;
  String dateofbirth;
  String hobbits;
  String descriptions;
  Students({
    required this.name,
    required this.age,
    required this.dateofbirth,
    required this.hobbits,
    required this.descriptions,
  });
}

@Entity()
class Login {
  int id = 0;
  String User;
  String Password;
  Login({
    this.id = 0,
    required this.User,
    required this.Password,
  });
}
