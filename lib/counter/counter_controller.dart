// import 'dart:async';

// class CounterController {
//   late int _counter;

//   final StreamController<int> _countController = StreamController<int>();
//   Stream<int> get counterStream => _countController.stream;
//   StreamSink<int> get counterSink => _countController.sink;

//   final StreamController<int> _incrementCounterController = StreamController<int>();
//   StreamSink<int> get incrementCounter => _incrementCounterController.sink;

//   final StreamController<int> _decrementCounterController = StreamController<int>();
//   StreamSink<int> get decrementCounter => _decrementCounterController.sink;

//   CounterController() {
//     _counter = 0;
//     _countController.add(_counter);
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       _counter = timer.tick;
//       counterSink.add(_counter);
//     });
//     _incrementCounterController.stream.listen(_increment);
//     _decrementCounterController.stream.listen(_decrement);
//     // _counter = 0;
//   }

//   void _increment(int value) {
//     value++;
//     counterSink.add(value);
//     // _counter = value;
//   }

//   void _decrement(int value) {
//     if (value > 0) {
//       value--;
//       counterSink.add(value);
//     }
//     // _counter = value;
//   }

//   void dispose() {
//     _countController.close();
//     _decrementCounterController.close();
//     _incrementCounterController.close();
//   }
// }

import 'dart:async';

import 'package:stream_examples/contracts/disposable.dart';

class CounterController implements Disposable {
  late int _counter;

  final StreamController<int> _counterController = StreamController<int>();
  Stream<int> get counterStream => _counterController.stream;
  StreamSink<int> get counterSink => _counterController.sink;

  final StreamController<int> _incrementCounterController = StreamController<int>();
  StreamSink<int> get incrementCounter => _incrementCounterController.sink;

  final StreamController<int> _decrementCounterController = StreamController<int>();
  StreamSink<int> get decrementCounter => _decrementCounterController.sink;


  CounterController() {
    _counter = 0;
    _counterController.add(_counter);
    _incrementCounterController.stream.listen(_increment);
    _decrementCounterController.stream.listen(_decrement);
  }

  void _increment(int value) {
    value++;
    counterSink.add(value);
  }

  void _decrement(int value) {
    if (value > 0) {
      value--;
      counterSink.add(value);
    }
  }

  @override
  void dispose() {
    _counterController.close();
    _incrementCounterController.close();
    _decrementCounterController.close();
  }
}
