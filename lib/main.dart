import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
        designSize: const Size(386, 815),
        fontSizeResolver: FontSizeResolvers.height,
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_ , child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'With Festa',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)
            ),
            home: child,

          );
        },
        child: MyHomePage(title: "MyHomePage")
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.search_outlined,),
          TabItem(icon: Icons.people),
    ],
    onTap: (int i) => print('click index=$i'),
    ),

    );
  }
}
