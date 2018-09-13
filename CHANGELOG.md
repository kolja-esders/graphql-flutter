## [1.0.0-alpha.6] - September 10 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Updated lint options in preparation for upcoming CI checks. @HofmannZ

#### Docs

n/a

## [1.0.0-alpha.5] - September 7 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Fixed a bug where the wrong key was selected from the context map. @HofmannZ
- Fixed a scenario where the dispose method was calling the `close` method on the `observableQuery` class which might not have been initialised yet. @HofmannZ
- Added the `onComplete` callback for the `Mutation` widget. @HofmannZ
- Added the `initPayload` as an optional parameter for the `connect` method on the `SocketClient` class. @lordgreg

#### Docs

- Added an example of optionally overriding http options trough the context. @HofmannZ
- Added @lordgreg as a contributor. @HofmannZ
- Updated the example with explicit type casting. @HofmannZ
- Updated the `Mutation` example with the new `onComplete` callback. @HofmannZ

## [1.0.0-alpha.4] - September 4 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Always return something from the `read` method in the cache class. @HofmannZ
- Only save to cache with certain fetch policies. @HofmannZ
- Throw an error when no data from network with certain fetch policies. @HofmannZ
- Added a document parser. @HofmannZ
- Added operation name from document to the operation. @HofmannZ
- Only create a new observable query if options have changed. @HofmannZ
- Add context to the links. @HofmannZ
- Parse context in the http link to update the config. @HofmannZ
- Change the type of context from dynamic to Map<String, dynamic. @HofmannZ

#### Docs

n/a

## [1.0.0-alpha.3] - September 2 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Reverted changes to the required Dart version. @HofmannZ
- Added missing return statsments. @HofmannZ

#### Docs

n/a

## [1.0.0-alpha.2] - September 2 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- `GraphQLClient` now reads and writes data from the `Cache` based on the provided `FetchPolicy` option. @HofmannZ
- Implemented caching for data from `FetchResults`. @HofmannZ
- The library now tagets Dart version `>=2.1.0-dev.0.0 <3.0.0` as recomended by Flutter `0.6.0`. @HofmannZ
- Removed the old client from the library. @HofmannZ

#### Docs

- Document the new API. @HofmannZ
- Write an upgrade guide. @HofmannZ
- Clean up the example. @HofmannZ

## [1.0.0-alpha.1] - September 2 2018

### Breaking changes

- Renamed `Client` to `GraphQLClient` to avoid name collision with other packages. @HofmannZ
- Renamed `GraphqlProvider` to `GraphQLProvider` to align with new naming. @HofmannZ
- Renamed `GraphqlConsumer` to `GraphQLConsumer` to align with new naming. @HofmannZ
- Renamed `GQLError` to `GraphQLError` to align with new naming. @HofmannZ
- `GraphQLClient` requires a `Link` to passed into the constructor. @HofmannZ
- `GraphQLClient` no longer requires a `endPoint` or `apiToken` to be passed into the constructor. Instead you can provide it to the `Link`. @HofmannZ
- The `Query` and `Mutation` widgets are now `StreamBuilders`, there the api did change slightly. @HofmannZ

#### Fixes / Enhancements

- Improved typing throughout the library. @HofmannZ
- Queries are handled as streams of operations. @HofmannZ
- Added the `HttpLink` to handle requests using http. @HofmannZ
- `HttpLink` allows headers to be customised. @HofmannZ
- The api allows contributors to write their own custom links. @HofmannZ

#### Docs

- Implement the new link system in the example. @HofmannZ

## [0.9.3] - September 5 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Fix wrong typedef causing runtime type mismatch. @HofmannZ

#### Docs

- Update the reference to the next branch. @HofmannZ

## [0.9.2] - 2 September 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Upgrade dependencies. @HofmannZ

#### Docs

- Added a refrence to our next major release. @HofmannZ

## [0.9.1] - August 30 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Move test dependency to the dev section. @fabiocarneiro
- Fix version resolving for test dependencies. @HofmannZ

#### Docs

n/a

## [0.9.0] - August 23 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Added error extensions support. @dustin-graham
- Changed the mutation typedef to return a Future, allowing async/await. @HofmannZ
- Fixed error handling when location is not provided. @adelcasse
- Fixed a bug where the client might no longer be in the same context. @HofmannZ

#### Docs

n/a

## [0.8.0] - August 10 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Added basic error handeling for queries and mutations @mmadjer
- Added missing export for the `GraphqlConsumer` widget @AleksandarFaraj

#### Docs

n/a

## [0.7.1] - August 3 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Code formatting @HofmannZ

#### Docs

- Updated the package description @HofmannZ

## [0.7.0] - July 22 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Added support for subsciptions in the client. @cal-pratt
- Added the `Subscription` widget. You can no direcly acces streams from Flutter. @cal-pratt

#### Docs

- Added instructions for adding subscripton to your poject. @cal-pratt
- Updated the `About this project` section. @HofmannZ

## [0.6.0] - July 19 2018

### Breaking changes

- The library now requires your app to be wrapped with the `GraphqlProvider` widget. @HofmannZ
- The global `client` variable is no longer available. Instead use the `GraphqlConsumer` widget. @HofmannZ

#### Fixes / Enhancements

- Added the `GraphqlProvider` widget. The client is now stored in an `InheritedWidget`, and can be accessed anywhere within the app. @HofmannZ

```dart
Client client = GraphqlProvider.of(context).value;
```

- Added the `GraphqlConsumer` widget. For ease of use we added a widget that uses the same builder structure as the `Query` and `Mutation` widgets. @HofmannZ

> Under the hood it access the client from the `BuildContext`.

- Added the option to optionally provide the `apiToken` to the `Client` constructor. It is still possible to set the `apiToken` with setter method. @HofmannZ

```dart
  return new GraphqlConsumer(
    builder: (Client client) {
      // do something with the client

      return new Container();
    },
  );
```

#### Docs

- Added documentation for the new `GraphqlProvider` @HofmannZ
- Added documentation for the new `GraphqlConsumer` @HofmannZ
- Changed the setup instructions to include the new widgets @HofmannZ
- Changed the example to include the new widgets @HofmannZ

## [0.5.4] - July 17 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Query: changed `Timer` to `Timer.periodic` @eusdima
- Minor logic tweak @eusdima
- Use absolute paths in the library @HofmannZ

#### Docs

- Fix mutations example bug not updating star bool @cal-pratt

## [0.5.3] - July 13 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Added polling timer as a variable for easy deletion on dispose
- Fixed bug when Query timer is still active when the Query is disposed
- Added instant query fetch when the query variables are updated

#### Docs

n/a

## [0.5.2] - July 11 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Fixed error when cache file is non-existent

#### Docs

n/a

## [0.5.1] - June 29 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Fixed json error parsing.

#### Docs

n/a

## [0.5.0] - June 25 2018

### Breaking changes

n/a

#### Fixes / Enhancements

- Introduced `onCompleted` callback for mutiations.
- Excluded some config files from version control.

#### Docs

- Fixed typos in the `readme.md`.
- The examples inculde an example of the `onCompleted` callback.

## [0.4.1] - June 22 2018

### Breaking changes

n/a

#### Fixes / Enhancements

n/a

#### Docs

- The examples now porperly reflect the changes to the library.

## [0.4.0] - June 21 2018

### Breaking changes

- The Client now requires a from of cache.
- The name of the `execute` method on the `Client` class changed to `query`.

#### Fixes / Enhancements

- Implemented in-memory cache.
- Write memory to file when in background.
- Added provider widget to save and restore the in-memory cache.
- Restructure the project.

#### Docs

- Update the `README.md` to refelct changes in the code.
- update the example to refelct changes in the code.

## [0.3.0] - June 16 2018

### Breaking changes

- Changed data type to `Map` instaid of `Object` to be more explicit.

#### Fixes / Enhancements

- Cosmatic changes.

#### Docs

- Added a Flutter app example.
- Fixed the example in `README.md`.
- Added more badges.

## [0.2.0] - June 15 2018

### Breaking changes

- Changed query widget `polling` argument to `pollInterval`, following the [react-apollo](https://github.com/apollographql/react-apollo) api.

#### Fixes / Enhancements

- Query polling is now optional.

#### Docs

- Updated the docs with the changes in api.

## [0.1.0] - June 15 2018

My colleague and I created a simple implementation of a GraphQL Client for Flutter. (Many thanks to Eus Dima, for his work on the initial client.)

### Breaking changes

n/a

#### Fixes / Enhancements

- A client to connect to your GraphQL server.
- A query widget to handle GraphQL queries.
- A mutation widget to handle GraphQL mutations.
- Simple support for query polling.

#### Docs

- Initial documentation.
