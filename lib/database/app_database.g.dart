// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  QuoteDao? _quoteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Quote` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `quote` TEXT, `author` TEXT, `tags` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  QuoteDao get quoteDao {
    return _quoteDaoInstance ??= _$QuoteDao(database, changeListener);
  }
}

class _$QuoteDao extends QuoteDao {
  _$QuoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _quoteInsertionAdapter = InsertionAdapter(
            database,
            'Quote',
            (Quote item) => <String, Object?>{
                  'id': item.id,
                  'quote': item.quote,
                  'author': item.author,
                  'tags': item.tags
                },
            changeListener),
        _quoteUpdateAdapter = UpdateAdapter(
            database,
            'Quote',
            ['id'],
            (Quote item) => <String, Object?>{
                  'id': item.id,
                  'quote': item.quote,
                  'author': item.author,
                  'tags': item.tags
                },
            changeListener),
        _quoteDeletionAdapter = DeletionAdapter(
            database,
            'Quote',
            ['id'],
            (Quote item) => <String, Object?>{
                  'id': item.id,
                  'quote': item.quote,
                  'author': item.author,
                  'tags': item.tags
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Quote> _quoteInsertionAdapter;

  final UpdateAdapter<Quote> _quoteUpdateAdapter;

  final DeletionAdapter<Quote> _quoteDeletionAdapter;

  @override
  Future<Quote?> findQuoteById(int id) async {
    return _queryAdapter.query('SELECT * FROM quote WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Quote(
            id: row['id'] as int?,
            quote: row['quote'] as String?,
            author: row['author'] as String?,
            tags: row['tags'] as String?),
        arguments: [id]);
  }

  @override
  Future<Quote?> findAllQuote() async {
    return _queryAdapter.query('SELECT * FROM quote',
        mapper: (Map<String, Object?> row) => Quote(
            id: row['id'] as int?,
            quote: row['quote'] as String?,
            author: row['author'] as String?,
            tags: row['tags'] as String?));
  }

  @override
  Stream<List<Quote>> findAllQuotesAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM quote',
        mapper: (Map<String, Object?> row) => Quote(
            id: row['id'] as int?,
            quote: row['quote'] as String?,
            author: row['author'] as String?,
            tags: row['tags'] as String?),
        queryableName: 'Quote',
        isView: false);
  }

  @override
  Future<Quote?> findIfPresent(String quote) async {
    return _queryAdapter.query('SELECT * FROM quote WHERE quote = ?1',
        mapper: (Map<String, Object?> row) => Quote(
            id: row['id'] as int?,
            quote: row['quote'] as String?,
            author: row['author'] as String?,
            tags: row['tags'] as String?),
        arguments: [quote]);
  }

  @override
  Future<void> insertQuote(Quote quote) async {
    await _quoteInsertionAdapter.insert(quote, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateQuote(Quote quote) async {
    await _quoteUpdateAdapter.update(quote, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteQuote(Quote quote) async {
    await _quoteDeletionAdapter.delete(quote);
  }
}
