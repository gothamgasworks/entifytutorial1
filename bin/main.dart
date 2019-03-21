import "package:http/http.dart" as http;
import "package:googleapis/datastore/v1.dart" as ds;
import "package:entify/entify.dart";

http.Client theClient;

Future<ds.DatastoreApi> getDatastoreApi() async {
  // not the nicest way to do it, but we must
  // store the client reference so we can close
  // it, otherwise the script would not quit until
  // it times out
  theClient ??= new http.Client();
  return new ds.DatastoreApi(theClient,
      rootUrl: "http://localhost:8081/");
}
const String appId = "tutorial";

Future<DatastoreShell> getDatastoreShell() =>
    getDatastoreApi().then((api) => new DatastoreShell(api, appId));

Future<void> insertOrUpdateEntity(DatastoreShell ds) async {
  Key entityKey = new Key("Event", name: "last");
  int now = new DateTime.now().millisecondsSinceEpoch;
  Entity e = new Entity();
  e.key = entityKey;
  e.indexed["timestamp"] = now;
  try {
    Entity old = await ds.getSingle(entityKey);
    Duration diff = new Duration(milliseconds: now - old["timestamp"]);
    print("Time difference between this run and last run: $diff");
    await ds.beginMutation().update(e).commit();
    print("Entity successfully updated");
  } on EntityNotFoundError {
    await ds.beginMutation().insert(e).commit();
    print("Entity successfully inserted");
  }
}

Future<void> main() async {
  DatastoreShell ds = await getDatastoreShell();
  await insertOrUpdateEntity(ds);
  theClient.close();
}
