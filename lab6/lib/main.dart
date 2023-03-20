import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Калькулятор площади'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title = 'Калькулятор площади'});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _height = Key('height');
  final _width = Key('width');
  String result = '';
  final widthController = TextEditingController();
  final heightController = TextEditingController();

  void _schet() async {
    if (_formKey.currentState!.validate() &&
        (widthController.text.isEmpty ||
            heightController.text.isEmpty ||
            double.parse(widthController.text) <= 0 ||
            double.parse(heightController.text) <= 0)) {
      setState(() {
        result = 'ЗАДАЙТЕ ПАРАМЕТРЫ';
      });
    } else {
      double width = double.parse(widthController.text);
      double height = double.parse(heightController.text);
      setState(() {
        result = 'S = $width * $height = ${width * height}(мм2)';
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Форма успешно заполнена'),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            'Ширина (мм):',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          key: _width,
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.red)),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста введите ширину';
                              }
                              final isDigitsOnly =
                                  RegExp(r'^\d+$').hasMatch(value);
                              if (!isDigitsOnly) {
                                return 'Введите только цифры!';
                              }
                              return null;
                            },
                            controller: widthController,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ]),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Высота (мм):',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          key: _height,
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.red)),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста введите высоту';
                              }
                              final isDigitsOnly =
                                  RegExp(r'^\d+$').hasMatch(value);
                              if (!isDigitsOnly) {
                                return 'Введите только цифры!';
                              }
                              return null;
                            },
                            controller: heightController,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ]),
                Padding(padding: EdgeInsets.only(top: 40)),
                ElevatedButton(onPressed: _schet, child: Text('Вычислить')),
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  result,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            )),
      ),
    );
  }
}
