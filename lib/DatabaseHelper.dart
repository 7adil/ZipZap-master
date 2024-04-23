import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final _databaseName = 'formData.db';
  static final _databaseVersion = 1;
  static final formDataTable = 'form_data';
  static final formDataColumnId = '_id';
  static final formDataColumnName = 'name';
  static final formDataColumnAddress = 'address';
  static final formDataColumnPhoneNumber = 'phone_number';
  static final formDataColumnEmail = 'email';
  static final formDataColumnDate = 'date';
  static final driversTable = 'drivers';
  static final driversColumnId = '_id';
  static final driversColumnName = 'name';
  static final driversColumnCategory = 'category';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static late Database _database;
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $formDataTable (
        $formDataColumnId INTEGER PRIMARY KEY,
        $formDataColumnName TEXT,
        $formDataColumnAddress TEXT,
        $formDataColumnPhoneNumber TEXT,
        $formDataColumnEmail TEXT,
        $formDataColumnDate TEXT
      )
      ''');
    await db.execute('''
      CREATE TABLE $driversTable (
        $driversColumnId INTEGER PRIMARY KEY,
        $driversColumnName TEXT,
        $driversColumnCategory TEXT
      )
      ''');
  }
  Future<int> insertForm(FormData formData) async {
    Database db = await instance.database;
    return await db.insert(formDataTable, formData.toMap());
  }
  Future<int> insertDriver(String name, String category) async {
    Database db = await instance.database;
    return await db.insert(driversTable, {
      driversColumnName: name,
      driversColumnCategory: category,
    });
  }
  Future<List<Map<String, dynamic>>> queryAllDrivers() async {
    Database db = await instance.database;
    return await db.query(driversTable);
  }
  Future<void> printAllDrivers() async {
    List<Map<String, dynamic>> drivers = await queryAllDrivers();
    drivers.forEach((driver) {
      print('Driver: ${driver[driversColumnName]}, Category: ${driver[driversColumnCategory]}');
    });
  }
}
class FormData {
  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final String date;
  FormData({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'date': date,
    };
  }
}