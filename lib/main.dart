import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_x/view/pages/landing_page.dart';

import 'bloc/common_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommonBloc>(
          create: (BuildContext context) => CommonBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Space X',
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textTheme: GoogleFonts.spaceMonoTextTheme(),
          appBarTheme: ThemeData.dark().appBarTheme.copyWith(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
          scaffoldBackgroundColor: const Color(0xFF3c4f5a),
          useMaterial3: true,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
