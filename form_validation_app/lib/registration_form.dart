import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title:const Text('Registration Form'),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        ),
      body:Center(
        child:IntrinsicWidth(
          child:IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration:BoxDecoration(
                    border:Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text('Fillout this Registration Form please',
                        style:TextStyle(
                          fontSize:16,
                          fontWeight:FontWeight.bold,)
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
                          onPressed:handleSubmit,
                          child:const Text('Submit'),
                        )
                      ],
                    ),
                  )
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget buildNameField(){
    return TextFormField(
      controller:nameController,
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