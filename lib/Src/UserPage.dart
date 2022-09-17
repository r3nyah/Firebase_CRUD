import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/Src/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerHobby = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            decoration: decoration('Name'),
            controller: controllerName,
          ),
          const SizedBox(height: 24,),
          TextField(
            decoration: decoration('Age'),
            controller: controllerAge,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24,),
          TextField(
            decoration: decoration('Hobby'),
            controller: controllerHobby,
          ),
          SizedBox(height: 30,),
          ElevatedButton(
            child: Text('Create'),
            onPressed: (){
              final user = User(
                name: controllerName.text,
                hobby: controllerHobby.text,
                age: int.parse(controllerAge.text)
              );

              createUser(user);

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
  InputDecoration decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );

  Future createUser(User user)async{
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
