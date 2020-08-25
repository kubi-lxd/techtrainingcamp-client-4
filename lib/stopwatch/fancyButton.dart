import 'package:flutter/material.dart';
import 'constants.dart';

class FancyButton extends StatefulWidget {
  final String label;
  final Function onPress;
  final LinearGradient gradient;

  FancyButton({this.label, this.onPress, this.gradient});
  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white, width: 2.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          width: 120.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            '${widget.label}',
            style: TextStyle(
              color: Color(UserColors().purple),
              fontSize: 18,
              // fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: widget.onPress,
    );
  }
}
