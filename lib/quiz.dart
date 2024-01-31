import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool? isCorrect;
  double altura = 400;
  var cor = Colors.deepPurple[50];
  var fontColor = Colors.black;
  String titleText = "Quiz marítimo!";

  final List<Map<String, dynamic>> questions = [

{
'question': 'Qual é a extensão aproximada do Oceano Atlântico?',
'answers': ['10 milhões de quilômetros quadrados', '50 milhões de quilômetros quadrados', '100 milhões de quilômetros quadrados', '200 milhões de quilômetros quadrados'],
'correctAnswer': '200 milhões de quilômetros quadrados'
},
{
'question': 'Quanto tempo leva a luz do sol para alcançar as partes mais profundas do oceano?',
'answers': ['1 hora', '1 dia', '1 semana', '1 mês'],
'correctAnswer': '1 hora'
},
{
'question': 'Qual é a temperatura média da água do mar?',
'answers': ['-2 graus Celsius', '10 graus Celsius', '25 graus Celsius', '40 graus Celsius'],
'correctAnswer': '25 graus Celsius'
},
{
'question': 'Qual é o ponto mais profundo dos oceanos conhecido até agora?',
'answers': ['Fossa das Marianas', 'Fossa de Porto Rico', 'Fossa de Sunda', 'Fossa de Trench'],
'correctAnswer': 'Fossa das Marianas'
},
{
'question': 'O que causa as marés nos oceanos?',
'answers': ['A influência dos ventos', 'A atração gravitacional da Lua e do Sol', 'A atividade sísmica no fundo do oceano', 'A temperatura da água'],
'correctAnswer': 'A atração gravitacional da Lua e do Sol'
}
  ];
 

  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == questions[currentQuestionIndex]['correctAnswer'];
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        selectedAnswer = null;
        isCorrect = null;
        if (currentQuestionIndex < questions.length - 1){
          currentQuestionIndex++;
        } else {
          altura = 1000;
          cor = Colors.green;
          fontColor = Colors.green;
          titleText = "Quiz Finalizado!!!";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: cor,
          title: Text(titleText,
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            color: cor,
            width: double.infinity,
            height: altura,
            child: Center(
              child: Text(
                currentQuestion['question'],
                style: GoogleFonts.roboto(color: fontColor ,fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Wrap(
            children: currentQuestion['answers']
                .map<Widget>((resposta) {
                  bool isSelected = selectedAnswer == resposta;
                  Color? buttonColor;
                  if (isSelected) {
                    buttonColor = isCorrect! ? Colors.green : Colors.red;
                  }

                  return meuBtn(
                    resposta, () => handleAnswer(resposta), buttonColor);
                  }).toList(),
          ),
        ],
      ),
    );
  }
}

Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) => Container(
      margin: const EdgeInsets.all(16),
      width: 160,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(resposta),
      ),
    );
