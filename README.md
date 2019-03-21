# Entify Tutorial Lesson 1

Connects to a local Datastore emulator, and starts manipulating entities.

## Requirements

You must have the following installed:

- gcloud: https://cloud.google.com/sdk/install
- Dart SDK: https://www.dartlang.org/tools/sdk#install

## Running

After cloning run

```
pub get
```

to get Dart dependencies, then you can start an in-memory Datastore emulator with

```
gcloud beta emulators datastore start --project=tutorial --no-store-on-disk
```

This will write some things in a hidden folder somewhere in your home directory anyway, you can add
`--data-dir=<path to folder>` parameter, if you prefer managing this yourself. Leave out
`--no-store-on-disk` if you want persistence between emulator starts.

With the emulator running you can start the demo application with issuing this command from your
repository clone root:

```
dart bin/main.dart
```

Running the application again and again the app will print the time difference since the last time
it was launched (assuming the in-memory Datastore emulator was not restarted between two runs).
