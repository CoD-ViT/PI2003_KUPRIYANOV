import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share/share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 45;
  bool fav = true;
  var iconC = Colors.grey;

  get transparent => null;
  void _incrementCounter() {
    setState(() {
      if (fav == true) {
        _counter++;
        fav = false;
        iconC = Colors.red;
      } else if (fav == false) {
        _counter--;
        fav = true;
        iconC = Colors.grey;
      }
    });
  }

  _callNumber() async {
    const number = '+79528225997';
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  void _share() async {
    Share.share('https://www.kubsau.ru/', subject: 'Официальный сайт КубГАУ');
  }

  _position() async {
    const url =
        'https://yandex.ru/maps/35/krasnodar/house/ulitsa_imeni_kalinina_13k20/Z0EYfwVgTkUDQFpvfXx0cX9hbQ==/?ll=38.921374%2C45.050091&z=10';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Image.asset("images/lab.jpg"),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text('Общежитие №20',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text('Краснодар, ул. Калинина, 13',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      color: iconC,
                      icon: const Icon(Icons.favorite),
                      onPressed: _incrementCounter,
                    ),
                    Text(
                      '$_counter',
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        color: Colors.green,
                        icon: const Icon(Icons.call),
                        onPressed: _callNumber,
                      ),
                      const Text('ПОЗВОНИТЬ',
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        color: Colors.green,
                        icon: const Icon(Icons.near_me),
                        onPressed: _position,
                      ),
                      const Text('МАРШРУТ',
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        color: Colors.green,
                        icon: const Icon(Icons.share),
                        onPressed: _share,
                      ),
                      const Text('ПОДЕЛИТЬСЯ',
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ]),
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 30, 40, 20),
              child: Text(
                style: TextStyle(fontSize: 15),
                'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
