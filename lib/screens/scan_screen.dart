import 'package:camera/camera.dart';
import 'package:cours_iage/main.dart';
import 'package:cours_iage/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController controller;
  PageController pageController=PageController();
  bool isFlash = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Stack(
        children: [
          PageView(
            controller: pageController,
            //physics: NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  Center(
                      child: AspectRatio(
                          aspectRatio: MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height,
                          child: CameraPreview(controller))),
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.srcOut),
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              backgroundBlendMode: BlendMode.dstOut),
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Icon(
                              CupertinoIcons.clear,
                              color: Colors.white,
                              size: 35,
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!isFlash) {
                                  controller.setFlashMode(FlashMode.torch);
                                } else {
                                  controller.setFlashMode(FlashMode.off);
                                }
                                isFlash=!isFlash;
                              });
                            },
                            child: Icon(
                              isFlash?Icons.flash_on:Icons.flash_off,
                              color: Colors.white,
                              size: 35,
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.white,
                child: Center(child: RotatedBox(quarterTurns:1,child: CardWidget(width: 400,))),
              )
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30),
            child: ToggleSwitch(
              minWidth: 150.0,
              cornerRadius: 20.0,
              activeBgColors: [[Colors.grey], [Colors.white]],
              activeFgColor:Colors.black,
              inactiveFgColor:Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['Scanner un code', 'Ma carte'],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
                pageController.animateToPage(index!, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
              },
            ),
          ),
        ],
      ),
    );
  }
}
