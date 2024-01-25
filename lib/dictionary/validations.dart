bool isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneRegex = RegExp(r'^\+7 \(\d{3}\) \d{3} \d{2} \d{2}$');

  return phoneRegex.hasMatch(phoneNumber);
}
