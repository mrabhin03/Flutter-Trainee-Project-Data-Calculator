import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo,
        fontFamily: 'Poppins',
      ),
      home: TheHome(),
    );
  }
}

class TheHome extends StatefulWidget {
  const TheHome({super.key});

  @override
  State<TheHome> createState() => _TheHomeState();
}

class _TheHomeState extends State<TheHome> {
  bool isDarkMode = false;
  final TextEditingController Speed_input_value = TextEditingController();
  final TextEditingController Total_input_value = TextEditingController();
  final TextEditingController Download_value = TextEditingController();
  final TextEditingController Total_data = TextEditingController();

  List<String> DataList1 = ['KB', 'MB', 'GB', 'TB'];
  List<String> DataList2 = ['B/s', 'KB/s', 'MB/s', 'GB/s'];
  List<String> DataList3 = ['%', 'KB', 'MB', 'GB', 'TB'];
  String? Speed = 'MB/s', Total = 'MB', Download = "%", Total_d = 'GB';
  late Timer _timer;
  String TimeNow = '', DateNow = '';
  int result1 = 0, result2 = 0, page = 0;
  var main_theme, secondary_theme, text_theme;

  int isLoaded = 0;
  String? out_speed,
      out_Total_data,
      Time_taken,
      Time_finish,
      Total_val,
      Downloaded,
      Percentage,
      Data;

  @override
  void initState() {
    super.initState();
    TimeNow = _formatCurrentTime();
    var now = DateTime.now();
    DateNow = DateFormat('MMM dd, yyyy').format(now);
    _startTimer();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        isLoaded = 1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final currentTime = _formatCurrentTime();
      if (TimeNow != currentTime) {
        setState(() {
          TimeNow = currentTime;
          var now = DateTime.now();
          DateNow = DateFormat('MMM dd, yyyy').format(now);
        });
      }
    });
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void page_change(int Pager) {
    setState(() {
      page = Pager;
    });
  }

  @override
  Widget build(BuildContext context) {
    var arr = <FontWeight>[];
    var size = [];
    if (page == 0) {
      arr.add(FontWeight.w700);
      size.add(16.0);
      arr.add(FontWeight.w500);
      size.add(15.0);
      main_theme = Color.fromRGBO(11, 55, 84, 1);
      secondary_theme = Color.fromRGBO(11, 75, 117, 1);
      text_theme = isDarkMode ? Colors.white : Color.fromRGBO(0, 0, 0, 1);
    } else {
      arr.add(FontWeight.w500);
      size.add(15.0);
      arr.add(FontWeight.w700);
      size.add(16.0);
      main_theme = Color.fromRGBO(7, 82, 29, 1);
      secondary_theme = Color.fromRGBO(5, 102, 8, 1);
      text_theme = isDarkMode ? Colors.white : Color.fromRGBO(0, 0, 0, 1);
    }

    return Scaffold(
      backgroundColor: main_theme,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 165,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        child: Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        TimeNow,
                        style: TextStyle(
                          fontSize: 90,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.5, 1.5),
                              blurRadius: .0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 102,
                        child: Text(
                          DateNow,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final offsetAnimation = Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    );
                  },
                  child: (isLoaded == 1)
                      ? Container(
                          height: 648,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32))),
                          child: Container(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(36, 0, 0, 0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: TextButton(
                                            onPressed: () {
                                              page_change(0);
                                            },
                                            child: Text(
                                              "Time Calculation",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size[0],
                                                  fontWeight: arr[0]),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(36, 0, 0, 0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: TextButton(
                                            onPressed: () {
                                              page_change(1);
                                            },
                                            child: Text("Data Remaining",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: size[1],
                                                    fontWeight: arr[1])),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? Color.fromRGBO(23, 23, 23, 0.574)
                                            : Color.fromRGBO(
                                                235, 235, 235, 0.85),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(32),
                                            topRight: Radius.circular(32))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 200),
                                          transitionBuilder: (Widget child,
                                              Animation<double> animation) {
                                            return LayoutBuilder(
                                              builder: (context, constraints) {
                                                final isNewChild = child.key ==
                                                    ValueKey('Green');
                                                final offsetAnimation =
                                                    Tween<Offset>(
                                                  begin: isNewChild
                                                      ? Offset(1.1, 0)
                                                      : Offset(-1.1, 0),
                                                  end: isNewChild
                                                      ? Offset.zero
                                                      : Offset.zero,
                                                ).animate(animation);

                                                return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child,
                                                );
                                              },
                                            );
                                          },
                                          child: (page == 0)
                                              ? Column(
                                                  key: ValueKey('Blue'),
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Internet Speed",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: text_theme,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          border: Border.all(
                                                              color: main_theme,
                                                              width: 5),
                                                          color:
                                                              secondary_theme),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                left: 15,
                                                                right: 5,
                                                                bottom: 5),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    TextFormField(
                                                              cursorColor:
                                                                  Colors.white,
                                                              cursorWidth: 2,
                                                              controller:
                                                                  Speed_input_value,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      'Example: 3',
                                                                  hintStyle: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          183,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontSize:
                                                                          20),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )),
                                                            DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton(
                                                                      iconEnabledColor:
                                                                          Colors
                                                                              .white,
                                                                      value:
                                                                          Speed,
                                                                      dropdownColor:
                                                                          main_theme,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              21,
                                                                          fontWeight: FontWeight
                                                                              .w600),
                                                                      items: DataList2.map((String
                                                                              value) {
                                                                        return DropdownMenuItem<String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                Text(value));
                                                                      })
                                                                          .toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          Speed =
                                                                              newValue;
                                                                        });
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "Total Data needed",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: text_theme,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          border: Border.all(
                                                              color: main_theme,
                                                              width: 5),
                                                          color:
                                                              secondary_theme),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                left: 15,
                                                                right: 5,
                                                                bottom: 5),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    TextFormField(
                                                              cursorColor:
                                                                  Colors.white,
                                                              cursorWidth: 2,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  Total_input_value,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      'Example: 7.3',
                                                                  hintStyle: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          183,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontSize:
                                                                          20),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )),
                                                            DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton(
                                                                      iconEnabledColor:
                                                                          Colors
                                                                              .white,
                                                                      value:
                                                                          Total,
                                                                      dropdownColor:
                                                                          main_theme,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              21,
                                                                          fontWeight: FontWeight
                                                                              .w600),
                                                                      items: DataList1.map((String
                                                                              value) {
                                                                        return DropdownMenuItem<String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                Text(value));
                                                                      })
                                                                          .toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          Total =
                                                                              newValue;
                                                                        });
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    SizedBox(
                                                        width: double.infinity,
                                                        height: 60,
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                if (Speed_input_value
                                                                            .text !=
                                                                        '' &&
                                                                    Total_input_value
                                                                            .text !=
                                                                        '') {
                                                                  List<String>?
                                                                      parts =
                                                                      Speed?.split(
                                                                          '/');

                                                                  var speedinbyte = Tobyte(
                                                                      Speed_input_value
                                                                          .text,
                                                                      parts
                                                                          ?.first);

                                                                  var totalinbyte = Tobyte(
                                                                      Total_input_value
                                                                          .text,
                                                                      Total);
                                                                  double
                                                                      Timetakes;
                                                                  if (totalinbyte >
                                                                      speedinbyte) {
                                                                    Timetakes =
                                                                        totalinbyte /
                                                                            speedinbyte;
                                                                  } else {
                                                                    Timetakes =
                                                                        1;
                                                                  }
                                                                  out_speed =
                                                                      DataLength(
                                                                          speedinbyte);
                                                                  out_speed =
                                                                      '$out_speed/s';

                                                                  out_Total_data =
                                                                      DataLength(
                                                                          totalinbyte);

                                                                  Time_taken =
                                                                      TimeTaken(
                                                                          Timetakes);
                                                                  Time_finish =
                                                                      AddDate(
                                                                          Timetakes);
                                                                  if (Time_taken ==
                                                                      "More than 200 Years") {
                                                                    Time_finish =
                                                                        "More than 200 Years";
                                                                  }

                                                                  result1 = 1;
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                } else {
                                                                  if (int.parse(
                                                                          Speed_input_value
                                                                              .text) ==
                                                                      404) {
                                                                    isDarkMode =
                                                                        !isDarkMode;
                                                                  }
                                                                }
                                                              });
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  main_theme,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "Calculate",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: isDarkMode
                                                              ? Color.fromARGB(
                                                                  210,
                                                                  28,
                                                                  28,
                                                                  28)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  224,
                                                                  224,
                                                                  224),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              AnimatedSwitcher(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  transitionBuilder: (Widget
                                                                          child,
                                                                      Animation<
                                                                              double>
                                                                          animation) {
                                                                    final fadeInAnimation = Tween<double>(
                                                                            begin:
                                                                                0.0,
                                                                            end:
                                                                                1.0)
                                                                        .animate(
                                                                      CurvedAnimation(
                                                                        parent:
                                                                            animation,
                                                                        curve: Interval(
                                                                            0.5,
                                                                            1.0),
                                                                      ),
                                                                    );

                                                                    return AnimatedBuilder(
                                                                      animation:
                                                                          animation,
                                                                      builder:
                                                                          (context,
                                                                              child) {
                                                                        return Stack(
                                                                          children: [
                                                                            Opacity(
                                                                              opacity: fadeInAnimation.value,
                                                                              child: child,
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                      child:
                                                                          child,
                                                                    );
                                                                  },
                                                                  child: result1 ==
                                                                          1
                                                                      ? Generated_result1(
                                                                          out_speed,
                                                                          out_Total_data,
                                                                          Time_taken,
                                                                          Time_finish,
                                                                          isDarkMode)
                                                                      : Center(
                                                                          child:
                                                                              Text(
                                                                            "Generate Result",
                                                                            style: TextStyle(
                                                                                fontSize: 35,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: isDarkMode ? Color.fromRGBO(255, 255, 255, 0.843) : Colors.black),
                                                                          ),
                                                                        ))),
                                                    )),
                                                  ],
                                                )
                                              //Page2
                                              : Container(
                                                  key: ValueKey('Green'),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Downloaded Value",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: text_theme,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            border: Border.all(
                                                                color:
                                                                    main_theme,
                                                                width: 5),
                                                            color:
                                                                secondary_theme),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  left: 15,
                                                                  right: 5,
                                                                  bottom: 5),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                cursorColor:
                                                                    Colors
                                                                        .white,
                                                                cursorWidth: 2,
                                                                controller:
                                                                    Download_value,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: InputDecoration(
                                                                    hintText:
                                                                        'Example: 50',
                                                                    hintStyle: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            183,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        fontSize:
                                                                            20),
                                                                    border:
                                                                        InputBorder
                                                                            .none),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )),
                                                              DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton(
                                                                        iconEnabledColor:
                                                                            Colors
                                                                                .white,
                                                                        value:
                                                                            Download,
                                                                        dropdownColor:
                                                                            main_theme,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                21,
                                                                            fontWeight: FontWeight
                                                                                .w600),
                                                                        items: DataList3.map((String
                                                                            value) {
                                                                          return DropdownMenuItem<String>(
                                                                              value: value,
                                                                              child: Text(value));
                                                                        }).toList(),
                                                                        onChanged: (String? newValue) {
                                                                          setState(
                                                                              () {
                                                                            Download =
                                                                                newValue;
                                                                          });
                                                                        }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "Total Data",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: text_theme,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            border: Border.all(
                                                                color:
                                                                    main_theme,
                                                                width: 5),
                                                            color:
                                                                secondary_theme),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  left: 15,
                                                                  right: 5,
                                                                  bottom: 5),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                cursorColor:
                                                                    Colors
                                                                        .white,
                                                                cursorWidth: 3,
                                                                cursorRadius:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                controller:
                                                                    Total_data,
                                                                decoration: InputDecoration(
                                                                    hintText:
                                                                        'Example: 2.15',
                                                                    hintStyle: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            183,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        fontSize:
                                                                            20),
                                                                    border:
                                                                        InputBorder
                                                                            .none),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )),
                                                              DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton(
                                                                        iconEnabledColor:
                                                                            Colors
                                                                                .white,
                                                                        value:
                                                                            Total_d,
                                                                        dropdownColor:
                                                                            main_theme,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                21,
                                                                            fontWeight: FontWeight
                                                                                .w600),
                                                                        items: DataList1.map((String
                                                                            value) {
                                                                          return DropdownMenuItem<String>(
                                                                              value: value,
                                                                              child: Text(value));
                                                                        }).toList(),
                                                                        onChanged: (String? newValue) {
                                                                          setState(
                                                                              () {
                                                                            Total_d =
                                                                                newValue;
                                                                          });
                                                                        }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (Download_value
                                                                              .text !=
                                                                          '' &&
                                                                      Total_data
                                                                              .text !=
                                                                          '') {
                                                                    var totalinbyte1 = Tobyte(
                                                                        Total_data
                                                                            .text,
                                                                        Total_d);
                                                                    double
                                                                        downloadinbyte =
                                                                        0;
                                                                    if (Download ==
                                                                        '%') {
                                                                      double
                                                                          download_val =
                                                                          double.parse(
                                                                              Download_value.text);
                                                                      if (download_val <=
                                                                          100) {
                                                                        downloadinbyte =
                                                                            (totalinbyte1 / 100) *
                                                                                download_val;
                                                                      } else {
                                                                        downloadinbyte =
                                                                            (totalinbyte1 / 100) *
                                                                                100;
                                                                      }
                                                                    } else {
                                                                      downloadinbyte = Tobyte(
                                                                          Download_value
                                                                              .text,
                                                                          Download);
                                                                    }
                                                                    double out;
                                                                    if (downloadinbyte <
                                                                        totalinbyte1) {
                                                                      out = totalinbyte1 -
                                                                          downloadinbyte;
                                                                    } else {
                                                                      out =
                                                                          totalinbyte1;
                                                                    }
                                                                    Total_val =
                                                                        DataLength(
                                                                            totalinbyte1);
                                                                    Downloaded =
                                                                        DataLength(
                                                                            downloadinbyte);
                                                                    double val =
                                                                        (100 / totalinbyte1) *
                                                                            out;
                                                                    Percentage =
                                                                        "${val.toStringAsFixed(1)}%";
                                                                    Data =
                                                                        DataLength(
                                                                            out);
                                                                    result2 = 1;
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                  } else {
                                                                    print(
                                                                        "Empty");
                                                                  }
                                                                });
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    main_theme,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                "Calculate",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ))),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            color: isDarkMode
                                                                ? Color
                                                                    .fromARGB(
                                                                        210,
                                                                        28,
                                                                        28,
                                                                        28)
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        224,
                                                                        224,
                                                                        224),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                AnimatedSwitcher(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    transitionBuilder: (Widget
                                                                            child,
                                                                        Animation<double>
                                                                            animation) {
                                                                      final fadeInAnimation = Tween<double>(
                                                                              begin: 0.0,
                                                                              end: 1.0)
                                                                          .animate(
                                                                        CurvedAnimation(
                                                                          parent:
                                                                              animation,
                                                                          curve: Interval(
                                                                              0.5,
                                                                              1.0),
                                                                        ),
                                                                      );

                                                                      return AnimatedBuilder(
                                                                        animation:
                                                                            animation,
                                                                        builder:
                                                                            (context,
                                                                                child) {
                                                                          return Stack(
                                                                            children: [
                                                                              Opacity(
                                                                                opacity: fadeInAnimation.value,
                                                                                child: child,
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                        child:
                                                                            child,
                                                                      );
                                                                    },
                                                                    child: result2 ==
                                                                            1
                                                                        ? Generated_result2(
                                                                            Total_val,
                                                                            Downloaded,
                                                                            Percentage,
                                                                            Data,
                                                                            isDarkMode)
                                                                        : Center(
                                                                            child:
                                                                                Text(
                                                                              "Generate Result",
                                                                              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: isDarkMode ? Color.fromRGBO(255, 255, 255, 0.843) : Colors.black),
                                                                            ),
                                                                          ))),
                                                      )),
                                                    ],
                                                  ),
                                                )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column()),
            ],
          ),
        )),
      ),
    );
  }
}

Widget Generated_result1(Speed, Total, Time_takes, Time_finish, isDarkMode) {
  return Column(
    children: [
      Text(
        "Generated Result",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: isDarkMode
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromARGB(255, 30, 30, 30)),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Speed:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 0.95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            Speed,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Total Data:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            Total,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Approximate time will take:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            Time_takes,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Approximate time of finish:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            Time_finish,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
    ],
  );
}

Widget Generated_result2(Total, Downloaded, Percentage, Data, isDarkMode) {
  return Column(
    children: [
      Text(
        "Generated Result",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: isDarkMode
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromARGB(255, 30, 30, 30)),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Total Data:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            Total,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Downloaded value:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            Downloaded,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Balance in percentage:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            Percentage,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            "Balance data:",
            style: TextStyle(
                fontSize: 20,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, .95)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            Data,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromARGB(255, 30, 30, 30)),
          ),
        ],
      ),
    ],
  );
}

double Tobyte(Data, Type) {
  double byte = double.parse(Data);
  switch (Type) {
    case 'KB':
      byte *= 1024;
      break;
    case 'MB':
      byte *= 1024 * 1024;
      break;
    case 'GB':
      byte *= 1024 * 1024 * 1024;
      break;
    case 'TB':
      byte *= 1024 * 1024 * 1024 * 1024;
      break;
  }
  return byte;
}

String TimeTaken(double totalSeconds) {
  int totalSecondsInt = totalSeconds.toInt();

  int years = totalSecondsInt ~/ (365.25 * 24 * 3600).toInt();
  int remainingSecondsAfterYears =
      totalSecondsInt % (365.25 * 24 * 3600).toInt();
  int months = remainingSecondsAfterYears ~/ (30.44 * 24 * 3600).toInt();
  int remainingSecondsAfterMonths =
      remainingSecondsAfterYears % (30.44 * 24 * 3600).toInt();
  int days = remainingSecondsAfterMonths ~/ (24 * 3600);
  int remainingSecondsAfterDays = remainingSecondsAfterMonths % (24 * 3600);
  int hours = remainingSecondsAfterDays ~/ 3600;
  int remainingSecondsAfterHours = remainingSecondsAfterDays % 3600;
  int minutes = remainingSecondsAfterHours ~/ 60;
  int seconds = remainingSecondsAfterHours % 60;

  String result = '';
  if (years > 0) result += '${years}Year ';
  if (years > 150) {
    return "More than 200 Years";
  }
  if (months > 0) result += '${months}Mon ';
  if (days > 0) result += '${days}d ';
  if (hours > 0) result += '${hours}h ';
  if (minutes > 0) result += '${minutes}m ';
  if (seconds > 0) result += '${seconds}s';

  return result.trim();
}

String AddDate(double Seconds) {
  int secondsToAdd = Seconds.toInt();
  DateTime now = DateTime.now();
  DateTime futureTime = now.add(Duration(seconds: secondsToAdd));
  String formattedDateTime =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(futureTime);

  return formattedDateTime;
}

String DataLength(double bytes, {int decimals = 2}) {
  if (bytes <= 0) return "0 B";

  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  int count = 0;
  while (bytes >= 1024 && count < suffixes.length - 1) {
    bytes /= 1024;
    count++;
  }
  if (bytes % 1 == 0) {
    decimals = 0;
  }
  return "${bytes.toStringAsFixed(decimals)}${suffixes[count]}";
}
