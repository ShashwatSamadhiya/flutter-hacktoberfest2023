import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  bool tapDown = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                decrementButton(),
                const SizedBox(width: 20),
                incrementButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incrementButton() {
    return button(() => _incrementCounter, const Icon(Icons.add, color: Colors.white));
  }

  Widget decrementButton() {
    return button(() => _decrementCounter, const Icon(Icons.remove, color: Colors.white));
  }

  Widget button(Function() onTap, Widget child) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      onTapDown: (_) {
        Future.delayed(const Duration(milliseconds: 30), () {
          if (mounted) {
            setState(
              () {
                tapDown = !tapDown;
              },
            );
          }
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            setState(
              () {
                tapDown = !tapDown;
              },
            );
          }
        });
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.5), color: tapDown ? Colors.amber.shade800 : Colors.amber, border: Border.all(color: Colors.white, width: 1.2)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 1.6,
              child: Container(
                height: height - 4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.5),
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16), topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              ),
            ),
            Positioned(
              right: tapDown ? 0.5 : 2.5,
              left: tapDown ? 0.5 : 2.5,
              top: tapDown ? 0.5 : 1.5,
              bottom: tapDown ? 3 : 6.5,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.amber, border: Border.all(color: Colors.amber, width: 2)),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
