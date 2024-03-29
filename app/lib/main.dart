// ignore_for_file: prefer_const_constructors

import 'package:app/bloc/counterbloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterblocBloc(),
      child: MaterialApp(
        home: MyHomePage(title: "Counterapp"),
      ),
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
              //BlocBuilder is used to listen any change in the state of any specific bloc here we pass bloc and state as  a generic
              BlocBuilder<CounterblocBloc, CounterblocState>(
                builder: (context, state) {
                  //checking if the state matches then it will show screen according to state
                  //here is means state is equal to Counterblocsuccess
                  if (state is Counterblocsuccess) {
                    _counter = state.counter;
                    return Text("$_counter");
                  } else {
                    return Text("0");
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                //Here we are calling any specific event so in the bloc here we have only one event
                BlocProvider.of<CounterblocBloc>(context)
                    .add(OnClick(counter: _counter, operator: "+"));
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                //Here we are calling any specific event so in the bloc

                BlocProvider.of<CounterblocBloc>(context)
                    .add(OnClick(counter: _counter, operator: '-'));
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                //Here we are calling any specific event so in the bloc

                BlocProvider.of<CounterblocBloc>(context)
                    .add(OnClick(counter: _counter, operator: 'reset'));
              },
              tooltip: 'Reset',
              child: const Icon(Icons.reset_tv),
            ),
          ],
        ));
  }
}
