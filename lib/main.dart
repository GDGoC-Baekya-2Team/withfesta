import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:withfesta/Page/CalendarPage.dart';
import 'package:withfesta/Page/FindPersonPage.dart';
import 'package:withfesta/Page/SearchPage.dart';
import 'package:withfesta/mainProvider.dart';

void main() {
  runApp(ProviderScope(child:  MyApp()));
}
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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

                colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Colors.black,
                  onPrimary: Colors.black,
                  secondary: Colors.black,
                  onSecondary: Colors.black,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Colors.white,
                  onBackground: Colors.black,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)
            ),
            home: child,

          );
        },
        child: MyHomePage(title: "MyHomePage")
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  var tapPageList=[
    CalendarPage(),
    SearchPage(),
    FindPersonpage()
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: tapPageList[ref.watch(mainPageIndexProvider)],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.search_outlined,),
          TabItem(icon: Icons.people),
    ],
    onTap: (int i) => ref.read(mainPageIndexProvider.notifier).state=i
    ),

    );
  }
}
