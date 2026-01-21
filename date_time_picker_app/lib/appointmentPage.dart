import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget{
  @override
  _AppointmentPageState createState()=> _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>{
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('Appointment Scheduler')),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            dateSection(),
            SizedBox(height:20),
            timeSection(),
            SizedBox(height:20),
            if (selectedDate != null && selectedTime != null)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Appointment Summary:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Date: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}"),
                      Text("Time: ${selectedTime!.format(context)}"),
                      Text("Days Remaining: ${daysUntilAppointment()} days"),
                    ],
                  ),
                ),
              )
          ],
        )
      ), 
    );
  }

  Future<void> pickDate()async{
    final DateTime now=DateTime.now();
    final DateTime? result=await showDatePicker(
      context:context,
      initialDate: now,
      firstDate:now,
      lastDate:DateTime(now.year+5),
    );

    if (result!=null){
      setState(() {
        selectedDate=result;
      });
    }
  }

  Future<void> pickTime() async{
    final TimeOfDay? result=await showTimePicker(
      context:context,
      initialTime:TimeOfDay.now(),
    );
    if(result!= null){
      setState(() {
        selectedTime=result;
      });
    }
  }

  Widget dateSection(){
  return Card(
    child:ListTile(
      title:Text(selectedDate==null
        ?'No date selected'
        : 'Selected Date: ${DateFormat.yMMMd().format(selectedDate!)}'
      ),
      trailing: const Icon(Icons.calendar_month),
      onTap:pickDate,
    ),
  );
}
  Widget timeSection(){
    return Card(
      child:ListTile(
        title:Text(selectedTime==null
          ?'No time selected'
          : 'Selected Time: ${selectedTime!.format(context)}'
        ),
        trailing: const Icon(Icons.access_time),
        onTap:pickTime,
      ),
    );
  }

  int daysUntilAppointment() {
  if (selectedDate == null) return 0;
  return selectedDate!.difference(DateTime.now()).inDays;
  }
  


}

