import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_app/models/place.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return this._items;
  }

  void addItem(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
