import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';

class FaceCheckPage extends StatefulWidget {
  const FaceCheckPage({super.key});

  @override
  State<FaceCheckPage> createState() => _FaceCheckPageState();
}

class _FaceCheckPageState extends State<FaceCheckPage> {
  final ImagePicker picker = ImagePicker();
  String result = '';
  File? imageFile;

  Future<void> pickAndSendImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      final bytes = await imageFile!.readAsBytes();
      final base64Image = base64Encode(bytes);

      try {
        final response = await classifyFace(base64Image);
        setState(() {
          result = 'Prediction: ${response['prediction']} \nAlert: ${response['alert']}';
        });
      } catch (e) {
        setState(() {
          result = 'Error sending image: $e';
        });
      }
    } else {
      setState(() {
        result = 'No image selected.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Check')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickAndSendImage,
              child: const Text('📸 Take Picture'),
            ),
            const SizedBox(height: 20),
            if (imageFile != null)
              Image.file(imageFile!, height: 200),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

