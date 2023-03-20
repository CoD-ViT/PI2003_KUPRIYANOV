import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
      title: 'Navigation Basics',
      home: SimpleList(),
      debugShowCheckedModeBanner: false));
}

class SimpleList extends StatelessWidget {
  const SimpleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Простой список элементов'),
        backgroundColor: Colors.green[600],
      ),
      body: ListView(children: const [
        Text('0000'),
        Divider(),
        Text('0001'),
        Divider(),
        Text('0010'),
      ]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
                title: const Text("Список №2"),
                leading: const Icon(Icons.check),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InfinityList()),
                  );
                }),
            ListTile(
                title: const Text("Список №3"),
                leading: const Icon(Icons.check),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InfinityMathList()),
                  );
                })
          ],
        ),
      ),
    );
  }
}

final List<String> _array = [];

class InfinityList extends StatelessWidget {
  const InfinityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Бесконечный список'),
        backgroundColor: Colors.red[600],
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final int index = i ~/ 2;
        if (index >= _array.length) {
          _array.addAll(['$index', '${index + 1}', '${index + 2}']);
        }
        return ListTile(
          title: Text('Строка ${_array[index]}'),
        );
      }),
    );
  }
}

class InfinityMathList extends StatelessWidget {
  const InfinityMathList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Возведение числа 2 в степень'),
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final int index = i ~/ 2;
        if (index >= _array.length) {
          _array.addAll(['$index', '${index + 1}', '${index + 2}']);
        }
        var double = index.toDouble();
        return ListTile(
          title: Text(
              '2 ^ ${double.toStringAsFixed(0)} = ${pow(2, double).toStringAsFixed(0)}'),
        );
      }),
    );
  }
}
