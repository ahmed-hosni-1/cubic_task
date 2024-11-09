class AppRegExp {
  AppRegExp._();
  static AppRegExp? _instance;
  static AppRegExp get instance => _instance ??= AppRegExp._();

  RegExp email =RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  RegExp phone = RegExp(r'^[0-9]{11}$');
  RegExp name = RegExp(r'^[a-zA-Z ]+$');

}
