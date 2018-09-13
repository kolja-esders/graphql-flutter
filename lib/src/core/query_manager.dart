import 'dart:async';

import 'package:meta/meta.dart';

import 'package:graphql_flutter/src/core/query_options.dart';
import 'package:graphql_flutter/src/core/query_result.dart';
import 'package:graphql_flutter/src/core/graphql_error.dart';
import 'package:graphql_flutter/src/core/observable_query.dart';

import 'package:graphql_flutter/src/scheduler/scheduler.dart';

import 'package:graphql_flutter/src/link/link.dart';
import 'package:graphql_flutter/src/link/operation.dart';
import 'package:graphql_flutter/src/link/fetch_result.dart';

import 'package:graphql_flutter/src/cache/cache.dart';

import 'package:graphql_flutter/src/utilities/get_from_ast.dart';

class QueryManager {
  final Link link;
  final Cache cache;

  QueryScheduler scheduler;
  int idCounter = 1;
  Map<String, ObservableQuery> queries = <String, ObservableQuery>{};

  QueryManager({
    @required this.link,
    @required this.cache,
  }) {
    scheduler = QueryScheduler(
      queryManager: this,
    );
  }

  ObservableQuery watchQuery(WatchQueryOptions options) {
    if (options.document == null) {
      throw Exception(
        'document option is required. You must specify your GraphQL document in the query options.',
      );
    }

    final ObservableQuery observableQuery = ObservableQuery(
      queryManager: this,
      options: options,
    );

    setQuery(observableQuery);

    return observableQuery;
  }

  Future<QueryResult> query(QueryOptions options) {
    return fetchQuery('0', options);
  }

  Future<QueryResult> mutate(MutationOptions options) {
    return fetchQuery('0', options);
  }

  Future<QueryResult> fetchQuery(
    String queryId,
    BaseOptions options,
  ) async {
    final ObservableQuery observableQuery = getQuery(queryId);
    final String operationName = getOperationName(options.document);
    // create a new operation to fetch
    final Operation operation = Operation(
      document: options.document,
      variables: options.variables,
      operationName: operationName,
    );

    FetchResult fetchResult;
    QueryResult queryResult;

    if (options.context != null) {
      operation.setContext(options.context);
    }

    if (options.fetchPolicy == FetchPolicy.cacheFirst ||
        options.fetchPolicy == FetchPolicy.cacheAndNetwork ||
        options.fetchPolicy == FetchPolicy.cacheOnly) {
      final dynamic cachedData = cache.read(operation.toKey());

      if (cachedData != null) {
        fetchResult = FetchResult(
          data: cachedData,
        );

        queryResult = _mapFetchResultToQueryResult(fetchResult);

        // add the result to an observable query if it exists
        if (observableQuery != null) {
          observableQuery.controller.add(queryResult);
        }

        if (options.fetchPolicy == FetchPolicy.cacheFirst ||
            options.fetchPolicy == FetchPolicy.cacheOnly) {
          return queryResult;
        }
      }

      if (options.fetchPolicy == FetchPolicy.cacheOnly) {
        throw Exception(
          'Could not find that operation in the cache. (${options.fetchPolicy.toString()})',
        );
      }
    }

    // execute the operation trough the provided link(s)
    fetchResult = await execute(
      link: link,
      operation: operation,
    ).first;

    // save the data from fetchResult to the cache
    if (fetchResult.data != null &&
        options.fetchPolicy != FetchPolicy.noCache) {
      cache.write(
        operation.toKey(),
        fetchResult.data,
      );
    }

    if (fetchResult.data == null &&
        (options.fetchPolicy == FetchPolicy.noCache ||
            options.fetchPolicy == FetchPolicy.networkOnly)) {
      throw Exception(
        'Could not resolve that operation on the network. (${options.fetchPolicy.toString()})',
      );
    }

    queryResult = _mapFetchResultToQueryResult(fetchResult);

    // add the result to an observable query if it exists
    if (observableQuery != null) {
      observableQuery.controller.add(queryResult);
    }

    return queryResult;
  }

  ObservableQuery getQuery(String queryId) {
    if (queries.containsKey(queryId)) {
      return queries[queryId];
    }

    return null;
  }

  void setQuery(ObservableQuery observableQuery) {
    queries[observableQuery.queryId] = observableQuery;
  }

  int generateQueryId() {
    final int requestId = idCounter;

    idCounter++;

    return requestId;
  }

  QueryResult _mapFetchResultToQueryResult(FetchResult fetchResult) {
    List<GraphQLError> errors;

    if (fetchResult.errors != null) {
      errors = List<GraphQLError>.from(fetchResult.errors.map<GraphQLError>(
        (Map<String, dynamic> rawError) => GraphQLError.fromJSON(rawError),
      ));
    }

    return QueryResult(
      data: fetchResult.data,
      errors: errors,
      loading: false,
    );
  }
}
