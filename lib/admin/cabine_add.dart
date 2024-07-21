import 'package:flutter/material.dart';
import 'cab_req.dart';

class ReqItemCabListScreen extends StatelessWidget {
  late final Future<void> fetchCabRequests;

  ReqItemCabListScreen() {
    // Initialize fetchCabRequests in the constructor
    fetchCabRequests = fetchDataFromFirestoreReq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cabin Requests')),
      body: FutureBuilder<void>(
        future: fetchCabRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (cabinsreq.isEmpty) {
              return const Center(child: Text('No cabin requests available.'));
            } else {
              return ListView.builder(
                itemCount: cabinsreq.length,
                itemBuilder: (context, index) {
                  final request = cabinsreq[index];
                  return ListTile(
                    title: Text(
                      request.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.prix,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          request.number,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    leading: Image.network(
                      request.imgUrl.first,
                      width: MediaQuery.of(context).size.width *
                          0.3, // 30% of screen width
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle the "Refuser" button press
                            // You can perform actions here
                          },
                          icon: const Icon(Icons.close),
                          color: Colors.red, // Set custom color for Refuser
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            // Handle the "Accepter" button press
                            // You can perform actions here
                          },
                          icon: const Icon(Icons.check),
                          color: Colors.green, // Set custom color for Accepter
                        ),
                      ],
                    ),
                    tileColor:
                        Colors.grey[200], // Set background color for the tile
                    contentPadding:
                        const EdgeInsets.all(16), // Add padding around content
                    // Add more UI elements as needed
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
