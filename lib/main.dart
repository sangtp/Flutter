import 'package:baitapbuoi3_adaptive/people.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return WideLayout();
        } else {
          return NarrowLayout();
        }
      }),
    );
  }
}

class PeopleList extends StatelessWidget {
  void Function(Person) onPersonTap;

  PeopleList({@required this.onPersonTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var person in people)
          ListTile(
            leading: Image.network(person.picture),
            title: Text(person.name),
            onTap: () => onPersonTap(person),
          ),
      ],
    );
  }
}

class WideLayout extends StatefulWidget {
  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person _person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PeopleList(
              onPersonTap: (person) => setState(() => _person = person)),
          flex: 2,
        ),
        Expanded(
          child: _person == null ? Placeholder() : PersonDetail(_person),
          flex: 3,
        ),
      ],
    );
  }
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PeopleList(
        onPersonTap: (person) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(),
                  body: PersonDetail(person),
                ),
              ),
            ));
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;

  const PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(person.name),
          Text(person.phone),
        ],
      ),
    );
  }
}
