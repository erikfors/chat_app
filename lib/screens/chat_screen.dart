import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedro"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/QifsMfWtANI18QGDgnyj/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          final documents = streamSnapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents?[index]["text"]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('chats/QifsMfWtANI18QGDgnyj/messages').add({"text":"This was added by clicking the button"});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
