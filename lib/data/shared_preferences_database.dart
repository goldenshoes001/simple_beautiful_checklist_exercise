import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesDatabase implements DatabaseRepository {
  SharedPreferences? pref;
  List<String> stringList = [];
  @override
  Future<void> addItem(String item) async {
    await pref!.setString(item, item);
    stringList.add(item);
  }

  @override
  Future<void> deleteItem(int index) async {
    pref!.remove(stringList.elementAt(index));
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    stringList[index] = newItem;
  }

  @override
  Future<int> getItemCount() async {
    return stringList.length;
  }

  @override
  Future<List<String>> getItems() async {
    return stringList;
  }
}
