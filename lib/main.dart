import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
//import 'package:simple_beautiful_checklist_exercise/data/mock_database_repository.dart';

import 'package:simple_beautiful_checklist_exercise/data/shared_preferences_database.dart';
import 'package:simple_beautiful_checklist_exercise/src/app.dart';

void main() async {
  // Wird benötigt, um auf SharedPreferences zuzugreifen
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseRepository repository = SharedPreferencesDatabase();

  runApp(App(repository: repository));
}
