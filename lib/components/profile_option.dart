import 'package:ap_for_interview/dictionary/colors.dart';
import 'package:ap_for_interview/notifier/profile_info.notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOption extends StatefulWidget {
  const ProfileOption({super.key});

  @override
  State<ProfileOption> createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: TextFormField(
        controller: profileProvider.selectedOption == 'firstName'
            ? _nameController
            : _lastNameController,
        onChanged: (value) {
          if (profileProvider.selectedOption == 'firstName') {
            profileProvider.firstName = value;
          } else {
            profileProvider.lastName = value;
          }
        },
        decoration: InputDecoration(
          hintText: profileProvider.selectedOption == 'firstName'
              ? 'Ваше Имя'
              : 'Ваша Фамилия',
          hintStyle: const TextStyle(color: divider, fontSize: 16),
          fillColor: lightBackground,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: danger),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: danger),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: yellow),
          ),
          filled: true,
        ),
      ),
    );
  }
}
