import 'package:flutter/material.dart';
import 'package:listview_behaivour/reversed_refresh_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ReversedRefreshWidget(
          onRefresh: () {
            print("onrefresh");
          },
          child: ListView.separated(
            controller: _scrollController,
            itemBuilder: ((context, index) => ListTile(title: Text('$index'))),
            separatorBuilder: ((context, index) => const Divider()),
            itemCount: 20,
            reverse: true,
          ),
        ),
      ),
    );
  }
}
