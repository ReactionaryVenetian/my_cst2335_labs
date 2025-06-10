import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profilepage.dart';// interesting, you gotta actually import it

void main() {
  runApp(const MyApp());
}
// Load and obtain the shared preferences for this app.
void functionName() async {
  final prefs = await SharedPreferences.getInstance();

  // Example: Saving a value
  prefs.setString("_controllerName", "User123");

  // Example: Retrieving a value
  String? storedLogin = prefs.getString("_controllerPass");
  print("Stored Login: $storedLogin");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Browse Categories',
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
        _imagePath = 'assets/images/idea.png';
        showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Would you like to save your login and password?'),

          actions: <Widget>[
            TextButton(
              onPressed: () {
                // need to readup on this, apparently saved to a local file so
                // I'll need admin permission?
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString("LoginName", _controllerName.text);
                  prefs.setString("Password", _controllerPass.text);
                });

                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(loginName: _controllerName.text)),
                );

              },

              child: Text("Save"),
            ),

            TextButton(
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                 prefs.remove("LoginName"); // removes saved data
                 prefs.remove("Password"); // removes saved data
                });
                Navigator.of(context).pop(); // closes box
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(loginName: _controllerName.text)),
                );
              },

              child: Text("Don't save"),
            ),
          ],

        ),
      );}
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

    SharedPreferences.getInstance().then((prefs) {
      String? savedLogin = prefs.getString("LoginName"); // setString saves data
      String? savedPass = prefs.getString("Password"); // here saved pass is
      // assigned to the string savedPass

      if (savedLogin != null && savedPass != null) { //checks if pass is saved
        _controllerName.text = savedLogin; // populates fields
        _controllerPass.text = savedPass; // populates fields

        ScaffoldMessenger.of(context).showSnackBar( // displays allah-snackbar!
          SnackBar(content: Text("Saved login details autocompleted")),
        );
      }
    });

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

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
