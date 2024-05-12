import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customSearchWidget extends StatefulWidget {
  customSearchWidget({super.key});

  @override
  State<customSearchWidget> createState() => _customSearchWidgetState();
}

List<dynamic> available = [];
List<dynamic> filtered = [];

class _customSearchWidgetState extends State<customSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50),
            CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(30),
              backgroundColor: Colors.grey.withOpacity(0.4),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.grey,
              ),
              style: TextStyle(color: Colors.white),
              onChanged: filterusers,
              placeholder: 'Search by name',
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  available = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final data = filtered[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['image'][0]),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['age']),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void filterusers(String query) {
    setState(() {
      filtered = available.where(
        (doc) {
          String user = doc.data()['name'].toLowerCase();
          String searchquery = query.toLowerCase();
          return user.contains(searchquery);
        },
      ).toList();
    });
  }
}
