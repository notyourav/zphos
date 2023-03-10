import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zphos/app.dart';
import 'package:zphos/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:zphos/services/post_provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
