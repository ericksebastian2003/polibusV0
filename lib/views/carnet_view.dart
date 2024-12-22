import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CarnetView extends StatelessWidget {
  const CarnetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi carnet"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Nombre del estudiante
            const Text(
              "Erick Caiza",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BarcodeWidget(
              barcode: Barcode.qrCode(), // Tipo de código de barras
              data: 'Erick Sebastian Caiza Quishpe - 1752259455',
              width: 200,
              height: 200,
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            //Semestre
            const Text(
              "Erick Caiza",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
