import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    double imageSize = (screenWidth * 0.4).clamp(200, 240);
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

                  Image.asset(
                    'asset/icon/vaultappicon.png',
                    width: imageSize, // 40% of screen width
                    height: imageSize, // keep square
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: fieldWidth.clamp(
                      300,
                      500,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Welcome Back!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB0BEC5),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Login to continue to your account',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB0BEC5),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
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

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: RichText(
                              text: TextSpan(
                                text: 'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(
                          text: "Login",
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
