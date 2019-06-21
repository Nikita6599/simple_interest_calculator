import 'package:flutter/material.dart';
import 'package:validators/validators.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent
    ),
    home: SIForm()

  ));
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}
class _SIFormState extends State<SIForm>{
  var _currencies=["Rupees","Dollars","Pounds"];
  var _current='';
  var displayResult='';
  final _minpaddding=5.0;
  var _formkey=GlobalKey<FormState>();


  @override
  void initState(){
    super.initState();
    _current=_currencies[0];
  }

  TextEditingController pcontroller=TextEditingController();
  TextEditingController roicontroller=TextEditingController();
  TextEditingController termcontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {

    TextStyle ts=Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
            children: <Widget>[

                  Container(
                    child:getAssetImage(),
                    padding: EdgeInsets.all(_minpaddding*10),
                    margin: EdgeInsets.all(_minpaddding*2),
                  ),
                 Padding(
                    padding: EdgeInsets.only(top:_minpaddding,bottom: _minpaddding,left: _minpaddding,right: _minpaddding),
                    child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: ts,
                    controller: pcontroller,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please enter principal amount";
                      }
                      if(!isNumeric(value)){
                        return "Please enter valid amount";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: ts,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent
                      ),
                      hintText: 'Enter Principal e.g 12000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                      )
                    ),
                  ),
                 ),
                 Padding(
                    padding: EdgeInsets.only(top:_minpaddding,bottom: _minpaddding,left: _minpaddding,right: _minpaddding),
                    child: TextFormField(
                    keyboardType: TextInputType.number,
                    style:ts,
                    controller: roicontroller,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please enter Rate of interest";
                        }
                        if(!isNumeric(value)){
                          return "Please enter valid rate";
                        }
                      },
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'In percent',
                        labelStyle: ts,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                 ),
                 Padding(
                     padding: EdgeInsets.only(top:_minpaddding,bottom: _minpaddding,left: _minpaddding,right: _minpaddding),
                     child:Row(
                   children: <Widget>[
                    Expanded(child: TextFormField(
                       keyboardType: TextInputType.number,
                       style: ts,
                        validator: (String value){
                        if(value.isEmpty){
                          return "Please enter term";
                        }
                        if(!isNumeric(value)){
                          return "Please enter valid term";
                        }
                       },
                       controller: termcontroller,
                       decoration: InputDecoration(
                         labelText: 'Term',
                         hintText: 'Time in years',
                         labelStyle: ts,
                           errorStyle: TextStyle(
                               color: Colors.yellowAccent
                           ),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5.0)
                         )
                       ),
                     ),
                    ),

                     Container(
                       width: _minpaddding*5,
                     ),

                     Expanded(child:DropdownButton(
                        items: _currencies.map((String item){
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String newValue){
                          setState((){
                            this._current=newValue;
                          });
                        },
                        value: _current,
                        style: ts,
                     ),
                     )])),
                  Padding(
                      padding: EdgeInsets.only(top:_minpaddding,bottom: _minpaddding,left:_minpaddding,right: _minpaddding),
                      child:Row(
                       children: <Widget>[
                         Expanded(child: Container(
                           child:RaisedButton(
                               color: Colors.lightBlue,
                               child: Text("Calculate"),
                               elevation: 6.0,
                               onPressed: (){
                                  setState(() {
                                    if(_formkey.currentState.validate()){
                                    this.displayResult=calculate();
                                    }});
                               }
                           )
                         )
                         ),
                         Expanded(child: Container(
                             child:RaisedButton(
                                 color: Colors.black,
                                 child: Text("Reset",style: TextStyle(color: Colors.white),),
                                 elevation: 6.0,
                                 onPressed: (){
                                    setState(() {
                                      if(_formkey.currentState.validate()) {
                                        reset();
                                      } });
                                 }
                             )
                         )
                         )

                       ],
                     )),
                     Padding(

                       child:Text(this.displayResult,style: ts,),
                         padding: EdgeInsets.only(top:_minpaddding,bottom: _minpaddding,left: _minpaddding,right: _minpaddding),

                      )



                   ],
                 )


      ),
      );


  }
Widget getAssetImage(){
  AssetImage img=AssetImage('images/money.png');
  Image image=Image(image:img,width: 125.0,height: 125.0,);
  return image;

}


String calculate(){
    double p=double.parse(pcontroller.text);
    double roi=double.parse(roicontroller.text);
    double term=double.parse(termcontroller.text);

    double amount=p+(p*roi*term)/100;
    String result="The amount is ${amount} ${_current} ";
    return result;

}

void reset(){
    pcontroller.text='';
    roicontroller.text='';
    termcontroller.text='';
    displayResult='';
    _current=_currencies[0];

}
}

