import 'dart:async';

import 'package:ap_for_interview/dictionary/colors.dart';
import 'package:ap_for_interview/dictionary/validations.dart';
import 'package:ap_for_interview/screens/main_client_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int currentStep = 1, currentPage = 0;
  List<int> completeSteps = [];
  List<int> steps = [1, 2, 3];
  final _phone = TextEditingController();
  OtpFieldController _otp = OtpFieldController();
  CarouselController buttonCarouselController = CarouselController();
  final _phoneFormKey = GlobalKey<FormState>();
  bool disabled = true;
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  var phoneMask = MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      initialText: "+7 ");

  @override
  void dispose() {
    _timer.cancel();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {},
          child: Image.asset('lib/assets/icons/chevron.png'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...steps.map((e) {
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: currentStep == e
                                ? yellow
                                : completeSteps.contains(e)
                                    ? white
                                    : lightgrey,
                            shape: BoxShape.circle,
                            border: completeSteps.contains(e)
                                ? Border.all(width: 1, color: green)
                                : null),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                completeSteps.contains(e) ? white : primaryGrey,
                          ),
                        ),
                      ),
                      if (steps.last != e)
                        Column(
                          children: [
                            const SizedBox(
                              width: 44,
                              child: Divider(
                                color: lightgrey,
                                thickness: 1,
                              ),
                            ),
                            if (completeSteps.contains(e))
                              const Icon(
                                Icons.check,
                                color: secondaryGrey,
                              )
                          ],
                        ),
                    ],
                  );
                })
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              currentStep > 1 ? 'Подтверждение' : 'Регистрация',
              style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: primaryGrey),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 199,
              child: Text(
                currentStep > 1
                    ? 'Введите код, который мы отправили в SMS на ${_phone.text}'
                    : 'Введите номер телефона для регистрации',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: primaryGrey),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            CarouselSlider(
                carouselController: buttonCarouselController,
                items: [
                  Form(
                      key: _phoneFormKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Номер телефона',
                                style:
                                    TextStyle(color: primaryGrey, fontSize: 12),
                                textAlign: TextAlign.left,
                              ),
                              TextFormField(
                                controller: _phone,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  print(value);
                                  if (value == null) {
                                    return 'Обязательное поле';
                                  } else if (!isValidPhoneNumber(value)) {
                                    return 'Нужно ввести валидный номер';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    disabled = !isValidPhoneNumber(value);
                                  });
                                },
                                inputFormatters: [phoneMask],
                                decoration: InputDecoration(
                                  fillColor: white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: borderGrey),
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
                            ],
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_phoneFormKey.currentState!.validate()) {
                                buttonCarouselController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                                startTimer();
                                setState(() {
                                  currentStep = 2;
                                });
                              } else {
                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  !disabled ? yellow : secondaryGrey,
                              textStyle:
                                  const TextStyle(fontSize: 16, color: danger),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 68),
                              foregroundColor: primaryGrey,
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            child: const Text('Отправить смс-код'),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                    text:
                                        'Нажимая на данную кнопку, вы даете согласие на обработку',
                                    style: TextStyle(
                                        fontSize: 10, color: secondaryGrey)),
                                TextSpan(
                                    text: 'персональных данных',
                                    style: const TextStyle(
                                        fontSize: 10, color: yellow),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                            'https://your-privacy-policy-link.com'));
                                      })
                              ]))
                        ],
                      )),
                  Column(
                    children: [
                      OTPTextField(
                          controller: _otp,
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 15,
                          style:
                              const TextStyle(fontSize: 28, color: primaryGrey),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: ((context) {
                              return const MainScreen();
                            })));
                          }),
                      const SizedBox(
                        height: 44,
                      ),
                      if (_start > 0)
                        Text(
                          '$_start сек до повтора отправки кода',
                          style:
                              const TextStyle(color: primaryGrey, fontSize: 15),
                        )
                      else
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _start = 60;
                              _otp.clear();
                            });
                            startTimer();
                          },
                          child: const Text(
                            'Отправить код еще раз',
                            style: TextStyle(color: yellow, fontSize: 15),
                          ),
                        )
                    ],
                  )
                ],
                options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  initialPage: currentPage,
                  height: MediaQuery.of(context).size.height / 2,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  autoPlay: false,
                  aspectRatio: 2.0,
                  viewportFraction: 1,
                )),
          ],
        ),
      ),
    );
  }
}
