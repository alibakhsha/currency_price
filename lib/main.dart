import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:intl/intl.dart' as intl;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/Currency.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fa'), // Farsi
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'iransans',
            textTheme: const TextTheme(
                headlineLarge: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                bodyMedium: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
                headlineMedium: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
                titleSmall: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w700),
                titleMedium: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w700))),
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext cntx) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";

    var value = await http.get(Uri.parse(url));

    // developer.log(value.body, name: "main");
    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _ShowSnackBar(context, "بروزرسانی اطلاعات با موفقیت انجام شد");
        // developer.log(value.body, name: "getResponse",error: convert.jsonDecode(value.body));
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/icon.png"),
            ),
            const SizedBox(
              width: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "قیمت به روز ارز",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset("assets/images/2976215.png"))),
            const SizedBox(width: 16),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/752675.png"),
                    const SizedBox(
                      width: 8,
                    ),
                    Text("نرخ ارز آزاد چیست؟ ",
                        style: Theme.of(context).textTheme.headlineLarge)
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  " نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textDirection: TextDirection.rtl,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                  child: Container(
                    width: double.infinity,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 130, 130, 130),
                        borderRadius: BorderRadius.all(Radius.circular(1000))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "نام آزاد ارز",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text("قیمت",
                            style: Theme.of(context).textTheme.headlineMedium),
                        Text("تغییر",
                            style: Theme.of(context).textTheme.headlineMedium)
                      ],
                    ),
                  ),
                ),
                //List
                SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/2,
                    child: listFutureBuilder(context)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/16,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 232, 232, 232),
                        borderRadius: BorderRadius.circular(1000)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/16,
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 202, 193, 255)),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1000)))),
                              onPressed: () {
                                currency.clear();
                                listFutureBuilder(context);
                              },
                              icon: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Icon(
                                  CupertinoIcons.refresh_bold,
                                  color: Colors.black,
                                ),
                              ),
                              label: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  "بروزرسانی",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              )),
                        ),
                        Text("آخرین بروزرسانی  ${_getTime()}"),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: MyItem(postion, currency),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
      },
      future: getResponse(context),
    );
  }

  String _getTime() {
    DateTime now = DateTime.now();
    return intl.DateFormat("kk:mm:ss").format(now);
  }
}

void _ShowSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    backgroundColor: Colors.green,
  ));
}

class MyItem extends StatelessWidget {
  int postion;
  List<Currency> currency;

  MyItem(this.postion, this.currency, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(blurRadius: 1.0, color: Colors.grey)
      ], color: Colors.white, borderRadius: BorderRadius.circular(1000)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[postion].title!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            getFarsiNumber(currency[postion].price.toString()),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            getFarsiNumber(currency[postion].changes.toString()),
            style: currency[postion].status == "n"
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

String getFarsiNumber(String number) {
  const en = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  const fa = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"];

  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}
