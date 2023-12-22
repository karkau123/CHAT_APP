import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageControler = TextEditingController();

  @override
  void dispose() {
    _messageControler.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageControler.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    // send the message to the firebase

    _messageControler.clear();
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
