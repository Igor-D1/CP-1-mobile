import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contador = 0;

  void decrementador(){
    setState(()=> contador--);
  }
  void incrementador(){
    setState(()=> contador++);
  }
  void limpador(){
    setState(()=> contador = 0);
  }

  bool get isFull => contador == 50;
  bool get quaseCheio => contador >= 40;
  bool get isEmpty => contador == 0;
  bool get minimo => contador >= 10;

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text("Restaurante Mesa Cheia ", style: TextStyle(fontSize:30, color: Colors.white)
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage(isFull ? "assets/images/limite_bg.png" : "assets/images/restaurante_bg.png"),
            fit:BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment:
            MainAxisAlignment.center,
          children: [
            Text(
              isFull ? "" : isEmpty ? "Restaurante está vazio" : quaseCheio ? "Restaurante quase cheio" : "Ainda há vagas",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(contador.toString(),
            style:
            TextStyle(fontSize:100, color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isEmpty ? null : decrementador,
                  style: TextButton.styleFrom(
                    backgroundColor: isEmpty ?Colors.white.withAlpha(90) : Colors.white,
                    fixedSize: Size(141, 55),
                  ),
                  child: Text(
                    isEmpty? "Vazio" : "Saiu",
                    style: TextStyle(fontSize: 16, color: isEmpty? Colors.red : Colors.black),
                  ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: isFull ? null : incrementador,
                    style: TextButton.styleFrom(
                      backgroundColor: isFull? Colors.white.withAlpha(90) : Colors.white,
                      fixedSize: Size(141, 55),
                    ),
                    child: Text(
                      isFull ? "Lotado" : "Entrou",
                      style: TextStyle(fontSize: 16, color: isFull? Colors.red : Colors.black)
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20,height: 24),
                  TextButton(
                    onPressed: minimo ? limpador : null,
                    style: TextButton.styleFrom(
                      backgroundColor: minimo
                          ? Colors.white
                          : Colors.white.withAlpha(90),
                      fixedSize: Size(141, 55),
                    ),
                    child: Text(
                      "Limpar contador",
                      style: TextStyle(fontSize: 16, color: minimo ? Colors.black : Colors.red),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
