import 'package:app_firebase/models/user.dart';
import 'package:app_firebase/models/user_data.dart';
import 'package:app_firebase/services/database.dart';
import 'package:app_firebase/shared/constant.dart';
import 'package:app_firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
        stream: DataBaseService(user.uid).userData,
        builder: (context, snapshot) {
          // this snapshot refers to the data coming back from the stream
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(children: [
                Text(
                  "update your settings via the form below",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Enter a name please ' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(
                  height: 10.0,
                ),
                //  DROP DOWN !
                DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData!.sugars,
                    items: sugars.map(((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    })).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString())),
                Slider(
                    activeColor:
                        Colors.brown[_currentStrength ?? userData!.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData!.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength ?? userData!.strength).toDouble(),
                    onChanged: (val) => setState(() => _currentStrength =
                        val.round()) // round the value to the nearest integer
                    ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown[200]),
                    onPressed: () async {
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength!.toInt());

                      if (_formKey.currentState!.validate()) {
                        await DataBaseService(user.uid).updateUserData(
                            _currentSugars ?? snapshot.data!.sugars,
                            _currentName ?? snapshot.data!.name,
                            _currentStrength ?? snapshot.data!.strength);

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                          // color: Colors.grey[800]
                          ),
                    )),
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
