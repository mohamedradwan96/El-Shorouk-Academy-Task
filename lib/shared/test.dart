// import 'dart:async';
// import 'dart:io';
// ;
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sila_system/shared/network/apiManger.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Upload Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: UploadScreen(),
//     );
//   }
// }
//
// class UploadScreen extends StatefulWidget {
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }
//
// class _UploadScreenState extends State<UploadScreen> {
//   List<File> _selectedImages = [];
//
//   Future<void> _pickImages() async {
//     List<XFile>? images = await ImagePicker().pickMultiImage();
//     if (images != null) {
//       setState(() {
//         _selectedImages = images.map((image) => File(image.path)).toList();
//       });
//     }
//   }
//
//   Future<void> _uploadImages() async {
//     if (_selectedImages.isNotEmpty) {
//
//       try {
//         for (int i = 0; i < _selectedImages.length; i++) {
//           String filename = _selectedImages[i].path.split('/').last;
//
//           FormData formData = FormData.fromMap({
//             "file": await MultipartFile.fromFile(_selectedImages[i].path, filename: filename),
//           });
//
//           Response response = await ApiManger().dio.post(
//             "http://203.161.55.254:8009/api/v1/order/client/create", // Replace with your API endpoint
//             data: formData,
//           );
//
//           // Handle the response (e.g., check status code, display success message)
//           if (response.statusCode == 201) {
//             print('Image $i uploaded successfully');
//           } else {
//             print('Failed to upload image $i');
//           }
//         }
//       } catch (error) {
//         print('Error uploading images: $error');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImages,
//               child: Text('Pick Images'),
//             ),
//             SizedBox(height: 16.0),
//             Text('Selected Images:', style: TextStyle(fontSize: 18.0)),
//             SizedBox(height: 8.0),
//             Column(
//               children: _selectedImages.map((image) {
//                 return Container(
//                   margin: EdgeInsets.only(bottom: 8.0),
//                   child: Image.file(image, height: 150.0),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _uploadImages,
//               child: Text('Upload Images'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
