import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _name = '';
  String _lastName = '';
  String _selectedOption = '';

  CarouselController buttonCarouselController = CarouselController();

  CarouselController get buttonController => buttonCarouselController;

  String get firstName => _name;

  set firstName(String value) {
    _name = value;
    notifyListeners();
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  String get selectedOption => _selectedOption;

  set selectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }
}
