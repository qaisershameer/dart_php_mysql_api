import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  const ViewData({super.key});
  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];
  // String url = 'http://192.168.1.19/accounts_api/view_data.php';
  String url = 'https://college.jadeedmunshi.com/api/ledger/110201';

  Future<void> getRecords() async {
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        var data = jsonDecode(response.body);
        userData = data['ledger'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('View Data'),
      ),
      body: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.heart_broken),
                // title: Text(userData[index]['uName'] ?? 'No Name'),
                // subtitle: Text(userData[index]['uEmail'] ?? 'No Email'),

                title: Text(userData[index]['bal_transaction_type'] ?? 'No Name'),
                subtitle: Text(userData[index]['bal_remarks'] ?? 'No Email'),

              ),
            );
          }),
    );
  }
}
