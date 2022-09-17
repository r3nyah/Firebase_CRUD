import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/Src/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({Key? key}) : super(key: key);

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final controllerNameAD = TextEditingController();
  final controllerNameOP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            decoration: decoration('Edit Admin Name'),
            controller: controllerNameAD,
          ),
          const SizedBox(height: 24,),
          SizedBox(height: 30,),
          ElevatedButton(
            child: Text(
              'Click here to edit admin',
            ),
            onPressed: (){
              editAdmin();
            },
          ),
          SizedBox(height: 30,),
          TextField(
            decoration: decoration('Edit Admin Name'),
            controller: controllerNameOP,
          ),
          const SizedBox(height: 24,),
          SizedBox(height: 30,),
          ElevatedButton(
            child: Text(
              'Click here to edit operator',
            ),
            onPressed: (){
              editOperator();
            },
          ),
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

  Future editAdmin()async{
    final docUser = FirebaseFirestore.instance.collection('users').doc('admin');
    docUser.update({
      'name' : controllerNameAD,
    });
  }

  Future editOperator()async{
    final docUser = FirebaseFirestore.instance.collection('users').doc('operator');
    docUser.update({
      'name' : controllerNameOP,
    });
  }
}
