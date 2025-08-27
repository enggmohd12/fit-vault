import 'dart:io';
import 'package:fitvault/components/dialaogs/validation_dialog.dart';
import 'package:fitvault/components/sharedpreference_key.dart';
import 'package:fitvault/models/register_view/rule_item.dart';
import 'package:fitvault/models/register_view/strength_enum.dart';
import 'package:fitvault/views/register/components/check_list.dart';
import 'package:fitvault/views/register/components/strength_bar.dart';
import 'package:fitvault/views/register/validation/register_validation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final loginId = TextEditingController();
  bool _focused = false;

  bool get _lengthOk => password.text.length >= 8;
  bool get _upperOk => RegExp(r'[A-Z]').hasMatch(password.text);
  bool get _lowerOk => RegExp(r'[a-z]').hasMatch(password.text);
  bool get _digitOk => RegExp(r'\d').hasMatch(password.text);
  bool get _specialOk => RegExp(
    r'''[!@#\$%^&*()_\-+=\[\]{};:'",.<>/?\\|~`]''',
  ).hasMatch(password.text);

  int get _score {
    int s = 0;
    if (_lengthOk) s++;
    if (_upperOk) s++;
    if (_lowerOk) s++;
    if (_digitOk) s++;
    if (_specialOk) s++;
    if (password.text.length >= 12) s++;
    return s.clamp(0, 6);
  }

  Strength get _strength {
    if (_score <= 2) return Strength.weak;
    if (_score == 3) return Strength.fair;
    if (_score == 4 || _score == 5) return Strength.good;
    return Strength.strong;
  }

  Color _strengthColor(BuildContext context) {
    switch (_strength) {
      case Strength.weak:
        return Colors.redAccent;
      case Strength.fair:
        return Colors.amber;
      case Strength.good:
        return Colors.lightGreen;
      case Strength.strong:
        return Colors.green;
    }
  }

  String _strengthLabel() {
    switch (_strength) {
      case Strength.weak:
        return 'Weak';
      case Strength.fair:
        return 'Fair';
      case Strength.good:
        return 'Good';
      case Strength.strong:
        return 'Strong';
    }
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    loginId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    // 👇 Pick width dynamically
    final fieldWidth = screenWidth > 600
        ? screenWidth *
              0.5 // Tablets → 50% of screen width
        : screenWidth * 0.9; // Phones → 90% of screen width

    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF3F51B5), // Indigo 500
                Color(0xFF1A237E), // Indigo 900
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                if (context.mounted) {
                                  context.go('/');
                                }
                              },
                              icon: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Create your account with ID and Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB0BEC5),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                    width: fieldWidth.clamp(
                      300,
                      500,
                    ),
                    child: TextField(
                      controller: loginId,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Login ID',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(
                          alpha: 0.1,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: fieldWidth.clamp(
                      300,
                      500,
                    ),
                    child: FocusScope(
                      child: Column(
                        children: [
                          Focus(
                            onFocusChange: (value) {
                              setState(() => _focused = value);
                            },
                            child: TextField(
                              controller: password,
                              onChanged: (_) => setState(() {}),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                filled: true,
                                fillColor: Colors.white.withValues(
                                  alpha: 0.1,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (_focused || password.text.isNotEmpty)
                                ? 10
                                : 20,
                          ),
                          if ((_focused || password.text.isNotEmpty)) ...[
                            StrengthBar(
                              strength: _strength,
                              color: _strengthColor(context),
                              label: _strengthLabel(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],

                          AnimatedCrossFade(
                            firstChild: Checklist(
                              items: [
                                RuleItem(
                                  label: 'At least 8 characters',
                                  met: _lengthOk,
                                ),
                                RuleItem(
                                  label: 'Uppercase letter (A–Z)',
                                  met: _upperOk,
                                ),
                                RuleItem(
                                  label: 'Lowercase letter (a–z)',
                                  met: _lowerOk,
                                ),
                                RuleItem(
                                  label: 'Number (0–9)',
                                  met: _digitOk,
                                ),
                                RuleItem(
                                  label: 'Special character',
                                  met: _specialOk,
                                ),
                              ],
                            ),
                            secondChild: const SizedBox.shrink(),
                            crossFadeState:
                                (_focused || password.text.isNotEmpty)
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(
                              milliseconds: 250,
                            ),
                          ),
                          if (_focused || password.text.isNotEmpty)
                            const SizedBox(
                              height: 10,
                            ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: fieldWidth.clamp(
                      300,
                      500,
                    ),
                    child: TextField(
                      controller: confirmPassword,
                      cursorColor: Colors.white,
                      obscureText: !isConfirmPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(
                          alpha: 0.1,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: fieldWidth.clamp(
                      300,
                      500,
                    ), // same width as TextField
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Cyan accent
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8, // subtle shadow
                      ),
                      onPressed: () async {
                        final validation = await validationRegister(
                          email: loginId.text,
                          password: password.text,
                          confirmPassword: confirmPassword.text,
                        );
                        if (!validation.$1) {
                          if (context.mounted) {
                            await showValidationDialog(
                              context: context,
                              subTitle: validation.$2,
                            );
                          }
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          final isLoginSetupDone = await prefs.setBool(
                            SharedPreferenceKey.isLoginSetupDone,
                            true,
                          );
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Register",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                            fontFamily: 'Poppins', // Text color
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
