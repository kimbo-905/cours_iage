import 'package:cours_iage/models/option.dart';
import 'package:cours_iage/models/transaction.dart';
import 'package:cours_iage/screens/scan_screen.dart';
import 'package:cours_iage/screens/settings_screen.dart';
import 'package:cours_iage/utils/constants.dart';
import 'package:cours_iage/widgets/card_widget.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:custom_qr_generator/qr_painter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;
  List<Option> optionList = [
    Option(Icons.person, "Transfert", Colors.deepPurple),
    Option(Icons.shopping_cart, "Paiement", Colors.orangeAccent),
    Option(Icons.phone_android, "Credit", Colors.blueAccent),
    Option(Icons.account_balance_outlined, "Bank", Colors.red),
    Option(Icons.card_giftcard, "Cadeau", Colors.green),
  ];

  List<Transaction> transactionList = [
    Transaction("Modou", "777777777", 10000, DateTime.now(), true),
    Transaction("Sidy", "771234567", 5000, DateTime.now(), false),
    Transaction("Modou", "777777777", 10000, DateTime.now(), true),
    Transaction("Sidy", "771234567", 5000, DateTime.now(), false),
    Transaction("Modou", "777777777", 10000, DateTime.now(), true),
    Transaction("Sidy", "771234567", 5000, DateTime.now(), false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingScreen();
                    },
                  ),
                  (route) => false,
                );
              },
            ),
            expandedHeight: 90,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isVisible
                      ? RichText(
                          text: const TextSpan(
                              text: "5.000",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                              children: [
                                TextSpan(
                                  text: "F",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ]),
                        )
                      : const Text(
                          "•••••••••",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Icon(
                        isVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                        size: 25,
                      )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              child: Stack(
                children: [
                  Container(
                    color: primaryColor,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45))),
                    margin: const EdgeInsets.only(top: 100),
                  ),
                  Column(
                    children: [
                      const CardWidget(
                        width: 300,
                      ),
                      GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        shrinkWrap: true,
                        itemCount: optionList.length,
                        itemBuilder: (context, index) {
                          return optionWidget(optionList[index]);
                        },
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.grey.withOpacity(.3),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: transactionList.length,
                        itemBuilder: (context, index) {
                          Transaction t = transactionList[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${t.isSend ? "A" : "De"} ${t.name} ${t.phoneNumber}",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "${t.isSend ? "-" : ""} ${t.montant}F",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                Text("${t.dateTime}",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(.3),
                            borderRadius: BorderRadius.circular(45)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.blueAccent,
                            ),
                            Text(
                              "Rechercher",
                              style: TextStyle(color: Colors.blueAccent),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  appBarWidget() {
    return AppBar(
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () {
          print("test");
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "5.000F",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          IconButton(
            icon: const Icon(
              Icons.visibility,
              color: Colors.white,
            ),
            onPressed: () {
              print("test");
            },
          ),
        ],
      ),
    );
  }

  optionWidget(Option option) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: option.color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(45)),
          padding: const EdgeInsets.all(8),
          child: Icon(
            option.icon,
            size: 35,
            color: option.color,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(option.text)
      ],
    );
  }
}
