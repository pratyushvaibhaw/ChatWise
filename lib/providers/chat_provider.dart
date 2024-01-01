import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;
  updateMessageController() {
    _messageController.text = '';
    notifyListeners();
  }
}
