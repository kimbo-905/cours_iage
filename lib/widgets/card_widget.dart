import 'package:cours_iage/screens/scan_screen.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final double? width;
  const CardWidget({super.key, this.width});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ScanScreen();
        },));
      },
      child: Container(
        height: 220,
        width: widget.width??200,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: const AssetImage("assets/images/bg_card.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.blue.shade200.withOpacity(0.5), BlendMode.srcIn))),
        child: Center(
          child: Container(
            height: 180,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: QrPainter(
                    data: "Welcome to Isi",
                    options: const QrOptions(),
                  ),
                  size: const Size(150, 150),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera),
                    SizedBox(
                      width: 3,
                    ),
                    Text("Scanner")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
