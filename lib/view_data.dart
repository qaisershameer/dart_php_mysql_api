import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => ViewDataState();
}

class ViewDataState extends State<ViewData> {
  List userData = [];
  bool isLoading = false;

  getRecords() async {
    String url = 'http://192.168.1.18/accounts_api/view_data.php';

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        userData = jsonDecode(response.body);
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
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green), // You can customize the color
              ),
            )
          : // Your normal widget tree here when not loading
          ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(1),
                  child: ListTile(
                    leading: const Icon(
                      Icons.heart_broken,
                      color: Colors.red,
                    ),
                    title: Text(
                      userData[index]['uName']!,
                      style: const TextStyle(color: Colors.green),
                    ),
                    subtitle: Text(
                      userData[index]['uEmail']!,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
