import 'package:floor/floor.dart';

@entity
class AppList {
  @primaryKey
  final int id;
  final String name;
  final String quantity;

  static int ID = 1;

  AppList(this.id, this.name, this.quantity) {
    if (id >= ID) AppList.ID = id + 1;
  }
}
