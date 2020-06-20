import 'package:flutter/material.dart';
import 'package:quick_conversion/conversion.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double _numberFrom = 0;
  String _startMeasure ;
  String _newMeasure ;
  double _result = 0;
  String _resultMessage = '';
  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.deepPurple,
    );

    final spacer = Padding(padding: EdgeInsets.only(bottom: sizeY/40));
    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
      ),
      body: Container(
        width: sizeX, 
        padding: EdgeInsets.all(sizeX/20),
        child: SingleChildScrollView(child: Column(
          children: [
            Text('Value', style: labelStyle,),
            spacer,
            TextField(
              style: inputStyle,
              decoration: InputDecoration( 
                    hintText: "Please insert the measure to be converted", 
                  ), 
              onChanged: (text) {
                setState(() {
                  _numberFrom = double.parse(text);
                });
              },
            ),
            spacer,
            Text('From', style: labelStyle,),
            spacer,
            DropdownButton(
              isExpanded: true,
              style: inputStyle,
              value: _startMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onStartMeasureChanged(value);
              },
            ),
            spacer,
            Text('To', style: labelStyle,),
            spacer,
            DropdownButton(
              isExpanded: true,
              style: inputStyle,
              value: _newMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onConvertedMeasureChanged(value);
              },
            ),
            spacer,
            RaisedButton(child:Text('Convert', style: inputStyle),
              onPressed: ()=>convert(),),
            spacer,
            Text(_resultMessage, style: labelStyle,)
          ],
        )),
      ),
    );
  }

  void onStartMeasureChanged(String value) {
    setState(() {
      _startMeasure = value;
    });
  }
  void onConvertedMeasureChanged(String value) {
    setState(() {
      _newMeasure = value;
    });
  }

  void convert() {
    if (_startMeasure.isEmpty || _newMeasure.isEmpty || _numberFrom==0) {
      return;
    }
    Conversion c = Conversion();
    double result = c.convert(_numberFrom, _startMeasure, _newMeasure);
    setState(() {
      _result = result;
      if (result == 0) {
        _resultMessage = 'Conversion cannot be performed';
      }
      else {
        _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${_result.toString()} $_newMeasure';   
      }

    });
  }

}