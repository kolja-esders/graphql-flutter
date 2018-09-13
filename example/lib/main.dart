import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import './mutations/addStar.dart' as mutations;
import './queries/readRepositories.dart' as queries;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpLink link = HttpLink(
      uri: 'http://kolja.es:4000'
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: InMemoryCache(),
        link: link,
      ),
    );

    String email = 'kolja@gmail.com';
    String password = 'xxy';
    final test = {'email': email, 'password': password};
    client.value.mutate(MutationOptions(
        document: queries.logIn,
        variables: test
      // you can optionally override some http options through the contexts
    )).then((res) {
      if (res.loading) {
        return null;
      }
      dynamic y = res.errors;
      dynamic x = res.data;

    });

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'GraphQL Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'GraphQL Flutter Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String email = 'kolja@gmail.com';
    String password = 'xxy';
    final test = {'email': email, 'password': password};

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Mutation(
        options: MutationOptions(
          document: queries.logIn,
          variables: test
          // you can optionally override some http options through the contexts
        ),
        builder: (RunMutation run, QueryResult result) {
          final dynamic lol = result.errors;

          if (result.loading) {
            return const Text('Loading');
          }

          dynamic ok = result.data;

          return Container();
        },
      ),
    );
  }
}
