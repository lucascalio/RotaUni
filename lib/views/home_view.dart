import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = UserController();
  List<User> alunos = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  void carregar() async {
    alunos = await controller.listar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final alunosQueVao = alunos.where((u) => u.vai == 1).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Rota do Ônibus")),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-23.5505, -46.6333),
                zoom: 12,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Alunos confirmados:",
              style: TextStyle(fontSize: 18),
            ),
          ),

          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: alunosQueVao.length,
              itemBuilder: (context, index) {
                final aluno = alunosQueVao[index];

                return ListTile(
                  title: Text(aluno.nome),
                  subtitle: Text(aluno.endereco),
                  trailing: Icon(Icons.check, color: Colors.green),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}