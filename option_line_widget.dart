import 'package:flutter/material.dart';

class OptionLineWidget extends StatefulWidget{
  Icon icon;
  String name;
  double sizeText;
  Function() onPressed;
  Widget feedback;
  OptionLineWidget({
    super.key,
    required this.icon,
    required this.name,
    required this.feedback,
    required this.sizeText,
    required this.onPressed,
  });
  OptionLineWidgetState createState()=>OptionLineWidgetState();
}

class OptionLineWidgetState extends State<OptionLineWidget>{
  @override
  void initState(){
    super.initState();
    myInitState();
  }
  Future<void> myInitState() async {
    if(mounted){
      setState(() {});
    }
  }
  @override
  void didUpdateWidget(covariant OptionLineWidget oldWidget){
    super.didUpdateWidget(oldWidget);
    myInitState();
  }

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
          height: 50,
          child: Row(
            children: [
              widget.icon,
              SizedBox(width: 10,),
              Text(
                widget.name,   style: TextStyle(
                fontSize: widget.sizeText,
              ),
              ),
              SizedBox(width: 10,),
              widget.feedback,
              Expanded(child: Container()),
              Icon(Icons.navigate_next)
            ],
          )
      ),
    );
  }
}