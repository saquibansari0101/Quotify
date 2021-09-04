

import 'dart:async';

import 'package:Quotify/database/quote_dao.dart';
import 'package:Quotify/database/quote_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Quote])
abstract class AppDatabase extends FloorDatabase{
  QuoteDao get quoteDao;
}