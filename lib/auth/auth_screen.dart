import 'package:commercia/constants/constant.dart';
import 'package:commercia/shared/alert_dialog.dart';
import 'package:commercia/views/home_screen.dart';
import 'package:commercia/widgets/custom_button.dart';
import 'package:commercia/widgets/form_inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  static const route = 'auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  var _isLoginPage = true;
  var _isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _nameFocusNode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _nameFocusNode = FocusNode();

  }
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
  }

  Future<void> _trySignUp() async {
    if (_formKey.currentState.validate()) {
      if (_nameController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Name is required");
      } else if (_emailController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Email Address is required");
      } else if (_passwordController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Password is required");
      }
      else if(_passwordController.text.trim().length <6){
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Password Should be 6 chars at least");
      }
      try {
        final _auth = FirebaseAuth.instance;
        UserCredential userCredential;
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('name', _nameController.text.trim());
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      } on FirebaseAuthException catch (error) {
        setState(() {
          _isLoading = false;
        });
        var errorMessage = 'Authentication Failed ! try again';
        if (error.code =='email-already-in-use') {
          errorMessage = "Email address is Exist Before";
        }
        else if (error.code == 'weak-password') {
          errorMessage = "Your password is weak";
        }
        CustomAlertDialog.showAlertDialog(context, "Warning", "$errorMessage");
      } catch(error){
        setState(() {
          _isLoading = false;
          var errorMessage = 'Authentication Failed ! try again';
          CustomAlertDialog.showAlertDialog(context, "Warning", "$errorMessage");
        });
      }
    }
  }

  Future<void> _tryLogin() async {
    if (_formKey.currentState.validate()) {
      if (_emailController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Email Address is required");
      }
      else if (_passwordController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Password is required");
      }
      else if(_passwordController.text.trim().length <6){
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Password Should be 6 chars at least");
      }
      setState(() {
        _isLoading = true;
      });
      try {
        final _auth = FirebaseAuth.instance;
        UserCredential userCredential;
        userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getString('name');
        print(preferences.getString('name'));
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        var errorMessage = 'Authentication Failed ! try again';
        if (error.message.contains('badly formatted')) {
          errorMessage = "Email address is not valid";
        }
        CustomAlertDialog.showAlertDialog(context, "Warning", "$errorMessage");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isLoginPage
                    ? "Welcome User \n Login to your account"
                    : "Welcome \n Register new account",
                textAlign: TextAlign.center,
                style: Constants.kTitleText,
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: [
                      !_isLoginPage ? FormInput(
                        controller: _nameController,
                        hintText: "Name",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                        ),
                        textInputAction: TextInputAction.next,
                        onSubmitted: (value){
                          _emailFocusNode.requestFocus();
                        },
                      ) : Container(),
                      FormInput(
                        controller: _emailController,
                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        onSubmitted: (value){
                          _passwordFocusNode.requestFocus();
                        },
                      ),
                      FormInput(
                        controller: _passwordController,
                        hintText: "******",
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: _passwordFocusNode,
                        onSubmitted: (value){
                          if(_isLoginPage){
                            _tryLogin();
                          }else{
                            _trySignUp();
                          }
                        },
                      ),
                      CustomButton(
                        text: _isLoginPage ? "Sign In" : "Sign up",
                        isOutlinedBorder: false,
                        onPressed: (){
                          if(_isLoginPage){
                            _tryLogin();
                          }
                          else{
                            _trySignUp();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: _isLoginPage ? "Create New Account" : "Login to your account",
                isOutlinedBorder: true,
                onPressed: (){
                  setState(() {
                    _isLoginPage = !_isLoginPage;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
