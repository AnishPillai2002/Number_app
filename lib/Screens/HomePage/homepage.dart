import 'package:flutter/material.dart';
import 'package:numbers_app/API/apifunctions.dart';

//google fonts
import 'package:google_fonts/google_fonts.dart';

//animated text
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Text Editing Controller
  TextEditingController textController = TextEditingController();
  //Result text
  String resultText = "Enter A Number";

  //Animated Container
  double boxHeight = 100;
  double boxWidth = 300;
  var boxColor = Colors.deepPurple;

  void expand() {
    setState(() {
      boxHeight = 300;
      boxWidth = MediaQuery.of(context).size.width - 40;
    });
  }

  //Function to Handle Runtime errors

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Number Fact App",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Animated Container
            Center(
              child: AnimatedContainer(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: boxColor, borderRadius: BorderRadius.circular(20)),
                duration: const Duration(seconds: 1),
                height: boxHeight,
                width: boxWidth,
                child: Text(
                  resultText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                // child: AnimatedTextKit(animatedTexts: [
                //   TyperAnimatedText(resultText,
                //       textStyle: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 25.0,
                //         fontFamily: 'Canterbury',
                //       ))
                // ]),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            //TextField
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: textController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),

            //button
            ElevatedButton(
                onPressed: () async {
                  int number = int.parse(textController.text);
                  final result = await getNumberFact(num: number);
                  setState(() {
                    resultText = (result != null)
                        ? result
                        : "No Data Found,\nPlease Type Another Number";
                    print(resultText);
                    expand();
                  });
                },
                child: const Text("Get Fact"))
          ]),
        ),
      ),
    );
  }
}
