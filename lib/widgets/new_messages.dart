import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageControler = TextEditingController();

  @override
  void dispose() {
    _messageControler.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageControler.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
      FocusScope.of(context).unfocus();
        _messageControler.clear(); 
        
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createAt': Timestamp.now(),
      'userId': user!.uid,
      'username': userData.data()!['username'],
      'userimage': userData.data()!['image_url'],
    });

  
  
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(children: [
        Expanded(
            child: TextField(
          controller: _messageControler,
          textCapitalization: TextCapitalization.sentences,
          autocorrect: true,
          enableSuggestions: true,
          decoration: InputDecoration(labelText: 'Send a Message'),
        )),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.send),
          onPressed: _submitMessage,
        )
      ]),
    );
  }
}
