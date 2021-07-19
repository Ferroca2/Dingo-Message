import 'package:flutter/material.dart';
import '../../config/Mycolors.dart';
import '../chat_rooms/chat_rooms.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingController = TextEditingController();
  String userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Mycolors.corbasica,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Usuário",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 250),
                buildTextField("@Usuario"),
                SizedBox(height: 100),
                GestureDetector(
                  onTap: () {
                    if (textEditingController.text.isNotEmpty) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ChatRoomsPage(
                                userName: textEditingController.text,
                              )));
                    }
                  },
                  child: botton("Entrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String recado) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: recado,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget botton(String meutext) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Mycolors.corprincipal,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          meutext,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
