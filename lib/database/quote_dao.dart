import 'package:Quotify/database/quote_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class QuoteDao {
  @Query('SELECT * FROM quote WHERE id = :id')
  Future<Quote?> findQuoteById(int id);

  @Query('SELECT * FROM quote')
  Future<Quote?> findAllQuote();

  @Query('SELECT * FROM quote')
  Stream<List<Quote>> findAllQuotesAsStream();

  @insert
  Future<void> insertQuote(Quote quote);

  @update
  Future<void> updateQuote(Quote quote);

  @delete
  Future<void> deleteQuote(Quote quote);

}