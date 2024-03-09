//Realm Database integration interface and implementation
import 'package:ninjaz_task/features/home/data/models/realm_models/post_realm.dart';
import 'package:realm/realm.dart';

abstract class CacheService {
  Future<void> add<T extends RealmObject>(T value);
  Future<void> addAll<T extends RealmObject>(List<T> values);
  Future<List<T>> getAll<T extends RealmObject>([String? query]);
}

class CacheServiceImpl implements CacheService {
  final _realm = Realm(Configuration.local(
    [
      PostRealm.schema,
      OwnerRealm.schema,
    ],
    schemaVersion: 2,
    migrationCallback: (migration, oldSchemaVersion) {
      // Change datatype of publishDate from String to DateTime
      if (oldSchemaVersion == 1) {
        migration.deleteType('PostRealm');
      }
    },
  ));

  @override
  Future<void> add<T extends RealmObject>(T value) async {
    await _realm.writeAsync<T>(() => _realm.add<T>(value, update: true));
  }

  @override
  Future<void> addAll<T extends RealmObject>(List<T> values) async {
    await _realm.writeAsync(() => _realm.addAll<T>(values, update: true));
  }

  @override
  Future<List<T>> getAll<T extends RealmObject>([String? query]) async {
    var realmResult = _realm.all<T>();
    if (query?.isNotEmpty == true) realmResult = realmResult.query(query!);

    return realmResult.toList();
  }
}
