import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DataClassName('LikedCatDb')
class LikedCats extends Table {
  TextColumn get id => text()();
  TextColumn get imageUrl => text()();
  TextColumn get breedName => text()();
  DateTimeColumn get likedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [LikedCats])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<LikedCatDb>> getAllLikedCats() => select(likedCats).get();

  Future<void> insertLikedCat(LikedCatDb cat) =>
      into(likedCats).insertOnConflictUpdate(cat);

  Future<void> deleteLikedCat(String id) =>
      (delete(likedCats)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> isLiked(String id) async {
    final result =
        await (select(likedCats)..where((tbl) => tbl.id.equals(id))).get();
    return result.isNotEmpty;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'kitty_likes.db'));
    return NativeDatabase(file);
  });
}
