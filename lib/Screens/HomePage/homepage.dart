import 'package:flutter/material.dart';
import 'package:numbers_app/API/apifunctions.dart';

//google fonts
import 'package:google_fonts/google_fonts.dart';

//animated text
import 'package:animated_text_kit/animated_text_kit.dart';

//checking for internet connectivity
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Text Editing Controller
  TextEditingController textController = TextEditingController();
  //Result text
  String? resultText = "Enter A Number";

  //Animated Container
  double boxHeight = 100;
  double boxWidth = 300;
  var boxColor = Colors.deepPurple;

  //Function to expand the Container
  void expand() {
    setState(() {
      boxHeight = 300;
      boxWidth = MediaQuery.of(context).size.width - 40;
    });
  }

  //Function to change the Container color
  void changeBoxColor(value) {
    setState(() {
      boxColor = value;
    });
  }

  //Function to check connectivity
  Future<bool> _checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

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
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 40,
            ),

            //Animated Container

            AnimatedContainer(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(20)),
              duration: const Duration(seconds: 1),
              alignment: const Alignment(0, 0),
              height: boxHeight,
              width: boxWidth,
              child: Text(
                resultText!,
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
            const SizedBox(
              height: 40,
            ),
            //TextField
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: textController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //button
            ElevatedButton(
                onPressed: () async {
                  //Checking for Connectivity
                  if (await _checkInternetConnectivity() == false) {
                    setState(() {
                      resultText = "No Internet Connectivity";
                      changeBoxColor(Colors.pink);
                      expand();
                    });
                  } else if (textController.text.isEmpty) {
                    setState(() {
                      changeBoxColor(Colors.deepPurple);
                      resultText = "Please Enter a Number";

                      expand();
                    });
                  } else if (textController.text.contains(".")) {
                    setState(() {
                      resultText = "Please Enter Integers Only";
                      changeBoxColor(Colors.deepPurple);
                      expand();
                    });
                  } else {
                    int number = int.parse(textController.text);
                    final result = await getNumberFact(num: number);

                    setState(() {
                      resultText = result;
                      changeBoxColor(Colors.deepPurple);
                      expand();
                    });
                  }

                  // setState(() {
                  //   resultText = (result != null)
                  //       ? result
                  //       : "No Data Found,\nPlease Type Another Number";
                  //   print(resultText);
                  //   expand();
                  // });
                },
                child: const Text("Get Fact"))
          ]),
        ),
      ),
    );
  }
}
