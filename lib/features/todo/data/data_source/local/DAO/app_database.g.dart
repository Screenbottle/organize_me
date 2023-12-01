// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppdatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppdatabaseBuilder databaseBuilder(String name) =>
      _$AppdatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppdatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppdatabaseBuilder(null);
}

class _$AppdatabaseBuilder {
  _$AppdatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppdatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppdatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<Appdatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$Appdatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$Appdatabase extends Appdatabase {
  _$Appdatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `todo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `content` TEXT, `title` TEXT, `description` TEXT, `done` INTEGER, `createdDate` TEXT, `deadlineDate` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDAO {
    return _todoDAOInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _toDoModelInsertionAdapter = InsertionAdapter(
            database,
            'todo',
            (ToDoModel item) => <String, Object?>{
                  'id': item.id,
                  'content': item.content,
                  'title': item.title,
                  'description': item.description,
                  'done': item.done == null ? null : (item.done! ? 1 : 0),
                  'createdDate': item.createdDate,
                  'deadlineDate': item.deadlineDate
                }),
        _toDoModelDeletionAdapter = DeletionAdapter(
            database,
            'todo',
            ['id'],
            (ToDoModel item) => <String, Object?>{
                  'id': item.id,
                  'content': item.content,
                  'title': item.title,
                  'description': item.description,
                  'done': item.done == null ? null : (item.done! ? 1 : 0),
                  'createdDate': item.createdDate,
                  'deadlineDate': item.deadlineDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDoModel> _toDoModelInsertionAdapter;

  final DeletionAdapter<ToDoModel> _toDoModelDeletionAdapter;

  @override
  Future<List<ToDoModel>> getTodo() async {
    return _queryAdapter.queryList('SELECT * FROM model',
        mapper: (Map<String, Object?> row) => ToDoModel(
            id: row['id'] as int?,
            content: row['content'] as String?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            done: row['done'] == null ? null : (row['done'] as int) != 0,
            createdDate: row['createdDate'] as String?,
            deadlineDate: row['deadlineDate'] as String?));
  }

  @override
  Future<void> insert(ToDoModel todo) async {
    await _toDoModelInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(ToDoModel toDoModel) async {
    await _toDoModelDeletionAdapter.delete(toDoModel);
  }
}
