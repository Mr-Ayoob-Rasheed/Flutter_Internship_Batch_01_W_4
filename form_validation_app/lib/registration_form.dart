import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'theme_controller.dart';

class RegistrationForm extends StatefulWidget{
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState()=> _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm>{
  final _formKey=GlobalKey<FormState>();

  @override
  final nameController=TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
  title: Text('Registration Form')
      .animate()
      .fadeIn(duration: 800.ms)
      .slideY(begin: -0.2),
  actions: [
    IconButton(
      icon: Icon(
        themeNotifier.value == ThemeMode.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
      onPressed: () {
        themeNotifier.value =
            themeNotifier.value == ThemeMode.dark
                ? ThemeMode.light
                : ThemeMode.dark;
      },
    ),
  ],
),
        body:SingleChildScrollView(
          child:Padding(
            padding:const EdgeInsets.all(16.0),
            child:
            Center(
          child:IntrinsicHeight(
            child:IntrinsicWidth(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                  children:[
                    SizedBox(height: 30,),
                    Card(
                      elevation: 10,
                      shadowColor: Colors.yellow.withOpacity(0.4),
                      color: Theme.of(context).cardColor,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color:themeNotifier.value==ThemeMode.light
                              ?Colors.black
                              :Colors.yellow,
                          width:2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 50,),
                            Text('Fillout this Registration Form please',
                            style:TextStyle(
                            fontSize:16,
                            fontWeight:FontWeight.bold,
                             color:themeNotifier.value==ThemeMode.light
                             ?Colors.black
                             :Colors.yellow
                            ),
                            ),
                            const SizedBox(height: 12),
                            buildNameField(),
                            const SizedBox(height: 12),
                            buildEmailField(),
                            const SizedBox(height: 12),
                            buildPhoneField(),
                            const SizedBox(height: 12),
                            buildPasswordField(),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: handleSubmit,
                              style: ElevatedButton.styleFrom(
                                splashFactory: InkRipple.splashFactory,
                                backgroundColor: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 20,
                                
                              ),
                              child:const Text('SUBMIT',
                              style:TextStyle(
                                color: Colors.black,
                              ) ,
                              ),
                              )
                          ],
                          ),
                        )
                      ),
                    ),
                  ],
                  )
              ),
            ),
          ),
        ),
      )
      ),
    );
  }

  Widget buildNameField(){
    return TextFormField(
      controller:nameController,
      style:TextStyle(color:Colors.white),
      decoration:InputDecoration(
        labelText: "Name",
        prefixIcon:Icon(Icons.person),
        border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(8.0),
          gapPadding:4.0,
        )
      ),
      validator:(value){
        if(value==null ||value.isEmpty){
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget buildEmailField() {
  return TextFormField(
    controller: emailController,
    style:TextStyle(color:Colors.white),
    decoration: InputDecoration(
      labelText: "Email",
      prefixIcon: Icon(Icons.email),
      border: OutlineInputBorder(
        borderRadius:BorderRadius.circular(8.0),
        gapPadding: 4.0,
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Email is required";
      }
      if (!value.contains("@") || !value.contains(".")) {
        return "Enter a valid email";
      }
      return null;
    },
  );
}


  Widget buildPhoneField(){
    return TextFormField(
      controller:phoneController,
      style:TextStyle(color:Colors.white),
      keyboardType:TextInputType.phone,
      decoration:InputDecoration(
        labelText:"Whatsapp Phone Number",
        prefixIcon:Icon(Icons.phone),
        border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(8.0),
          gapPadding:4.0,
        ),
      ),
      validator:(value){
        if(value==null ||value.isEmpty){
          return "Phone number required";
        }
        if(value.length<13){
          return "Phone number not valid";
        }
        return null;
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      style:TextStyle(color:Colors.white),
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password required";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }




  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form Submitted Successfully!")),
      );

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
    }
  }






}