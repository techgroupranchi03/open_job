import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/theme_config.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Open Job',
            debugShowCheckedModeBanner: false,

            // Theme Configuration
            theme: ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            // Initial Routekjhghk
            home: SplashScreen(),

            // System UI Overlay Style
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: themeProvider.isDarkMode
                      ? Brightness.light
                      : Brightness.dark,
                  systemNavigationBarColor: themeProvider.isDarkMode
                      ? Color(0xFF242526)
                      : Colors.white,
                  systemNavigationBarIconBrightness: themeProvider.isDarkMode
                      ? Brightness.light
                      : Brightness.dark,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
