import 'dart:io';

import 'package:ap_for_interview/components/photo_picker_modal.dart';
import 'package:ap_for_interview/components/profile_option.dart';
import 'package:ap_for_interview/dictionary/colors.dart';
import 'package:ap_for_interview/notifier/profile_info.notifier.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  XFile? avatar;
  int currentPage = 0;

  openPicker() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        elevation: 5,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return SizedBox(
            height: 300,
            child: PhotoPickerModal(
              openCamera: openCamera,
              openGallery: openGallery,
            ),
          );
        });
  }

  Future<void> openGallery() async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          avatar = pickedImage;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> openCamera() async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          avatar = pickedImage;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  showWidget() {
    if (avatar != null) {
      return FileImage(File(avatar!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    return Container(
      color: background,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 24, right: 8, left: 8),
      child: CarouselSlider(
        carouselController: profileProvider.buttonCarouselController,
        options: CarouselOptions(
          scrollPhysics: const NeverScrollableScrollPhysics(),
          initialPage: currentPage,
          height: MediaQuery.of(context).size.height,
          enableInfiniteScroll: true,
          onPageChanged: (index, reason) {
            setState(() {
              currentPage = index;
            });
          },
          autoPlay: false,
          aspectRatio: 2.0,
          viewportFraction: 1,
        ),
        items: [
          Column(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      openPicker();
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundColor: avatarBackground,
                          minRadius: 40,
                          maxRadius: 40,
                          backgroundImage: showWidget(),
                          child: avatar != null
                              ? null
                              : const Icon(
                                  Icons.person_rounded,
                                  color: primaryBlue,
                                  size: 70,
                                ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: white),
                          child: const Icon(
                            Icons.more_horiz,
                            color: primaryBlue,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'apollo@gmail.com',
                    style: TextStyle(
                        color: unselectedNavBarItem,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  profileProvider.selectedOption = 'firstName';
                  profileProvider.buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13)),
                    color: lightBackground,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: divider, width: 1))),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Имя',
                                style:
                                    TextStyle(color: primaryGrey, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(
                                    profileProvider.firstName != ''
                                        ? profileProvider.firstName
                                        : 'Настроить',
                                    style: TextStyle(
                                        color: profileProvider.firstName != ''
                                            ? unselectedNavBarItem
                                            : divider,
                                        fontSize: 16),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                    color: divider,
                                  )
                                ],
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  profileProvider.selectedOption = 'lastName';
                  profileProvider.buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Container(
                  decoration: const BoxDecoration(color: lightBackground),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: divider, width: 1))),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Фамилия',
                                style:
                                    TextStyle(color: primaryGrey, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(
                                    profileProvider.lastName != ''
                                        ? profileProvider.lastName
                                        : 'Настроить',
                                    style: TextStyle(
                                        color: profileProvider.lastName != ''
                                            ? unselectedNavBarItem
                                            : divider,
                                        fontSize: 16),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                    color: divider,
                                  )
                                ],
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const ProfileOption(),
        ],
      ),
    );
  }
}
