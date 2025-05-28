import 'package:flutter/material.dart';
//test fsdfds
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//sdfsdfs
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controllerName; //this is to read the login
  late TextEditingController _controllerPass; //this is to read the password
  // initializes the var for imagepath, starting with the question mark image
  String _imagePath = 'assets/images/question-mark.png';
  //lololol, I thought i had a directory error, turns out I just forgot the full
  // dir
  void buttonClicked(){
    setState(() {
      //checks password, looked up .text
      if(_controllerPass.text =="QWERTY123"){
        _imagePath = 'assets/images/idea.png';}
      else{
        _imagePath = 'assets/images/stop.png';}
    });

  }

  var isChecked = false;

  @override
  void initState() { //similar to onloaded=
    super.initState();

    _controllerName = TextEditingController(); //making _controller
    _controllerPass = TextEditingController();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPass.dispose();
    super.dispose(); // free the memory of what was typed
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controllerName,
                decoration: InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "Login"
                )),
            TextField(controller: _controllerPass,
                decoration: InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "Password"
                )),

            ElevatedButton( onPressed: buttonClicked, child:  Text("Login")) ,
            SizedBox(height: 20),
            // sets image displayed to _imagepath, the default is the quesiton mark
            Semantics(child: Image.asset(_imagePath, width: 300, height: 300),
                label:"Question Mark"   ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
