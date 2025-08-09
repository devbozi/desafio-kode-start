# 🚀 Rick and Morty Explorer

Uma aplicação Flutter que consome a [Rick and Morty API](https://rickandmortyapi.com/) para listar, buscar e visualizar detalhes dos personagens da série. Desenvolvido como parte do **Desafio Kode Start 2025**, este projeto foca em boas práticas, arquitetura limpa e uma interface moderna.

---

## 🧰 Tecnologias utilizadas

- Flutter 3.x
- Dart
- HTTP
- Google Fonts
- Rick and Morty API

---

## 🧱 Estrutura do projeto

Organizado com base em princípios de **Clean Code** e **Separation of Concerns**:


---

## 🧠 Padrões e práticas aplicadas

| Padrão / Técnica                  | Descrição                                                                 |
|----------------------------------|---------------------------------------------------------------------------|
| **StatefulWidget**               | Gerenciamento de estado local nas telas                                   |
| **Repository Pattern**           | Abstração da lógica de acesso à API                                       |
| **Model Factory**                | Criação segura de objetos a partir de JSON                                |
| **Scroll infinito**              | Implementado com `ScrollController`                                       |
| **Busca manual**                 | Acionada por botão para controle total                                    |
| **Safe async context**           | Uso de `mounted` para evitar erros após `await`                           |
| **Custom Widgets**               | Componentes reutilizáveis para UI                                         |
| **Google Fonts**                 | Tipografia personalizada com `Lato`                                       |
| **Error handling com log**       | Uso de `dart:developer` para rastreabilidade                              |

---

## 📱 Funcionalidades

- Listagem de personagens com scroll infinito
- Busca por nome com botão de ação
- Visualização de detalhes do personagem
- Layout responsivo e adaptável

---

## 🧪 Como executar

1. **Clone o repositório:**

```bash
git clone https://github.com/seu-usuario/rick_and_morty_explorer.git
cd rick_and_morty_explorer
flutter pub get
flutter run
