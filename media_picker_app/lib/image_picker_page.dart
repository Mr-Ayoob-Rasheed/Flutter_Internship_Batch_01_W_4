import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerPage extends StatefulWidget{
  const ImagePickerPage({super.key});

  @override
  _ImagePickerPageState createState()=> _ImagePickerPageState();
}
class _ImagePickerPageState extends State<ImagePickerPage>{
  File? _selectedImage;
  File? _selectedDocument;
  String? _documentName;
  int? _documentSize;
  String? pickedDocument;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("MEDIA PICKER APP"),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child:Column(
          children: [
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text("Gallery"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImageFromCamera,
              child: const Text("Camera"),
            ),
            const SizedBox(height: 20),
            _selectedImage != null
              ? Image.file(_selectedImage!)
              : const Text("No image selected."),
            const SizedBox(height: 20),
            if(_selectedImage != null)
              Expanded(
                child:ClipRRect(
                  borderRadius:BorderRadius.circular(12),
                  child:InteractiveViewer(
                    child:Image.file(
                      _selectedImage!,
                      fit:BoxFit.contain
                    ),
                  ),
                )
              ),
            if(_selectedImage!=null)
              Padding(
                padding:EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text("File Path: ${_selectedImage!.path.split('\'').last}"),
                    Text("Size: ${(_selectedImage!.lengthSync()/1024).toStringAsFixed(2)} KB"),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickDocument,
              child: const Text("Document"),
            ),
          ],
        ),
      )
    );
  }


  Future<void> _pickImageFromGallery()async{
    final ImagePicker picker= ImagePicker();
    final XFile? image=await picker.pickImage(source: ImageSource.gallery);
    
    if(image!=null){
      setState((){
        _selectedImage=File(image.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async{
    final ImagePicker picker=ImagePicker();
    final XFile? image=await picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      setState((){
        _selectedImage=File(image.path);
      });
    }
  }

  Future<void> pickDocument() async {
    final result=await FilePicker.platform.pickFiles();

    if(result!=null){
      setState(() {
        pickedDocument:result.files.single.name;
      });
    }
  }



}