import 'package:flutter/material.dart';
import '../../config/Mycolors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat/chat_page.dart';

class ChatRoomsPage extends StatefulWidget {
  final String userName;

  ChatRoomsPage({this.userName});

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  TextEditingController textEditingController = TextEditingController();
  Stream salas;

  @override
  void initState() {
    salas = FirebaseFirestore.instance.collection("chatRooms").snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: add(), backgroundColor: Mycolors.corprincipal),
        backgroundColor: Mycolors.corbasica,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              Text(
                "Salas Disponíveis",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 100),
              Text(widget.userName),
              SizedBox(height: 50),
              buildTextField("texto basico"),
              SizedBox(height: 50),
              allRooms(),
            ],
          ),
        ),
      ),
    );
  }

  Widget allRooms() {
    return StreamBuilder(
        stream: salas,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          }
          final listaSalas = snapshot.data.docs;
          return Column(
            children: [
              for (int i = 0; i < listaSalas.length; i++)
                buildRoom(
                    listaSalas[i]["nome_da_sala"], listaSalas[i]["horario"]),
            ],
          );
        });
  }

  Widget buildRoom(String nomeDaSala, int horarioDaSala) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ChatPage(
                  nomeDaSala: nomeDaSala,
                  horarioDaSala: horarioDaSala,
                  userName: widget.userName,
                )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nomeDaSala),
            Icon(
              Icons.circle,
              color: Colors.green,
            ),
          ],
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

  Widget add() {
    int horario = DateTime.now().millisecondsSinceEpoch;
    return GestureDetector(
        onTap: () {
          if (textEditingController.text.isNotEmpty) {
            criarSala(textEditingController.text, horario, widget.userName);
            textEditingController.text = "";
          }
        },
        child: Icon(Icons.add));
  }

  void criarSala(String salaNome, int horario, String userName) {
    var salaDados = {
      "nome_da_sala": salaNome,
      "horario": horario,
      "criado_por": userName,
    };

    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(horario.toString())
        .set(salaDados);
  }
}
