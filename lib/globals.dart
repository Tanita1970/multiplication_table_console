library globals;

import 'package:multiplication_table_console/services/file_manager.dart';
import 'package:multiplication_table_console/services/user_manager.dart';

final userManager = UserManager();
final fileManager = FileManager();
final registredUsersFilePath = "registered_users.json";
