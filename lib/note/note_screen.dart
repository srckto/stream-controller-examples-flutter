import 'package:flutter/material.dart';
import 'package:stream_examples/note/note_controller.dart';
import 'package:stream_examples/note/note_model.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  NoteController noteController = NoteController();
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Screen"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: noteController.notesStream,
        builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (!snapshot.hasData) return Text("Not have data");
              if (snapshot.hasError) return Text("Has Error");
              if (snapshot.hasData)
                return Column(
                  children: [
                    Flexible(
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 0);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            height: 70,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data![index].title!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].content!,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _textEditingController,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              noteController.addNoteSink.add(
                                NoteModel(
                                  title: _textEditingController.text,
                                  content: _textEditingController.text,
                                ),
                              );
                              _textEditingController.clear();
                            },
                            child: Text("Add Notes"),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
          }
          return Text("Other ........");
        },
      ),
    );
  }
}
