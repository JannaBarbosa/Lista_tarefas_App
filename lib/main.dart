import 'package:flutter/material.dart';
import 'package:lista_tarefas_app/tarefa.dart';

//import 'package:flutter/src/widgets/framework.dart';

void main() {
  runApp(new ListaTarefasApp());
}

class ListaTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new ListaScreen());
  }
}

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  TextEditingController controller = new TextEditingController();

  List<Tarefa> tarefas = new List<Tarefa>();

  void adicionarTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome));
    });
    controller.clear();
  }

  Widget getItem(Tarefa tarefa) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            icon: new Icon(
              tarefa.concluida
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Colors.green,
            ),
            iconSize: 42.0,
            onPressed: () {
              setState(() {
                tarefa.concluida = true;
              });
            }),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(tarefa.nome,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),), Text(tarefa.data.toIso8601String())],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Lista de Tarefas")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                onSubmitted: adicionarTarefa,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (_, indice) {
                return getItem(tarefas[indice]);
              },
            ))
          ],
        ));
  }
}
