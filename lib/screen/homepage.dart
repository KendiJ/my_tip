import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  double billAmount = 0;
  int tipPercentage = 0;
  double personAmount = 0;
  int personCount = 1;
  double tipAmount = 0;
  
  //the reset button parameters
  bool resetispressed = true;
  void resetbutton(){}

  // Map function which is called in the database
  Map bills;

  

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 200.0,
                    width: 600.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.deepOrange[200],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Total per person",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "\$${personAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 55.0,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                      child: Text("Reset"),
                      backgroundColor: Colors.red,
                      onPressed: resetispressed ? resetbutton: true,
                    ),
                  ],
                ),
              ),
              
              Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          hintText: "Enter total bill",
                          prefixStyle: TextStyle(
                            color: Colors.teal,
                          )),
                      onChanged: (value) {
                        setState(() {
                          billAmount = double.parse(value);
                          personAmount = (billAmount + tipAmount) / personCount;
                        });
                      },
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "People sharing",
                            style:
                                TextStyle(color: Colors.teal, fontSize: 16.0),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (personCount > 1)
                                        personCount = personCount - 1;
                                      personAmount = (billAmount + tipAmount) /
                                          personCount;
                                    });
                                  },
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent[100],
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Icon(
                                      Icons.remove,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                // ignore: unnecessary_brace_in_string_interps
                                child: Text(
                                  "$personCount",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    personCount = personCount + 1;
                                    personAmount =
                                        (billAmount + tipAmount) / personCount;
                                  });
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Icon(
                                    Icons.add,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add your tip", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal, fontSize: 15),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Tip",
                            style:
                                TextStyle(color: Colors.teal, fontSize: 18),
                          ),
                          Text(
                            "\$$tipAmount",
                            style:
                                TextStyle(color: Colors.teal, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "$tipPercentage %",
                            style:
                                TextStyle(color: Colors.teal, fontSize: 18.0),
                          ),
                          Slider(
                            value: tipPercentage.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                tipPercentage = value.toInt();
                                tipAmount = (tipPercentage / 100) * billAmount;
                                personAmount =
                                    (billAmount + tipAmount) / personCount;
                              });
                            },
                            max: 100,
                            activeColor: Colors.teal,
                            min: 0,
                            divisions: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              
            ],
          ),
        ),
      ),
    );
  }
}