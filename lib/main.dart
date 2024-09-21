import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:accounts/view_data.dart';
import 'package:accounts/view_data_jems.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MY SQL CRUD'),
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

  @override
  Widget build(BuildContext context) {

    TextEditingController txtName = TextEditingController();
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPwd = TextEditingController();

    Future<void> insertRecord() async {
      if(txtName.text != '' || txtEmail.text != '' || txtPwd.text != ''){
        try{

          String url = 'http://192.168.1.18/accounts_api/insert_record.php';

          var request = await http.post(Uri.parse(url), body: {

            'name': txtName.text,
            'email': txtEmail.text,
            'pwd': txtPwd.text,

          });

          var response = jsonDecode(request.body);

          if (response["success"] == "true"){

            print('record inserted');
            txtName.text ='';
            txtEmail.text ='';
            txtPwd.text ='';

          } else
          {
            print('some error');
          }

        }

        catch (e)
        {
          print (e);
        }

      } else
      {
        print('Please Fill all Data');
      }
    }

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
                  border: OutlineInputBorder(), label: Text('Enter Your Name'),

                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter Your Email'),

                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtPwd,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter Your Password'),

                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                insertRecord();
              }, child: const Text('Insert Record in PHP MY SQL XAMPP')),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewData()));
              }, child: const Text('View Data FROM PHP MY SQL XAMPP Local')),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewDataJEMS()));
              }, child: const Text('View Data FROM PHP MY SQL JEMS API Live')),
            ),
          ],
        ),
      ),
    );
  }
}
