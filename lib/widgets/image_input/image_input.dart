import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function selectImage;
  ImageInput(this.selectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storeImage;
  Logger log = Logger();

  Future<void> _takePicFromCamera() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 600,
    );
    setState(() {
      _storeImage = File(imageFile!.path);
    });
    final appDrive = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    log.e(fileName);
    final savedImage = await _storeImage!.copy('${appDrive.path}/$fileName');
    widget.selectImage(savedImage);
  }

  Future<void> _takePicFromGallery() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600, maxHeight: 600);

    setState(() {
      _storeImage = File(imageFile!.path);
    });
    final appDrive = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    log.e(fileName);
    final savedImage = await _storeImage!.copy('${appDrive.path}/$fileName');
    widget.selectImage(savedImage);
  }

  void _takePic() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _takePicFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  _takePicFromGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storeImage != null
              ? Image.file(
                  _storeImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _takePic();
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text(
              'Take Picture',
            ),
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary),
          ),
        )
      ],
    );
  }
}
