import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zphos/firebase_options.dart';
import 'package:zphos/homepage.dart';
import 'package:zphos/post.dart';
import 'package:zphos/sidebar.dart';
import 'package:zphos/title_bar.dart';
import 'package:zphos/paths.dart';
// import 'package:provider/provider.dart';

List<Path> paths = [
  Path(
    '/',
    (context, path) => const MyHomePage(title: 'ZPHOS'),
  ),
  Path(
    '/post/(.*)/(.*)',
    (context, path) => const Post(),
  ),
];

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   '/about': (context) => const AboutPage(),
      //   //   '/post': (context) => const Post(),
      // },
      title: 'ZPHOS',
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        primarySwatch: Colors.grey,
        // dark theme if platform is dark
        brightness: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .platformBrightness ==
                Brightness.dark
            ? Brightness.dark
            : Brightness.light,
      ),
      home: const MyHomePage(title: 'ZPHOS'),
      onGenerateRoute: (settings) {
        Uri uri = Uri.parse(settings.name!);
        if (uri.path == '/post') {
          return MaterialPageRoute(
            builder: (context) => const Post(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: const SideBar(),
          drawerScrimColor: Colors.transparent,
          body: Stack(
            children: [
              Center(
                child: Row(
                  children: [
                    // const SideBar(),
                    Expanded(
                      child: Column(
                        children: const [
                          Expanded(
                            child: Homepage(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TitleBar(
                  title: widget.title,
                  onMenuPressed: () {
                    setState(() {
                      _scaffoldKey.currentState!.openDrawer();
                    });
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
