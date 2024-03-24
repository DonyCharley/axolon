
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/detail_model.dart';
import '../../model/header_model.dart';
import '../../view/widgets/common_widgets_and_helpers.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'demo_database.db'),
      onCreate: (db, version) {
        db.execute('PRAGMA foreign_keys = ON');
        db.execute(
          'CREATE TABLE headers(id INTEGER PRIMARY KEY AUTOINCREMENT, customer TEXT, note TEXT, date TEXT, grandTotal REAL)',
        );
        db.execute(
          'CREATE TABLE details ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'headerId INTEGER,'
            'productCode TEXT,'
            'productName TEXT,'
            'rate REAL,'
            'quantity REAL,'
            'total REAL,'
           ' FOREIGN KEY (headerId) REFERENCES headers(id) ON DELETE CASCADE'
       ' )',
        );
         db.execute('''
        CREATE TRIGGER update_grandTotal
        AFTER INSERT ON details
        BEGIN
          UPDATE headers
          SET grandTotal = (
            SELECT SUM(total) FROM details WHERE headerId = NEW.headerId
          )
          WHERE id = NEW.headerId;
        END;
      ''');

         db.execute('''
        CREATE TRIGGER update_grandTotal_update
        AFTER UPDATE ON details
        BEGIN
          UPDATE headers
          SET grandTotal = (
            SELECT SUM(total) FROM details WHERE headerId = NEW.headerId
          )
          WHERE id = NEW.headerId;
        END;
      ''');

         db.execute('''
        CREATE TRIGGER update_grandTotal_delete
        AFTER DELETE ON details
        BEGIN
          UPDATE headers
          SET grandTotal = (
            SELECT SUM(total) FROM details WHERE headerId = OLD.headerId
          )
          WHERE id = OLD.headerId;
        END;
      ''');
      },
      onConfigure: (db) async {

        await db.execute('PRAGMA foreign_keys = ON');
      },

      version: 1,
    );
  }

  Future<void> insertHeader(Header header) async {
    final db = await database;
    await db!.insert(
      'headers',
      header.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Header>> getHeaders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('headers');
    //print(maps[1]['grandTotal']);
    return List.generate(maps.length, (i) {

      return Header(
        id: maps[i]['id'],
        customer: maps[i]['customer'],
        note: maps[i]['note'],
        date: DateTime.parse(maps[i]['date']),
        grandTotal: maps[i]['grandTotal'],
      );
    });
  }

  Future<void> updateHeader(Header header) async {

    try {
      final db = await database;
      await db!.update(
        'headers',
        header.toMap(),
        where: 'id = ?',
        whereArgs: [header.id],
      );
    } catch (e) {
      AppToast.showToast("Error while saving! Please try again!");
    }
  }

  Future<void> deleteHeader(int id) async {
    final db = await database;
    await db!.delete(
      'headers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertDetail(Detail detail) async {
    final db = await database;
    await db!.insert(
      'details',
      detail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Detail>> getDetails(int headerId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(
      'details',
      where: 'headerId = ?',
      whereArgs: [headerId],
    );
    return List.generate(maps.length, (i) {
      return Detail(
        id: maps[i]['id'],
        headerId: maps[i]['headerId'],
        productCode: maps[i]['productCode'],
        productName: maps[i]['productName'],
        rate: maps[i]['rate'],
        quantity: maps[i]['quantity'],
        total: maps[i]['total'],
      );
    });
  }

  Future<void> updateDetail(Detail detail) async {
    final db = await database;
    await db!.update(
      'details',
      detail.toMap(),
      where: 'id = ?',
      whereArgs: [detail.id],
    );
  }

  Future<void> deleteDetail(int id,int headerId) async {
    final db = await database;

    await db!.delete(
      'details',
      where: 'id = ?',
      whereArgs: [id],
    );
    final totalResult = await db.rawQuery(
      'SELECT SUM(total) FROM details WHERE headerId = ?',
      [headerId],
    );


    final total = totalResult.first.values.first ?? 0;


    await db.rawUpdate('''
    UPDATE headers
    SET grandTotal = ?
    WHERE id = ?
  ''', [total, headerId]);
    }
  }

