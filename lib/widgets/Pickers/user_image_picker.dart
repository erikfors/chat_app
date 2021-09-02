import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _pickedImage = photo;
    });

    widget.imagePickFn(File(_pickedImage!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null
              ? FileImage(
                  File(_pickedImage!.path),
                )
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(
            "Add Image",
          ),
        ),
      ],
    );
  }
}
