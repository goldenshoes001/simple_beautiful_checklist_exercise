import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesDatabase implements DatabaseRepository {
  SharedPreferences? pref;
  List<String> stringList = [];
  String listkey = "meineListe";
  static int counter = 0;

  Future<void> loadData() async {
    try {
      if (pref != null) {
        stringList = pref!.getStringList(listkey) ?? [];
        counter = pref!.getInt("tasks") ?? 0;
      }
    } catch (e) {
      debugPrint("Fehler in loadData aufgetreten $e");
    }
  }

  Future<void> _saveData() async {
    try {
      if (pref != null) {
        await pref!.setStringList(listkey, stringList);
        await pref!.setInt("tasks", counter);
      }
    } catch (e) {
      debugPrint("Fehler in save data aufgetreten: $e");
    }
  }

  Future<void> initpref() async {
    try {
      pref = await SharedPreferences.getInstance();
      await loadData();
    } catch (e) {
      debugPrint("Fehler in initpref aufgetreten +$e");
    }
  }

  @override
  Future<void> addItem(String item) async {
    try {
      if (!stringList.contains(item)) {
        counter++;
        stringList.add(item);
        await _saveData();
      } else {
        debugPrint("item ist schon drinnen");
      }
    } catch (e) {
      debugPrint("Fehler in addItem aufgetreten $e");
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    stringList.removeAt(index);
    await _saveData();
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    try {
      stringList[index] = newItem;
      await _saveData();
    } catch (e) {
      debugPrint("Fehler in editItem aufgetreten $e");
    }
  }

  @override
  Future<int> getItemCount() async {
    try {
      return stringList.length;
    } catch (e) {
      debugPrint("Fehler in getItemCount aufgetreten $e");
    }
    return -1;
  }

  @override
  Future<List<String>> getItems() async {
    try {
      return stringList;
    } catch (e) {
      debugPrint("Fehler in getItems aufgetreten $e");
    }
    return [];
  }
}
