import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'AppList.dart';
import 'DAO.dart';

part 'Database.g.dart'; // GENERATED FILE

@Database(version: 1, entities: [AppList])
abstract class AppDatabase extends FloorDatabase {
  AppListDao get appListDao;
}