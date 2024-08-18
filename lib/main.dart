import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/Models/task_Model.dart';
import 'package:taskly/View/home/widget/home_view.dart';
import 'package:taskly/data/hive_data_store.dart';

 Future<void> main()async {

  await Hive.initFlutter();

    Hive.registerAdapter<Task>(TaskmdlAdapter());
   //open box
    Box box = await Hive.openBox<Task>(HiveDataStore.boxName);


    box.values.forEach((task) {
      if(task.createdAtTime.day != DateTime.now().day){
        task.delete();
      }else{

      }
    });


  runApp(    Basewidget(

      child: const MyApp()));
}

class   Basewidget extends InheritedWidget{
   Basewidget({Key? key, required this.child }) : super(key: key,child: child);
  
  final HiveDataStore dataStore = HiveDataStore();
   final Widget child;

   static Basewidget of(BuildContext context){
     final base = context.dependOnInheritedWidgetOfExactType<Basewidget>();
     if(base != null){
       return base;
     }else{
       throw StateError("Could not find ancestor widget of type BaseWidget");
     }
   }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,fontSize: 45,
            fontWeight: FontWeight.bold
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium:
            TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
              fontSize: 14,
            fontWeight: FontWeight.w400,
          ),headlineMedium:
            TextStyle(
              color: Colors.grey,
              fontSize: 17
            ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),


        )



          ),
      home: HomeView(),
    );
  }
}

class HomeTsk extends StatefulWidget {
  const HomeTsk({
    super.key,
  });
  @override
  State<HomeTsk> createState() => _HomeTskState();
}

class _HomeTskState extends State<HomeTsk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
