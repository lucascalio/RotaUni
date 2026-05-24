# 📱 RotaUni - Sistema de Transporte Universitário

Sistema mobile desenvolvido em Flutter para gerenciamento de transporte universitário, permitindo controle de rotas, passageiros, confirmação diária de presença e visualização de trajetos em mapa.

---

## 🚀 Funcionalidades

### 🔐 Autenticação
- Login de usuários (Aluno e Motorista)
- Cadastro com validação completa
- Integração com Firebase Authentication

---

### 👤 Cadastro de Usuário
- Nome completo
- Celular com máscara
- CEP com consulta automática via API ViaCEP
- Endereço completo (rua, bairro, cidade)
- Email e senha com confirmação
- Validação de todos os campos

---

### 🚌 Tela Principal (Home)
- Mapa interativo com Flutter Map
- Exibição de rota (origem e destino)
- Status da viagem em tempo real:
  - 🟢 Buscando alunos
  - 🟡 A caminho da parada
  - 🔵 Em rota para faculdade
  - 🔴 Viagem finalizada
- Previsão de chegada (ETA)
- Próxima parada destacada
- Avisos importantes
- Lista de passageiros do dia

---

### 📌 Popup Diário Inteligente
- Aparece apenas de segunda a sexta-feira
- Exibido apenas 1 vez por dia
- Pergunta: “Você vai utilizar o transporte hoje?”
- Armazenamento local com SharedPreferences
- Confirmação salva no dispositivo

---

### 🗺️ Mapa e Rota
- Flutter Map com OpenStreetMap
- Marcadores de origem e destino
- Interface leve e sem necessidade de API paga

---

## 🏗️ Arquitetura

O projeto segue padrão **MVC (Model-View-Controller)**:
```
lib/
│
├── models/
├── views/
│ ├── login/
│ ├── register/
│ └── home/
│
├── controllers/
│ └── popup_controller.dart
│
├── services/
│ ├── firebase_service.dart
│ └── viacep_service.dart
│
├── utils/
│ ├── validators.dart
│ ├── constants.dart
│ └── themes.dart
│
└── main.dart
```

---

## 🔥 Tecnologias Utilizadas

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- SharedPreferences
- Flutter Map
- OpenStreetMap
- ViaCEP API
- MVC Architecture

---

## 📦 Dependências principais

```yaml
dependencies:
  flutter:
  firebase_core:
  firebase_auth:
  cloud_firestore:
  shared_preferences:
  flutter_map:
  latlong2:
  http:
  mask_text_input_formatter:
```

# ⚙️ Configuração do Projeto

## 1. Clonar repositório
```bash
git clone https://github.com/seuusuario/rotauini.git
```

## 2. Instalar dependências
```flutter pub get```

## 3. Configurar Firebase
```
dart pub global activate flutterfire_cli
flutterfire configure
```

## 4. Rodar aplicação
```flutter run```

---

# 🔐 Firebase

O projeto utiliza:

Firebase Authentication (login/cadastro)
Firestore (armazenamento de usuários e dados futuros)

---

# 📍 API Externa

## ViaCEP

Utilizada para preenchimento automático de endereço via CEP.

https://viacep.com.br/ws/{cep}/json/

---

# 🧠 Lógica do Popup Diário
- Verifica dia da semana (segunda a sexta)
- Verifica se já foi exibido no dia
- Usa SharedPreferences para controle local
- Evita repetição no mesmo dia

---

# 🎨 Interface
- Design moderno e limpo
- Cards com elevação e sombras
- Cores dinâmicas por status da viagem
- UI inspirada em apps de transporte (Uber/99)

---

# 📊 Status do Projeto
- ✔ Login funcional
- ✔ Cadastro completo
- ✔ Mapa funcional
- ✔ Popup diário funcional
- ✔ UI profissional

---

# 👨‍💻 Autor

Lucas Vigo Calió
