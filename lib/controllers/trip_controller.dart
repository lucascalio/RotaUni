import '../models/trip_model.dart';

class TripController {

  TripModel buscarViagem() {

    return TripModel(
      motorista: 'Carlos Silva',
      proximoDestino: 'UNIFAE',
      previsaoChegada: '15 min',
    );
  }
}