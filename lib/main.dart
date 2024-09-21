import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:account/view_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY SQL API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MY SQL API XAMPP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPwd = TextEditingController();


  Future<void> insertRecord() async {
    if(txtName.text != '' || txtEmail.text != '' || txtPwd.text != '') {

      // cmd ipconfig check your local ip address: 192.168.1.19
      String url = 'http://192.168.1.19/accounts_api/insert_record.php';

      try {
        var resource = await http.post(Uri.parse(url), body: {
          'name': txtName.text,
          'email': txtEmail.text,
          'pwd': txtPwd.text,
        });

        print(resource.body);

        var response = jsonDecode(resource.body);
        if (response['success'] == 'true'){
          print('record inserted');
          txtName.text = '';
          txtEmail.text = '';
          txtPwd.text = '';
        } else {
          print('some error while inserting record');
        }

      }
      catch (e) {
        print(e);
      }
    } else {
      print('please fill your data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter Your Name'),
              ),
            ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter Your Email'),
              ),
            ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtPwd,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter Your Password'),
              ),
            ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                insertRecord();
              }, child: const Text('INSERT RECORD'),),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewData()));

              }, child: const Text('VIEW RECORD'),),
            ),
          ],
        ),
      ),
    );
  }
}
