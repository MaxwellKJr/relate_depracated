import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostIssueScreen extends StatefulWidget {
  const PostIssueScreen({super.key});

  @override
  State<PostIssueScreen> createState() => _PostIssueScreenState();
}

class _PostIssueScreenState extends State<PostIssueScreen> {
  final _postTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEmpty = false;

  Future<void> sendPost() async {
    final user = FirebaseAuth.instance;
    final uid = user.currentUser?.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userName = userDoc.data()!['userName'];

    final text = _postTextController.text;
    final currentTime = DateTime.now();

    final post = {
      'text': text,
      'timestamp': Timestamp.fromDate(currentTime),
      'uid': uid, // Add the user's UID and userName to the post document
      'postedBy': userName
    };

    if (text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('posts').add(post);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasText = ValueNotifier(false);
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          child: AppBar(
            title: const Text('Post'),
            leading: IconButton(
              icon: Icon(Icons.adaptive.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendPost();
                  }
                },
                child: const Text("Share Issue"),
              )
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter some text';
                }
                return null;
              },
              controller: _postTextController,
              decoration: const InputDecoration(
                hintText: 'Share your thoughts...',
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
        ),
        // bottomNavigationBar: const NavigationBarMain(),
      ),
    ));
  }
}
