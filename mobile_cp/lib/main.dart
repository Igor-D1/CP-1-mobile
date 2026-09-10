import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restaurante Mesa Cheia",
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
  bool image = false; // Controle de visibilidade da imagem do botão

  void decrementador() {
    setState(() => contador--);
  }

  void incrementador() {
    setState(() => contador++);
  }

  void limpador() {
    setState(() => contador = 0);
  }

  void secreto() {
    setState(() => image = !image);
  }
  bool get isFull => contador == 50;
  bool get quaseCheio => contador >= 40;
  bool get isEmpty => contador == 0;
  bool get minimo => contador >= 10;

  String getBackgroundImage(bool isWideScreen, bool isFull) {
    if (isWideScreen) {
      return isFull
          ? "assets/images/limite_desktop_bg.png"
          : "assets/images/restaurante_desktop_bg.png";
    } else {
      return isFull
          ? "assets/images/limite_mobile_bg.png"
          : "assets/images/restaurante_mobile_bg.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;
    final String imagePath = getBackgroundImage(isWideScreen, isFull);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurante Mesa Cheia",
          style: GoogleFonts.eater(
            fontSize: isWideScreen ? 35 : 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(100),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isFull ? "" : isEmpty ? "Restaurante está vazio" : quaseCheio ? "Restaurante quase cheio" : "Ainda há vagas",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      contador.toString(),
                      style: TextStyle(fontSize: 100, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tooltip(
                          message: "Diminuir contador -1",
                          child: TextButton(
                            onPressed: isEmpty ? null : decrementador,
                            style: TextButton.styleFrom(
                              backgroundColor: isEmpty
                                  ? Colors.white.withAlpha(70)
                                  : Colors.white,
                              fixedSize: Size(141, 55),
                            ),
                            child: Text(
                              isEmpty ? "Vazio" : "Saiu",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: isEmpty ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        Tooltip(
                          message: "Aumentar contador +1",
                          child: TextButton(
                            onPressed: isFull ? null : incrementador,
                            style: TextButton.styleFrom(
                              backgroundColor: isFull
                                  ? Colors.white.withAlpha(70)
                                  : Colors.white,
                              fixedSize: Size(141, 55),
                            ),
                            child: Text(
                              isFull ? "Lotado" : "Entrou",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: isFull ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                        )
                        
                      ],
                    ),
                    const SizedBox(height: 24),
                    Tooltip(
                      message: "Voltar o contador ao 0",
                      child: TextButton(
                      onPressed: minimo ? limpador : null,
                      style: TextButton.styleFrom(
                        backgroundColor: minimo
                            ? Colors.white
                            : Colors.white.withAlpha(70),
                        fixedSize: Size(141, 55),
                      ),
                      child: Text(
                        "Limpar contador",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: minimo ? Colors.black : Colors.red,
                        ),
                      ),
                    ),
                    )
                    
                  ],
                ),
              ),
            ),

            Positioned(
              left: 10,
              bottom: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton.small(
                    onPressed: secreto,
                    tooltip: "Secreto",
                    child: Icon(
                      image ? Icons.close : Icons.help_outline,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Imagem exibida ao lado do botão quando pressionado
                  if (image)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/icon/Dodo_prova.png', // Ajuste para a sua imagem
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}