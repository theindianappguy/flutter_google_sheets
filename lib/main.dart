import 'package:flutter/material.dart';
import 'package:flutter_google_sheets/controller.dart';
import 'package:flutter_google_sheets/model/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void _submitForm() {

    if(_formKey.currentState.validate()){
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          emailController.text,
          mobileNoController.text,
          feedbackController.text
      );

      FormController formController = FormController((String response){
        print("Response: $response");
        if(response == FormController.STATUS_SUCCESS){
          //
          _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("Error Occurred!");
        }
      });

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheet

      formController.submitForm(feedbackForm);
    }


  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  _scaffoldKey,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Name"
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Email"
                      ),
                    ),
                    TextFormField(
                      controller: mobileNoController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Phone Number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Phone Number"
                      ),
                    ),
                    TextFormField(
                      controller: feedbackController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Feedback";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Feedback"
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: _submitForm,
                      child: Text('Submit Feedback'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
