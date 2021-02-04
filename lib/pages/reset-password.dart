import '../localization/localization_constants.dart';
import '../routes/route_names.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  LoginModel loginModel = LoginModel();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            // The containers in the background
            new Column(
              children: <Widget>[
                new Container(
                  height: MediaQuery.of(context).size.height * .5,
                  decoration: BoxDecoration(
                    color: Colors.gold,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                    )
                  ),
                )
              ],
            ),
            // The card widget with top padding, 
            // incase if you wanted bottom padding to work, 
            // set the `alignment` of container to Alignment.bottomCenter
            new Container(
              height: 130,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .1,
                  right: 20.0,
                  left: 20.0),
              alignment: Alignment.topCenter,
              child: Image.asset('lib/assets/images/logo.png'),
            ),
            new Container(
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .21,
                  right: 20.0,
                  left: 20.0),
              alignment: Alignment.topCenter,
              child: Text(
                getTranslated(context, 'dr-hazem-sultan'),
                style: TextStyle(fontSize: 18,color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .3,
                  right: 20.0,
                  left: 20.0),
              child: new Container(
                height: 260,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      color: Colors.white,
                      elevation: 4.0,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            MyTextFormField(
                              hintText: getTranslated(context, 'email'),
                              isEmail: true,
                              validator: (String value) {
                                if (!validator.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                loginModel.email = value;
                              },
                            ),
                            RaisedButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Result(loginModel: this.loginModel)));
                                  Navigator.pushNamed(context, consultationsRoute);
                                }
                              },
                              child: Text(
                                getTranslated(context, 'reset-password'),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      left: 5,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, loginRoute);
                        }, 
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              getTranslated(context, 'login'),
                              style: TextStyle(
                                color: Colors.gold
                              ),
                            )
                          ],
                        )
                      )
                    )
                  ],
                )
              ),
            ),
            Positioned(
              bottom: 25,
              right: 5,
              left: 5,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, registerRoute);
                }, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      getTranslated(context, 'not-a-member'),
                      style: TextStyle(
                        color: Colors.gold
                      ),
                    ),
                    Text(
                      getTranslated(context, 'create-new-account'),
                      style: TextStyle(
                        color: Colors.gold
                      ),
                    )
                  ],
                )
              )
            )

          ],
        )
      )
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey[200],width:1),
            borderRadius: BorderRadius.circular(10)
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}