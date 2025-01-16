// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Milad extends StatefulWidget {
  const Milad({super.key});

  @override
  State<Milad> createState() => _MiladState();
}

DateTime? date;

class _MiladState extends State<Milad> {
  getdate() async {
    SharedPreferences sw = await SharedPreferences.getInstance();
    if (date != null) sw.setString("date", date!.toIso8601String());
  }

  @override
  void initState() {
    date = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff816797), actions: [
        Spacer(
          flex: 1,
        ),
        InkWell(
          onTap: () {},
          child: Center(
            child: Text(
              "Gregorian calendar",
              style: TextStyle(fontFamily: 'Do', color: Color(0xffE7F6F2)),
            ),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed("hijry");
          },
          child: Center(
            child: Text(
              "التقويم الهجري",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'foda', color: Color(0xffE7F6F2)),
            ),
          ),
        ),
        Spacer()
      ]),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff2C3333)),
                  )),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(color: Color(0xff395B64)),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffA5C9CA),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                border: Border(),
                boxShadow: [BoxShadow(blurRadius: 10)]),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 300,
            child: SfDateRangePicker(
              selectionColor: Color.fromARGB(255, 0, 43, 87),
              todayHighlightColor: Color(0xff51557E),
              onSubmit: (p0) async {
                if (p0 == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('please select a date'),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  date = p0 as DateTime?;
                  await getdate();
                  Navigator.of(context).pushNamed("ageh");
                  print(date);
                }
              },
              showActionButtons: true,
            ),
          )
        ],
      ),
    );
  }
}

class Model extends ChangeNotifier {
  DateTime? rr = DateTime.now();
  get show => rr;
  change() {
    rr = DateTime.now();
    notifyListeners();
  }
}
