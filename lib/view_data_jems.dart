import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewDataJEMS extends StatefulWidget {
  const ViewDataJEMS({super.key});

  @override
  State<ViewDataJEMS> createState() => ViewDataJEMSState();
}

class ViewDataJEMSState extends State<ViewDataJEMS> {
  List userData = [];
  bool isLoading = false;

  getRecords() async {
    String url = 'https://college.jadeedmunshi.com/api/ledger/110201';

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        var data = jsonDecode(response.body);
        userData = data['ledger'];
        isLoading = false; // Stop loading
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false; // Stop loading on error
      });
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
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // You can customize the color
        ),
      )
          : // Your normal widget tree here when not loading
      ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(1),
            child: ListTile(
              leading: const Icon(Icons.heart_broken, color: Colors.red,),
              title: Text(userData[index]['bal_transaction_type'] ?? 'No Type', style: const TextStyle(color: Colors.blue),),
              subtitle: Text(userData[index]['bal_remarks'] ?? 'No Remarks', style: const TextStyle(color: Colors.green),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.blue,),
                  ),
                  // IconButton(
                  //   onPressed: (){},
                  //   icon: const Icon(Icons.delete, color: Colors.red,),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
