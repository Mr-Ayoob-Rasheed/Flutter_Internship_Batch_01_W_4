import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SurveyForm(),
    );
  }
} 

class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm>{
  bool likesSports=false;
  bool likesMusic=false;
  bool likesGaming=false;

  String? gender="";

  bool isNotificationEnabled=false;

  List<String> Countries=["Kingdom of Saudi Arabia","Bahrain","United Arab Emirates","Qatar","Kuwait"];

  double age=18;

  bool showSummary=false;

  String? selectedCountry;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Survey Form')),
      body:Center(
        child:IntrinsicWidth(
          child:IntrinsicHeight(
            child:Container(
              padding:EdgeInsets.all( 16.0),
              decoration:BoxDecoration(
                border:Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child:SingleChildScrollView(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckboxSection(),
                    buildGenderSection(),
                    buildSwitchSection(),
                    buildDropdownSection(),
                    buildSliderSection(),
                    SizedBox(height:20),
                    ElevatedButton(
                      onPressed:(){
                        setState(() {
                          showSummary=true;
                        });
                      },
                      child: Icon(Icons.summarize),
                      ),
                      SizedBox(height:20),
                      if(showSummary) buildSummarySection(),
                  ],
                )   
              )
            )
          )
        )
      ,)
    );
  }
  Widget buildCheckboxSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Interests:",style: TextStyle(fontWeight: FontWeight.bold),),
        CheckboxListTile(
          title: const Text("Sports"),
          value: likesSports,
          onChanged: (val)=>setState(() =>likesSports=val!),
        ),
        CheckboxListTile(
          title: const Text("Music"),
          value: likesMusic,
          onChanged: (val)=>setState(() =>likesMusic=val!),
        ),
        CheckboxListTile(
          title: const Text("Gaming"),
          value: likesGaming,
          onChanged: (val)=>setState(() =>likesGaming=val!),
        ),
      ],
    );
  }

  Widget buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        RadioListTile<String>(
          title: const Text("Male"),
          value: "Male",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text("Female"),
          value: "Female",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text("Other"),
          value: "Other",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildSwitchSection(){
    return SwitchListTile(
      title:const Text("Enable Notifications"),
      value:isNotificationEnabled,
      onChanged: (val){
        setState(() =>isNotificationEnabled=val);
      },
    );
  }

  Widget buildDropdownSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        const Text("Country",style: TextStyle(fontWeight: FontWeight.bold),),
        DropdownButton<String>(
          hint: const Text("Choose Country"),
          value: selectedCountry,
          items: Countries.map((country){
            return DropdownMenuItem<String>(
              value:country,
              child:Text(country),
            );
          }).toList(),
          onChanged:(val){},
        ),
      ],
    );
  }

  Widget buildSliderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Age: ${age.round()}"),
        Slider(
          min: 10,
          max: 60,
          value: age,
          onChanged: (val) => setState(() => age = val),
        )
      ],
    );
  }

  Widget buildSummarySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Summary:", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Interests: "
          "${likesSports ? "Sports " : ""}"
          "${likesMusic ? "Music " : ""}"
          "${likesGaming ? "Gaming " : ""}"),
      Text("Gender: $gender"),
      Text("Notifications: ${isNotificationEnabled ? "Enabled" : "Disabled"}"),
      Text("Country: $selectedCountry"),
      Text("Age: ${age.round()}"),
    ],
  );
}

}