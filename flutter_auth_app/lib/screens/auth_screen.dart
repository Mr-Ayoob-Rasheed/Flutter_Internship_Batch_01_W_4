import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'user_info_screen.dart'; 
 
class AuthScreen extends StatefulWidget { 
  @override 
  _AuthScreenState createState() => _AuthScreenState(); 
} 
 
class _AuthScreenState extends State<AuthScreen> { 
  final _auth = FirebaseAuth.instance; 
  final _emailController = TextEditingController(); 
  final _passwordController = TextEditingController(); 
  bool _isLogin = true; 
  bool _isLoading = false; 
 
  Future<void> _submit() async { 
    setState(() => _isLoading = true); 
     
    try { 
      if (_isLogin) { 
        await _auth.signInWithEmailAndPassword( 
          email: _emailController.text.trim(), 
          password: _passwordController.text, 
        ); 
      } else { 
        await _auth.createUserWithEmailAndPassword( 
          email: _emailController.text.trim(), 
          password: _passwordController.text, 
        ); 
      } 
       
      Navigator.pushReplacement( 
        context, 
        MaterialPageRoute(builder: (context) => UserInfoScreen()), 
      ); 
    } catch (e) { 
      ScaffoldMessenger.of(context).showSnackBar( 
        SnackBar(content: Text(e.toString())), 
      ); 
    } 
     
    setState(() => _isLoading = false); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')), 
      body: Center(
        child:IntrinsicHeight(
          child:IntrinsicWidth(
            child:Padding( 
              padding: EdgeInsets.all(16), 
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [ 
                  TextField( 
                    controller: _emailController, 
                    decoration: InputDecoration( 
                      labelText: 'Email', 
                      border: OutlineInputBorder(), 
                    ), 
                  ), 
                  SizedBox(height: 16), 
                  TextField( 
                    controller: _passwordController, 
                    obscureText: true, 
                    decoration: InputDecoration( 
                      labelText: 'Password', 
                      border: OutlineInputBorder(), 
                    ), 
                  ), 
                  SizedBox(height: 24), 
                  _isLoading 
                      ? CircularProgressIndicator() 
                      : ElevatedButton( 
                          onPressed: _submit, 
                          child: Text(_isLogin ? 'Login' : 'Sign Up'), 
                          style: ElevatedButton.styleFrom( 
                            minimumSize: Size(double.infinity, 50), 
                          ), 
                        ), 
                  TextButton( 
                    onPressed: () => setState(() => _isLogin = !_isLogin), 
                    child: Text(_isLogin 
                        ? 'Create new account' 
                        : 'Already have an account'), 
                  ), 
                ], 
              ), 
            ),
          ),
        )
      ),
    );
  } 
}