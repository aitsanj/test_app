import 'package:ap_for_interview/dictionary/colors.dart';
import 'package:flutter/material.dart';

class PhotoPickerModal extends StatelessWidget {
  final Function() openCamera, openGallery;

  const PhotoPickerModal(
      {super.key, required this.openCamera, required this.openGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(13),
                color: background),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  'Выберите фото',
                  style: TextStyle(
                      color: unselectedNavBarItem,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                color: divider,
                thickness: 1,
              ),
              InkWell(
                  onTap: openCamera,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    child: Text(
                      'Камера',
                      style: TextStyle(color: primaryBlue, fontSize: 20),
                    ),
                  )),
              const Divider(
                color: divider,
                thickness: 1,
              ),
              InkWell(
                  onTap: openGallery,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    child: Text(
                      'Галерея Фото',
                      style: TextStyle(color: primaryBlue, fontSize: 20),
                    ),
                  )),
            ]),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 375,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(13),
                    color: background),
                child: const Text(
                  'Закрыть',
                  style: TextStyle(
                      color: primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}
