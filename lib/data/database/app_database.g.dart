// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LikedCatsTable extends LikedCats
    with TableInfo<$LikedCatsTable, LikedCatDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikedCatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedNameMeta = const VerificationMeta(
    'breedName',
  );
  @override
  late final GeneratedColumn<String> breedName = GeneratedColumn<String>(
    'breed_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likedAtMeta = const VerificationMeta(
    'likedAt',
  );
  @override
  late final GeneratedColumn<DateTime> likedAt = GeneratedColumn<DateTime>(
    'liked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, imageUrl, breedName, likedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liked_cats';
  @override
  VerificationContext validateIntegrity(
    Insertable<LikedCatDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('breed_name')) {
      context.handle(
        _breedNameMeta,
        breedName.isAcceptableOrUnknown(data['breed_name']!, _breedNameMeta),
      );
    } else if (isInserting) {
      context.missing(_breedNameMeta);
    }
    if (data.containsKey('liked_at')) {
      context.handle(
        _likedAtMeta,
        likedAt.isAcceptableOrUnknown(data['liked_at']!, _likedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_likedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LikedCatDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LikedCatDb(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      breedName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}breed_name'],
          )!,
      likedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}liked_at'],
          )!,
    );
  }

  @override
  $LikedCatsTable createAlias(String alias) {
    return $LikedCatsTable(attachedDatabase, alias);
  }
}

class LikedCatDb extends DataClass implements Insertable<LikedCatDb> {
  final String id;
  final String imageUrl;
  final String breedName;
  final DateTime likedAt;
  const LikedCatDb({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    required this.likedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['breed_name'] = Variable<String>(breedName);
    map['liked_at'] = Variable<DateTime>(likedAt);
    return map;
  }

  LikedCatsCompanion toCompanion(bool nullToAbsent) {
    return LikedCatsCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      breedName: Value(breedName),
      likedAt: Value(likedAt),
    );
  }

  factory LikedCatDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LikedCatDb(
      id: serializer.fromJson<String>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      breedName: serializer.fromJson<String>(json['breedName']),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'breedName': serializer.toJson<String>(breedName),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  LikedCatDb copyWith({
    String? id,
    String? imageUrl,
    String? breedName,
    DateTime? likedAt,
  }) => LikedCatDb(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    breedName: breedName ?? this.breedName,
    likedAt: likedAt ?? this.likedAt,
  );
  LikedCatDb copyWithCompanion(LikedCatsCompanion data) {
    return LikedCatDb(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      breedName: data.breedName.present ? data.breedName.value : this.breedName,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatDb(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breedName: $breedName, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imageUrl, breedName, likedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedCatDb &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.breedName == this.breedName &&
          other.likedAt == this.likedAt);
}

class LikedCatsCompanion extends UpdateCompanion<LikedCatDb> {
  final Value<String> id;
  final Value<String> imageUrl;
  final Value<String> breedName;
  final Value<DateTime> likedAt;
  final Value<int> rowid;
  const LikedCatsCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.breedName = const Value.absent(),
    this.likedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LikedCatsCompanion.insert({
    required String id,
    required String imageUrl,
    required String breedName,
    required DateTime likedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imageUrl = Value(imageUrl),
       breedName = Value(breedName),
       likedAt = Value(likedAt);
  static Insertable<LikedCatDb> custom({
    Expression<String>? id,
    Expression<String>? imageUrl,
    Expression<String>? breedName,
    Expression<DateTime>? likedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (breedName != null) 'breed_name': breedName,
      if (likedAt != null) 'liked_at': likedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LikedCatsCompanion copyWith({
    Value<String>? id,
    Value<String>? imageUrl,
    Value<String>? breedName,
    Value<DateTime>? likedAt,
    Value<int>? rowid,
  }) {
    return LikedCatsCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breedName: breedName ?? this.breedName,
      likedAt: likedAt ?? this.likedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (breedName.present) {
      map['breed_name'] = Variable<String>(breedName.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<DateTime>(likedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatsCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breedName: $breedName, ')
          ..write('likedAt: $likedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LikedCatsTable likedCats = $LikedCatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [likedCats];
}

typedef $$LikedCatsTableCreateCompanionBuilder =
    LikedCatsCompanion Function({
      required String id,
      required String imageUrl,
      required String breedName,
      required DateTime likedAt,
      Value<int> rowid,
    });
typedef $$LikedCatsTableUpdateCompanionBuilder =
    LikedCatsCompanion Function({
      Value<String> id,
      Value<String> imageUrl,
      Value<String> breedName,
      Value<DateTime> likedAt,
      Value<int> rowid,
    });

class $$LikedCatsTableFilterComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breedName => $composableBuilder(
    column: $table.breedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LikedCatsTableOrderingComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breedName => $composableBuilder(
    column: $table.breedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LikedCatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get breedName =>
      $composableBuilder(column: $table.breedName, builder: (column) => column);

  GeneratedColumn<DateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);
}

class $$LikedCatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LikedCatsTable,
          LikedCatDb,
          $$LikedCatsTableFilterComposer,
          $$LikedCatsTableOrderingComposer,
          $$LikedCatsTableAnnotationComposer,
          $$LikedCatsTableCreateCompanionBuilder,
          $$LikedCatsTableUpdateCompanionBuilder,
          (
            LikedCatDb,
            BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCatDb>,
          ),
          LikedCatDb,
          PrefetchHooks Function()
        > {
  $$LikedCatsTableTableManager(_$AppDatabase db, $LikedCatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LikedCatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LikedCatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LikedCatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> breedName = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsCompanion(
                id: id,
                imageUrl: imageUrl,
                breedName: breedName,
                likedAt: likedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imageUrl,
                required String breedName,
                required DateTime likedAt,
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                breedName: breedName,
                likedAt: likedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LikedCatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LikedCatsTable,
      LikedCatDb,
      $$LikedCatsTableFilterComposer,
      $$LikedCatsTableOrderingComposer,
      $$LikedCatsTableAnnotationComposer,
      $$LikedCatsTableCreateCompanionBuilder,
      $$LikedCatsTableUpdateCompanionBuilder,
      (LikedCatDb, BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCatDb>),
      LikedCatDb,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LikedCatsTableTableManager get likedCats =>
      $$LikedCatsTableTableManager(_db, _db.likedCats);
}
