import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
import '../controller/simple_ui_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size, simpleUIController);
            } else {
              return _buildSmallScreen(size, simpleUIController);
            }
          },
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            child: Lottie.asset(
              'assets/coin.json',
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(
            size,
            simpleUIController,
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        size.width > 600
            ? Container()
            : Lottie.asset(
                'assets/wave.json',
                height: size.height * 0.2,
                width: size.width,
                fit: BoxFit.fill,
              ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Войти',
            style: kLoginTitleStyle(size),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0),
        //   child: Text(
        //     'Welcome Back Catchy',
        //     style: kLoginSubtitleStyle(size),
        //   ),
        // ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// username or Gmail
                TextFormField(
                  style: kTextFormFieldStyle(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'ИНН',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),

                  controller: nameController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите инн паспорта';
                    } else if (value.length < 4) {
                      return 'введите цифры';
                    } else if (value.length > 13) {
                      return 'максимальное количество цифр 12';
                    }
                    return null;
                  },
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                // TextFormField(
                //   controller: emailController,
                //   decoration: const InputDecoration(
                //     prefixIcon: Icon(Icons.email_rounded),
                //     hintText: 'gmail',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(15)),
                //     ),
                //   ),
                //   // The validator receives the text that the user has entered.
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter gmail';
                //     } else if (!value.endsWith('@gmail.com')) {
                //       return 'please enter valid gmail';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// password
                Obx(
                  () => TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: kTextFormFieldStyle(),
                    controller: passwordController,
                    obscureText: simpleUIController.isObscure.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open),
                      suffixIcon: IconButton(
                        icon: Icon(
                          simpleUIController.isObscure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          simpleUIController.isObscureActive();
                        },
                      ),
                      hintText: 'Пароль',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите пароль';
                      } else if (value.length < 7) {
                        return 'введите не менее 6 символов';
                      } else if (value.length > 13) {
                        return 'максимальное количество символов 9';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    text: 'забыли пароль?',
                    style: kLoginTermsAndPrivacyStyle(size),
                    // children: [
                    //   TextSpan(
                    //       text: "забыли пароль?",
                    //       style: kLoginOrSignUpTextStyle2(size)),
                    // ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                RichText(
                  text: TextSpan(
                    text:
                        'Используя придложения Салым Финанс вы соглашаетесь\n             ',
                    style: kLoginTermsAndPrivacyStyle2(size),
                    children: [
                      TextSpan(
                          text: "c правилами и условиями пользования",
                          style: kLoginOrSignUpTextStyle3(size)),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.09,
                ),

                /// Login Button
                loginButton(),
                SizedBox(
                  height: size.height * 0.03,
                ),

                /// Navigate To Login Screen
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    _formKey.currentState?.reset();
                    simpleUIController.isObscure.value = true;
                  },
                  child: RichText(
                    text: TextSpan(
                      text: ' У вас нет аккаунта?\n',
                      style: kHaveAnAccountStyle(size),
                      children: [
                        TextSpan(
                          text: "Зарегистрироваться",
                          style: kLoginOrSignUpTextStyle(
                            size,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 108, 173, 159)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
        },
        child: const Text('Войти'),
      ),
    );
  }
}
