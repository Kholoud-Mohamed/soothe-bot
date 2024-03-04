import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _messages = [];
  late FirebaseFirestore _firestore;
  late CollectionReference<Map<String, dynamic>> _messagesCollection;

  @override
  void initState() {
    super.initState();
    _initFirestore();
    _sendInitialMessages();
  }

  Future<void> _initFirestore() async {
    _firestore = FirebaseFirestore.instance;
    _messagesCollection = _firestore.collection('messages');
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _messagesCollection
            .where('isUserMessage', isEqualTo: true)
            .orderBy('timestamp')
            .get();
    setState(() {
      _messages.clear();
      _messages.addAll(snapshot.docs.map((doc) => doc['message'] as String));
    });
  }

  void _sendInitialMessages() {
    // if (_messages.isEmpty) {
    _sendMessage('Hello!');
    _sendMessage('How can I assist you today?');
    _sendMessage('Feel free to ask any questions.');
    // }
  }

  void _sendMessage(String message) async {
    // Check if the message is an initial bot message
    final isInitialBotMessage = _messages.length < 3;

    await _messagesCollection.add({
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'isUserMessage':
          !isInitialBotMessage, // Set the flag based on whether it's an initial bot message or user message
    });

    _textEditingController.clear();
  }

  Widget _buildMessageList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _messagesCollection.orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs
                .map((doc) => doc['message'] as String)
                .toList();
            return ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isChatbotMessage =
                    index < 3; // First 3 messages are from the chatbot

                return Align(
                  alignment: isChatbotMessage
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isChatbotMessage
                          ? Colors.grey[200]
                          : const Color(0xffC4DEE4),
                      borderRadius: isChatbotMessage
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isChatbotMessage
                            ? Colors.black
                            : const Color.fromARGB(255, 94, 92, 92),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(
          2.0), // Add padding around the input field and send button
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
                width: 8), // Add spacing between text field and send button
            IconButton(
              onPressed: () {
                _sendMessage(_textEditingController.text);
              },
              icon: const Icon(Icons.send_rounded),
              color: const Color.fromARGB(255, 172, 209, 209),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight +
            1.0), // Increase the height by 1.0 to accommodate the horizontal line
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0, // Thickness of the horizontal line
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 237, 241, 243),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Soothe Bot'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildMessageList(),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
              height: 0,
              endIndent: 8,
              indent: 8,
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }
}
// If you want to have initial messages from the chatbot and allow user messages with replies from the chatbot using a model, 
//you can modify the _sendMessage method to include the chatbot's reply.
// Instead of just sending the user's message to the Firestore collection,
// you can send both the user's message and the chatbot's reply. 
//You can use an API or a model to generate the chatbot's reply based on the user's message.

// void _sendMessage(String message) async {
//   // Send user's message to Firestore
//   await _messagesCollection.add({
//     'message': message,
//     'timestamp': FieldValue.serverTimestamp(),
//     'isUserMessage': true,
//   });

//   // Generate chatbot's reply (using an API or a model)
//   String chatbotReply = await generateChatbotReply(message);

//   // Send chatbot's reply to Firestore
//   await _messagesCollection.add({
//     'message': chatbotReply,
//     'timestamp': FieldValue.serverTimestamp(),
//     'isUserMessage': false,
//   });

//   _textEditingController.clear();
// }

// the generateChatbotReply function represents the logic or API call to generate the chatbot's reply based on the user's message.
// You can implement this function using an API or a machine learning model, depending on your specific requirements.
// When rendering the messages in the _buildMessageList method,
// you can differentiate between user messages and chatbot messages by checking the isUserMessage field in the Firestore document.
// You can modify the UI accordingly to show different styles for user messages and chatbot messages.
// This approach allows you to have a conversation between the user and the chatbot, 
//where the chatbot's replies are dynamically generated based on the user's input using an API or a model.
