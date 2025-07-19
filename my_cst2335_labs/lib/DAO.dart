import 'package:floor/floor.dart';
import 'AppList.dart';

@dao
abstract class AppListDao {
  @Query('SELECT * FROM AppList')
  Future<List<AppList>> findAllItems();

  @insert
  Future<void> insertItem(AppList item);

  @delete
  Future<void> deleteItem(AppList item);
}