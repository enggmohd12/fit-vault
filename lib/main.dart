import 'package:fitvault/state/app_router/app_router_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dialogTheme: DialogThemeData(
          backgroundColor: Color(0xFFEEF0FF), // light indigo tint
          surfaceTintColor: Colors.transparent, // keep color flat on M3
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A237E), // indigo900-ish
            fontFamily: 'Poppins', // consistent font
          ),
          contentTextStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFF303F9F), // indigo700-ish
            fontFamily: 'Poppins', // consistent font
          ),
        ),
        primaryColor: Color(0xFF283593), // Deep Blue
        colorScheme:
            ColorScheme.fromSwatch(
              primarySwatch: Colors.indigo,
              accentColor: Color(0xFF6A1B9A), // Indigo/Purple
              backgroundColor: Color(0xFFF3F3FC), // Very light purple
            ).copyWith(
              secondary: Color(0xFF6A1B9A),
              surface: Color(0xFFF3F3FC),
              brightness: Brightness.light,
            ),
        scaffoldBackgroundColor: Color(0xFFF3F3FC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF283593),
          foregroundColor: Colors.white,
          elevation: 4.0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6A1B9A),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF283593),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
