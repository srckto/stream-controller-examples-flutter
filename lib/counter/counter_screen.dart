import 'package:flutter/material.dart';
import 'package:stream_examples/counter/counter_controller.dart';

class CounterScreen extends StatefulWidget {
  CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterController counterController = CounterController();

  @override
  void dispose() {
    super.dispose();
    counterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Screen"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: counterController.counterStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text("Error");
          if (!snapshot.hasData) return Text("No Data");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        counterController.incrementCounter.add(snapshot.data!);
                      },
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        counterController.decrementCounter.add(snapshot.data!);
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    counterController.counterSink.add(0);
                    // counterController.decrementCounter.add(snapshot.data!);
                  },
                  icon: Icon(Icons.replay_outlined),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
