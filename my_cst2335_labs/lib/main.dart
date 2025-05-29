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
      debugShowCheckedModeBanner: false,
      title: 'Browse Categories',
      home: const MyHomePage(title: ''),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child:
    Padding(
    padding: EdgeInsets.only(top: 20, left: 20,right: 20),  // Adjust 20px as needed
    child:
    Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'BROWSE CATEGORIES',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
                "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Arial',
                  color: Colors.black,
                ),
              ),
            Text(
              'BY MEAT',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [ CircleAvatar( // looking back on this, reading the
                    // entire instructions before starting is helpful
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/beef.jpg'),
                    child: const Text(
                      'BEEF',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                CircleAvatar( // looking back on this, reading the
                  // entire instructions before starting is helpful
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/chicken.jpg'),
                  child: const Text(
                    'CHICKEN',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                ),
                CircleAvatar( // looking back on this, reading the
                  // entire instructions before starting is helpful
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/pork.jpg'),
                  child: const Text(
                    'PORK',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                ),
                CircleAvatar( // looking back on this, reading the
                  // entire instructions before starting is helpful
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/seafood.jpg'),
                  child: const Text(
                    'SEAFOOD',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                ),

              ]
            ),
            Text(
              'BY COURSE',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          'assets/images/maindish.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Main Dishes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/Salad.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Salad Recipes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/sidedish.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Side Dishes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/crockpot.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Crockpot',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                ]
            ),
            Text(
              'BY DESSERT',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          'assets/images/icecream.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Ice Cream',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        ),
                    ),
                  ],
                ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/Brownies.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Brownies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/Pie.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Pies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/cookies.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Cookies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                ]
            ),
          ],
        ),
    ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
