import 'package:samsung_clock_app_clone/models/alarm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AlarmsDatabase {
  static final AlarmsDatabase instance = AlarmsDatabase._init();
  static Database? _database;

  AlarmsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('alarms.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableAlarms (${AlarmFields.id} $idType, ${AlarmFields.isEnabled} $boolType, ${AlarmFields.alarmTime} $textType);''');
  }

  Future<Alarm?> create(Alarm alarm) async {
    final db = await instance.database;
    final id = await db.insert(tableAlarms, alarm.toJson());
    return alarm.copy(id: id);
  }

  Future<Alarm?> readAlarm(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAlarms,
      columns: AlarmFields.values,
      where: '${AlarmFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Alarm.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Alarm?>> readAllAlarms() async {
    final db = await instance.database;

    final maps = await db.query(
      tableAlarms,
    );

    if (maps.isNotEmpty) {
      return maps.map((map) => Alarm.fromJson(map)).toList();
    } else {
      return [];
    }
  }

  Future<int> update(Alarm alarm) async {
    final db = await instance.database;

    return db.update(
      tableAlarms,
      alarm.toJson(),
      where: '${AlarmFields.id} = ?',
      whereArgs: [alarm.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableAlarms,
      where: '${AlarmFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}