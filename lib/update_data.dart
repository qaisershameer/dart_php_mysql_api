import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  String uid;
  String name;
  String email;
  String pwd;

  UpdateData(
      {super.key, required this.uid, required this.name, required this.email, required this.pwd});

  @override
  State<UpdateData> createState() => UpdateDataState();
}

class UpdateDataState extends State<UpdateData> {
  String txtUid ='';
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPwd = TextEditingController();

  Future<void> updateRecord() async {
    if (txtName.text != '' || txtEmail.text != '' || txtPwd.text != '') {
      try {
        String url = 'http://192.168.1.17/accounts_api/update_record.php';

        var request = await http.post(Uri.parse(url), body: {
          'uid': txtUid,
          'name': txtName.text,
          'email': txtEmail.text,
          'pwd': txtPwd.text,
        });

        var response = jsonDecode(request.body);

        if (response["success"] == "true") {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('record updated!'),
            ),
          );

          print('record Updated');
          txtName.text = '';
          txtEmail.text = '';
          txtPwd.text = '';
        } else {
          print('some error');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Please Fill all Data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    txtUid = widget.uid;
    txtName.text = widget.name;
    txtEmail.text = widget.email;
    txtPwd.text = widget.pwd;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Update Record'),
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
              child: ElevatedButton(
                  onPressed: () {
                    updateRecord();
                    Navigator.pop(context);
                  },
                  child: const Text('Update Record in PHP MY SQL XAMPP')),
            ),
          ],
        ),
      ),
    );
  }
}
