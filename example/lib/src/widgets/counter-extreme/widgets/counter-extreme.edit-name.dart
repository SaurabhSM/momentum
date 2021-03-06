import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import '../../../../src/momentum/counter-extreme/counter-extreme.controller.dart';
import '../../../../src/momentum/counter-extreme/counter-extreme.model.dart';

class CounterExtremeEditName extends StatelessWidget {
  final CounterItem item;
  final bool Function(String) onSubmit;
  final TextEditingController textEditingController = TextEditingController();

  CounterExtremeEditName({
    Key key,
    @required this.item,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textEditingController.text = item.name;
    return Dialog(
      child: Container(
        height: 200,
        width: 360,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: <Widget>[
            Text('Rename counter "${item.name}"', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintStyle: TextStyle(fontSize: 24)),
              style: TextStyle(fontSize: 24),
            ),
            MomentumBuilder(
              controllers: [CounterExtremeController],
              builder: (context, snapshot) {
                var counterExtreme = snapshot<CounterExtremeModel>();
                if (counterExtreme.nameInputError)
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      counterExtreme.nameInputErrorMessage,
                      style: TextStyle(color: Colors.redAccent, fontSize: 14),
                    ),
                  );
                return SizedBox();
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    var success = onSubmit(textEditingController.text);
                    if (success) Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
