# Trunfo Atômico

Aplicativo mobile em Flutter que aproxima as pessoas da tecnologia nuclear por meio de um jogo de cartas. Cada carta é um isótopo radioativo com uso real no dia a dia, e o atributo principal é a **meia-vida**: o tempo que o material leva para perder metade da radioatividade.

> Mobile Application Development · Challenge 2026 · **Entrega da Sprint 1**

## Integrantes

| Nome | RM |
| --- | --- |
| Ryan Mazali | 567168 |
| Renan Lima | 568321 |
| Diego Paulino | 566841 |
| Guilherme Dabul | 559901 |
| Thiago Alexandre | 567486 |

## Empresa parceira

**CTMSP · Centro Tecnológico da Marinha em São Paulo** (Marinha do Brasil), com a AMAZUL.

O desafio: a tecnologia nuclear é pouco compreendida e costuma ser associada só a usinas, bombas e acidentes, embora esteja presente na saúde, na indústria, na agricultura e na pesquisa. O app responde ao Desafio 01 apresentado no kickoff da AMAZUL ("Mitos e verdades sobre tecnologias nucleares"): cada carta traz uma afirmação para o usuário julgar, seguida da explicação e da fonte.

## Descrição da solução

| Tela | O que o usuário faz |
| --- | --- |
| **Início** | Conhece o app e escolhe entre o álbum, o duelo e a calculadora |
| **Álbum** | Navega pelas 13 cartas e filtra por área de aplicação |
| **Detalhe da carta** | Vê meia-vida, número de massa, onde o isótopo é usado e responde ao "Mito ou verdade?" |
| **Duelo** | Recebe uma carta sorteada, escolhe um atributo e disputa contra o computador |
| **Quanto sobra?** | Informa isótopo, quantidade e tempo, e descobre quanto do material ainda resta |

Nesta Sprint os dados são **mockados** (`lib/data/dados.dart`). Os 13 isótopos e as 19 aplicações são os mesmos do modelo de banco de dados do grupo, com os mesmos nomes e valores. A meia-vida de cada isótopo tem fonte citada (NuDat 3.0 / NNDC e National Isotope Development Center).

## Requisitos da Sprint atendidos

- **Navegação entre telas:** `Navigator.push` com `MaterialPageRoute` e `Navigator.pop`. O Álbum envia o isótopo escolhido para a tela de Detalhe pelo construtor (passagem de parâmetro).
- **Protótipo visual:** `Scaffold`, `AppBar`, `Column`, `Row`, `Container`, `Padding`, `SizedBox`, `Card`, `Image`, `Icon`, `ListView` e `GridView`, com cores e estilos centralizados em `lib/tema.dart`.
- **Gerenciamento de estado:** `StatefulWidget` com `setState()` no placar do Duelo, na revelação do "Mito ou verdade?", no filtro do Álbum e no histórico de cálculos.
- **Formulário e validação:** tela "Quanto sobra?" com `Form`, `GlobalKey<FormState>`, `TextFormField`, `DropdownButtonFormField`, validação dos campos e resposta com `SnackBar`.

## Como executar

Pré-requisitos: Flutter instalado e um emulador Android aberto (ou um celular conectado).

```bash
flutter pub get
flutter run
```

## Estrutura do projeto

```
lib/
├── main.dart                     MaterialApp e tema
├── tema.dart                     cores, estilos de texto e componentes padrão
├── models/                       Isotopo, Aplicacao e Simulacao
├── data/dados.dart               os 13 isótopos (dados mockados)
├── utils/formatar.dart           formatação de números e da meia-vida
├── widgets/carta_isotopo.dart    carta reutilizada no álbum e no duelo
└── screens/                      as 5 telas
assets/images/logo.png
```

## Tecnologias utilizadas

- Flutter e Dart
- Material Design 3
- Git e GitHub

## Vídeo de demonstração

[Assistir no YouTube](https://youtu.be/wJDeZ6JjuJ8)
