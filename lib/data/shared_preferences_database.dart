import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesDatabase implements DatabaseRepository {
  SharedPreferences? pref;
  List<String> stringList = [];
  String listkey = "meineListe";
  static int counter = 0;

  Future<void> loadData() async {
    if (pref != null) {
      stringList = pref!.getStringList(listkey) ?? [];
      counter = pref!.getInt("tasks")?? 0;
    }
  }

  Future<void> _saveData() async {
    if (pref != null) {
      await pref!.setStringList(listkey, stringList);
      await pref!.setInt("tasks", counter);
    }
  }

  Future<void> initpref() async {
    pref = await SharedPreferences.getInstance();
    await loadData();
  }

  @override
  Future<void> addItem(String item) async {
    if (!stringList.contains(item)) {
      counter++;
      stringList.add(item);
      await _saveData();
    } else {
      debugPrint("item ist schon drinnen");
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    stringList.removeAt(index);
    await _saveData();
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    stringList[index] = newItem;
    await _saveData();
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
