import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tailor_management/model/prices.dart';
import 'package:tailor_management/model/database_helper.dart';

class PriceRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> setPrice(Price price) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> existing = await db.query('prices');
    if (existing.isEmpty) {
      await db.insert('prices', price.toMap());
    } else {
      int id = existing.first['id'];
      await db.update('prices', price.toMap(), where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<Price?> getPrice() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('prices');
    if (maps.isEmpty) return null;
    try{
      return Price.fromMap(maps.first);

    }catch(e){
      debugPrint('Error parsing price from database: $e');
      return null;
    }
  }
}
