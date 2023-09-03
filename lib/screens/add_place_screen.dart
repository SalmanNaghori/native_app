import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:native_app/providers/great_places.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;

  String imagePath = "";

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
    imagePath = _pickedImage!.path;
    log(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add A New Place'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Theme.of(context).primaryColor),
                        ),
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              validation();
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  validation() {
    if (_titleController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please select a title", timeInSecForIosWeb: 1, fontSize: 16.0);
    } else if (imagePath.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please select an image", timeInSecForIosWeb: 1, fontSize: 16.0);
    } else {
      Provider.of<GreatPlace>(context, listen: false)
          .addItem(_titleController.text, _pickedImage!);
      Fluttertoast.showToast(
          msg: "Place added successfully",
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      Navigator.of(context).pop();
    }
  }
}
