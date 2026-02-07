import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'auth_screen.dart'; 
 
class HomeScreen extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    final user = FirebaseAuth.instance.currentUser; 
 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Home'), 
        actions: [ 
          IconButton( 
            icon: Icon(Icons.logout), 
            onPressed: () async { 
              await FirebaseAuth.instance.signOut(); 
              Navigator.pushReplacement( 
                context, 
                MaterialPageRoute(builder: (context) => AuthScreen()), 
              ); 
            }, 
          ), 
        ], 
      ), 
      body: StreamBuilder<DocumentSnapshot>( 
        stream: FirebaseFirestore.instance 
            .collection('users') 
            .doc(user!.uid) 
            .snapshots(), 
        builder: (context, snapshot) { 
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return Center(child: CircularProgressIndicator()); 
          } 
 
          if (!snapshot.hasData) { 
            return Center(child: Text('No data found')); 
          } 
 
          final userData = snapshot.data!.data() as Map<String, dynamic>; 
 
          return Padding( 
            padding: EdgeInsets.all(16), 
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [ 
                Text( 
                  'Welcome, ${userData['name']}!', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
                ), 
                SizedBox(height: 20), 
                Card( 
                  child: ListTile( 
                    leading: Icon(Icons.person), 
                    title: Text('Name'), 
                    subtitle: Text(userData['name']), 
                  ), 
                ), 
                Card( 
                  child: ListTile( 
                    leading: Icon(Icons.cake), 
                    title: Text('Age'), 
                    subtitle: Text('${userData['age']} years'), 
                  ), 
                ), 
                Card( 
                  child: ListTile( 
                    leading: Icon(Icons.school), 
                    title: Text('Grade'), 
                    subtitle: Text(userData['grade']), 
                  ), 
                ), 
                Card( 
                  child: ListTile( 
                    leading: Icon(Icons.email), 
                    title: Text('Email'), 
                    subtitle: Text(userData['email']), 
                  ), 
                ), 
              ], 
            ), 
          ); 
        }, 
      ), 
    ); 
  } 
} 