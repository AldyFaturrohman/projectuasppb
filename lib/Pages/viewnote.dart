import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late String title;
  late String des;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];
    return SafeArea(
      child: Scaffold(
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.white,
                ),
                backgroundColor: Color.fromARGB(255, 190, 138, 98),
              )
            : null,
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Color.fromARGB(255, 255, 223, 186),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 24.0,
                            ),
                            Text("  Notes  "),
                          ],
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 190, 138, 98),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                edit = !edit;
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 24.0,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 190, 138, 98),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          ElevatedButton(
                            onPressed: delete,
                            child: Icon(
                              Icons.delete_forever,
                              size: 24.0,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 190, 138, 98),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(100, 0, 0, 0),
                            )
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 32.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          initialValue: widget.data['title'],
                          enabled: edit,
                          onChanged: (_val) {
                            title = _val;
                          },
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Can't be empty !";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                            bottom: 12.0,
                          ),
                          child: Text(
                            widget.time,
                            style: GoogleFonts.poppins(
                              color: Color.fromARGB(180, 0, 0, 0),
                              fontSize: 20.0
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Note Description",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            )
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          initialValue: widget.data['description'],
                          enabled: edit,
                          onChanged: (_val) {
                            des = _val;
                          },
                          maxLines: 20,
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Can't be empty !";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState!.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}