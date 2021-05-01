import 'package:apicalling/models/weather_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final url =
      "https://api.openweathermap.org/data/2.5/weather?q=Rangpur&appid=e0eaddcc08bc84c320b13d1383c72b06";
  UserModel userModel;

  var check = false;

  Future fetchData() async {
    setState(() {
      check = true;
    });

    await http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        userModel = userModelFromJson(value.body);
        setState(() {
          check = false;
        });
      }
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var timeConvert = userModel.sys.sunrise;
    DateTime someTime = new DateTime(timeConvert);
    return Scaffold(
      body: Container(
          child: check
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(150),
                                )),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Current Weather in Rangpur',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Current Teamperature',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 25),
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                size: 70,
                              ),
                              Text("${userModel.main.temp}")
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Teamperature High / Low',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.wb_sunny),
                                  Text(
                                      "${userModel.main.tempMax}/ ${userModel.main.tempMin}")
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Weather',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.cloud),
                                    Text("${userModel.weather[0].description}")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 33),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Humidty',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.cloud_circle),
                                    Text("${userModel.main.humidity}")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Wind Speed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.cloud_download),
                                    Text("${userModel.wind.speed}")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'pressure',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.cloud_queue),
                                    Text("${userModel.main.pressure}")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sunrise',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.wb_sunny_outlined),
                                    Text("${userModel.sys.sunrise}")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sunset',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.wb_sunny),
                                    Text("${userModel.sys.sunset}")
                                  ],
                                )
                              ],
                            ),
                          ),
                          // Text(someTime.toString()),
                          // Text(DateFormat('yyyy/MM/dd').format(someTime)),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
