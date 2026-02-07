import 'package:flutter/material.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'home_screen.dart'; 
 
class UserInfoScreen extends StatefulWidget { 
  @override 
  _UserInfoScreenState createState() => _UserInfoScreenState(); 
} 
 
class _UserInfoScreenState extends State<UserInfoScreen> { 
  final _formKey = GlobalKey<FormState>(); 
  final _nameController = TextEditingController(); 
  final _ageController = TextEditingController(); 
  String _selectedGrade = 'Grade 1'; 
  bool _isLoading = false; 
 
  final List<String> _grades = [ 
    'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 
    'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10' 
  ]; 
 
  Future<void> _saveUserInfo() async { 
    if (!_formKey.currentState!.validate()) return; 
 
    setState(() => _isLoading = true); 
 
    try { 
      final user = FirebaseAuth.instance.currentUser; 
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({ 
        'name': _nameController.text.trim(), 
        'age': int.parse(_ageController.text), 
        'grade': _selectedGrade, 
        'email': user.email, 
        'createdAt': FieldValue.serverTimestamp(), 
      }); 
 
      Navigator.pushReplacement( 
        context, 
        MaterialPageRoute(builder: (context) => HomeScreen()), 
      ); 
    } catch (e) { 
      ScaffoldMessenger.of(context).showSnackBar( 
        SnackBar(content: Text('Error saving data: $e')), 
      ); 
    } 
 
    setState(() => _isLoading = false); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Complete Your Profile')), 
      body: Padding( 
        padding: EdgeInsets.all(16), 
        child: Form( 
          key: _formKey, 
          child: Column( 
            children: [ 
              TextFormField( 
                controller: _nameController, 
                decoration: InputDecoration( 
                  labelText: 'Full Name', 
                  border: OutlineInputBorder(), 
                ), 
                validator: (value) => 
                    value!.isEmpty ? 'Please enter your name' : null, 
              ), 
              SizedBox(height: 16), 
              TextFormField( 
                controller: _ageController, 
                keyboardType: TextInputType.number, 
                decoration: InputDecoration( 
                  labelText: 'Age', 
                  border: OutlineInputBorder(), 
                ), 
                validator: (value) => 
                    value!.isEmpty ? 'Please enter your age' : null, 
              ), 
              SizedBox(height: 16), 
              DropdownButtonFormField<String>( 
                value: _selectedGrade, 
                decoration: InputDecoration( 
                  labelText: 'Grade', 
                  border: OutlineInputBorder(), 
                ), 
                items: _grades.map((grade) { 
                  return DropdownMenuItem(value: grade, child: Text(grade)); 
                }).toList(), 
                onChanged: (value) => setState(() => _selectedGrade = value!), 
              ), 
              SizedBox(height: 24), 
              _isLoading 
                  ? CircularProgressIndicator() 
                  : ElevatedButton( 
                      onPressed: _saveUserInfo, 
                      child: Text('Save Information'), 
                      style: ElevatedButton.styleFrom( 
                        minimumSize: Size(double.infinity, 50), 
                      ), 
                    ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
}