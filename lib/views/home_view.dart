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
      appBar: AppBar(
        title: Text("Rota do Ônibus"),
      ),
      body: Column(
        children: [
          // MAPA
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(-23.5505, -46.6333),
                  zoom: 12,
                ),
              ),
            ),
          ),

          // CARD TÍTULO
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              "Alunos confirmados para hoje",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // LISTA
          Expanded(
            flex: 1,
            child: alunosQueVao.isEmpty
                ? Center(
                    child: Text(
                      "Nenhum aluno confirmado",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: alunosQueVao.length,
                    itemBuilder: (context, index) {
                      final aluno = alunosQueVao[index];

                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(aluno.nome),
                          subtitle: Text(aluno.endereco),
                          trailing: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}