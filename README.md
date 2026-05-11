# 🚍 RotaUni

Aplicativo mobile desenvolvido em Flutter para gerenciamento de transporte universitário.

## 📱 Sobre o Projeto

O **RotaUni** tem como objetivo facilitar a comunicação entre estudantes e motoristas de transporte universitário, permitindo:

* Cadastro de alunos com preenchimento automático de endereço via CEP
* Confirmação de presença diária
* Visualização da rota do ônibus
* Previsão de chegada
* Listagem de alunos que utilizarão o transporte

---

## 🧠 Arquitetura

O projeto segue o padrão **MVC (Model-View-Controller)**:

* **Model:** Representação dos dados (User)
* **View:** Interface do usuário
* **Controller:** Regras de negócio
* **Service:** Integrações externas (SQLite e API CEP)

---

## 🛠️ Tecnologias Utilizadas

* Flutter / Dart
* SQLite (sqflite)
* API ViaCEP
* Google Maps Flutter

---

## 🗂️ Estrutura do Projeto

```
lib/
 ├── models/
 ├── views/
 ├── controllers/
 ├── services/
 ├── config/
 └── widgets/
```

---

## ⚙️ Funcionalidades

✔ Login de usuário
✔ Cadastro com busca automática de endereço
✔ Confirmação de presença (vai/não vai)
✔ Armazenamento local com SQLite
✔ Exibição de rota e alunos confirmados

---

## 🚀 Como Executar

```bash
flutter pub get
flutter run
```

---

## 📦 Como Clonar

```bash
git clone https://github.com/seu-usuario/rotauni.git
```

---

## 📸 Telas do App

* Login
* Cadastro
* Confirmação
* Home com mapa

---

## 💡 Melhorias Futuras

* Integração com Firebase
* Rastreamento em tempo real do ônibus
* Notificações push
* Login com autenticação real

---

## 👨‍💻 Autor

Projeto desenvolvido para atividade acadêmica de Desenvolvimento Mobile.
