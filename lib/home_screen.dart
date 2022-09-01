import 'package:flutter/material.dart';
import 'package:stream_examples/counter/counter_screen.dart';
import 'package:stream_examples/note/note_screen.dart';
import 'package:stream_examples/product/product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CustomButton(
              text: "Counter Screen",
              onPressed: () {
                navigator(context, CounterScreen());
              },
            ),
            _CustomButton(
              text: "Product Screen",
              onPressed: () {
                navigator(context, ProductScreen());
              },
            ),
            _CustomButton(
              text: "Note Screen",
              onPressed: () {
                navigator(context, NoteScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      // width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

Future<dynamic> navigator(BuildContext context, Widget screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}
