import 'package:flutter/material.dart';

import 'api_service.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _email = TextEditingController(),
      _password = TextEditingController();
  final _key = GlobalKey<FormState>();
  var gotData = false;
  late Future<User?> _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: !gotData
            ? Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.all(25),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _email,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !(value.contains('@')) ||
                                    !(value.contains('.com')))
                                  return 'Email is required';
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            TextFormField(
                              controller: _password,
                              validator: (value) {
                                return value == null || value.isEmpty
                                    ? 'Password is required'
                                    : null;
                              },
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: OutlinedButton(
                                    onPressed: () {
                                      if (_key.currentState!.validate()) {
                                        _user = ApiService().login(
                                            _email.text.toString(),
                                            _password.text.toString());
                                        setState(() {
                                          gotData = true;
                                        });
                                      }
                                    },
                                    child: Text('SUBMIT'))),
                          ],
                        ),
                      )),
                ],
              )
            : FutureBuilder<User?>(
                future: _user,
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  // print("Snapshot data: ${snapshot.data.toString()}");
                  if (snapshot.data != null)
                    print(
                        '${snapshot.data!.img.toString().replaceAll(RegExp(r'\\'), '')}');
                  return snapshot.data != null
                      ? Column(
                          children: [
                            Row(
                              children: [
                                new Image.network(
                                    '${snapshot.data!.img.toString()}'),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child:
                                      Text('${snapshot.data!.name.toString()}'),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text('${snapshot.data!.id.toString()}'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Phone No'),
                                enabled: false,
                                initialValue:
                                    '${snapshot.data!.phoneNo.toString()}',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Date of Birth'),
                                enabled: false,
                                initialValue:
                                    '${snapshot.data!.dateOfBirth.toString()}',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Email'),
                                enabled: false,
                                initialValue:
                                    '${snapshot.data!.email.toString()}',
                              ),
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ));
  }

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
    _email.dispose();
  }
}
