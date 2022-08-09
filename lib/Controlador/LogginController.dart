import '../Models/BD.dart';
import '../objectbox.g.dart';

class LogginController {
  final _Loginlist = <Login>[];
  late final Box<Login> _LoginBox;

  set setboxBD(Box<Login> box) {
    _LoginBox = box;
  }

  void newadmin() {
    if (_Loginlist.isEmpty) {
      var result =
          Login(User: "keiler.cortes@grupobabel.com", Password: "12345");
      _LoginBox.put(result);
      result = Login(User: "andres.diaz@grupobabel.com", Password: "12345");
      _LoginBox.put(result);
      result = Login(User: "hugo.chinchilla@grupobabel.com", Password: "12345");
      _LoginBox.put(result);
    }
  }

  void loadAdmins() {
    _Loginlist.clear();
    _Loginlist.addAll(_LoginBox.getAll());
  }

  bool valiuser(String user) {
    for (var i = 0; i < _Loginlist.length; i++) {
      if (user == _Loginlist[i].User) {
        return true;
      }
    }
    return false;
  }

  bool valipassword(String passwod) {
    for (var i = 0; i < _Loginlist.length; i++) {
      if (passwod == _Loginlist[i].Password) {
        return true;
      }
    }
    return false;
  }
}
