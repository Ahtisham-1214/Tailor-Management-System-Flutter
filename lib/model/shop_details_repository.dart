import 'package:flutter/cupertino.dart';
import 'package:tailor_management/model/database_helper.dart';
import 'package:tailor_management/model/shop_details.dart';

class ShopDetailsRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> setShopDetails(ShopDetail shopDetail) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> existing = await db.query('shopDetails');
    if (existing.isEmpty) {
      await db.insert('shopDetails', shopDetail.toMap());
    } else {
      int id = existing.first['id'];
      await db.update(
          'shopDetails', shopDetail.toMap(), where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<ShopDetail?> getShopDetails() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('shopDetails');
    if (maps.isEmpty) return null;

    try {
      return ShopDetail.fromMap(maps.first);
    } catch (e) {
      debugPrint('Error parsing shop details from database: $e');
      return null;
    }
  }


}