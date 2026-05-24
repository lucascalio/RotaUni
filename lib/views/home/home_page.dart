import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../controllers/popup_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final LatLng origem =
      LatLng(-21.9695, -46.7980);

  final LatLng destino =
      LatLng(-21.9705, -46.7900);

  // STATUS DA VIAGEM
  String statusViagem = "Buscando alunos";

  Color getStatusColor() {
    switch (statusViagem) {
      case "Buscando alunos":
        return Colors.green;
      case "A caminho da sua parada":
        return Colors.orange;
      case "Em rota para a faculdade":
        return Colors.blue;
      case "Viagem finalizada":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // PASSAGEIROS (mock)
  final List<Map<String, String>> passageiros = [
    {"nome": "Ana Silva", "status": "Aguardando"},
    {"nome": "João Souza", "status": "Já embarcou"},
    {"nome": "Maria Oliveira", "status": "Aguardando"},
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPopup();
    });
  }

  void _checkPopup() async {

    final mostrar = await PopupController.deveMostrarPopup();

    if (!mounted || !mostrar) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {

        return AlertDialog(
          title: const Text("Confirmação diária"),
          content: const Text(
            "Você vai utilizar o transporte hoje?"
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Não"),
            ),

            ElevatedButton(
              onPressed: () async {

                await PopupController.salvarResposta();

                if (!mounted) return;

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Presença confirmada!"),
                  ),
                );
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('RotaUni'),
        backgroundColor: Colors.indigo,
      ),

      body: Column(

        children: [

          // MAPA
          Expanded(
            flex: 6,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: origem,
                initialZoom: 14,
              ),

              children: [

                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),

                MarkerLayer(
                  markers: [

                    Marker(
                      point: origem,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),

                    Marker(
                      point: destino,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.flag,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // PAINEL INFERIOR
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // STATUS
                  Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bus,
                        color: getStatusColor(),
                      ),
                      title: const Text("Status da viagem"),
                      subtitle: Text(
                        statusViagem,
                        style: TextStyle(
                          color: getStatusColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ETA
                  const Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text("Previsão de chegada"),
                      subtitle: Text(
                        "08:12 - Em 5 min (1.2 km)",
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // PRÓXIMA PARADA
                  const Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Próxima parada",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Faculdade UNIFAE - Entrada principal",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // AVISOS
                  const Text(
                    "Avisos importantes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Card(
                    color: Colors.yellow.shade100,
                    child: const ListTile(
                      leading: Icon(Icons.warning),
                      title: Text("Saída antecipada"),
                      subtitle: Text(
                        "Hoje o ônibus sairá 10 min mais cedo",
                      ),
                    ),
                  ),

                  Card(
                    color: Colors.blue.shade50,
                    child: const ListTile(
                      leading: Icon(Icons.cloud),
                      title: Text("Clima"),
                      subtitle: Text(
                        "Chuva prevista hoje ☔",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // PASSAGEIROS
                  const Text(
                    "Passageiros do dia",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: passageiros.length,
                    itemBuilder: (context, index) {

                      final aluno = passageiros[index];

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(aluno["nome"]!),
                          subtitle: Text(aluno["status"]!),
                          trailing: Icon(
                            aluno["status"] == "Já embarcou"
                                ? Icons.check_circle
                                : Icons.schedule,
                            color: aluno["status"] == "Já embarcou"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}