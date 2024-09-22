import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:accounts/update_data.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => ViewDataState();
}

class ViewDataState extends State<ViewData> {
  List userData = [];
  bool isLoading = false;

// show confirm unblock box
  void _showDeleteBox(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Record'),
          content: const Text('Are you sure! want to delete this record?'),
          actions: [
            // cancel button
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),

            // unblock button
            TextButton(
                onPressed: () {
                  deleteRecords(userId);

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text('record deleted!'),
                  //   ),
                  // );
                },
                child: const Text('Delete')),
          ],
        ));
  }
  
  Future<void> deleteRecords(String uid) async {
    String url = 'http://192.168.1.17/accounts_api/delete_record.php';

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      var request = await http.post(Uri.parse(url), body: {'uid': uid});

      var response = jsonDecode(request.body);

      if (response["success"] == "true") {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('record deleted!'),
          ),
        );

        print('record deleted!');
        Navigator.pop(context);
        getRecords();
      } else {
        print('some error while deleting record!');
      }

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

  Future<void> getRecords() async {
    String url = 'http://192.168.1.17/accounts_api/view_data.php';

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
        elevation: 0,
        actions: [

          // refresh button
          IconButton(tooltip: 'Refresh Data!', onPressed: getRecords, icon: const Icon(Icons.electric_bolt, color: Colors.green,))
        ],
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateData(
                            uid: userData[index]['uid']!,
                            name: userData[index]['uName']!,
                            email: userData[index]['uEmail']!,
                            pwd: userData[index]['uPwd']!,
                          ),
                        ),
                      );
                    },
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
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(
                        //     Icons.settings,
                        //     color: Colors.blue,
                        //   ),
                        // ),
                        IconButton(
                          onPressed: () {
                            // deleteRecords(userData[index]['uid']!);
                            _showDeleteBox(context, userData[index]['uid']!);
                          },
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
