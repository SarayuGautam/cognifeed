import 'package:cognifeed_app/constants/cognifeed_constants.dart';
import 'package:cognifeed_app/helpers/customValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:string_validator/string_validator.dart' as validator;
import '../auth/authentication_bloc.dart';
import '../auth/authentication_states.dart';
import '../login/login_bloc.dart';
import '../login/login_events.dart';
import '../login/login_states.dart';
import '../misc/loading_indicator.dart';
import '../repository/user_repository.dart';

class SignupPage extends StatefulWidget {
  final UserRepository userRepository;

  const SignupPage({Key key, @required this.userRepository}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  FocusNode usernameFocusNode;
  FocusNode passwordFocusNode;
  FocusNode confirmPasswordFocusNode;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    _emailController..dispose();
    _passwordController..dispose();
    _confirmPasswordController..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onSignUpPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        SignupButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          PreferredSize(preferredSize: Size(0, 0), child: SizedBox.shrink()),
      bottomNavigationBar: SizedBox.shrink(),
      backgroundColor: CognifeedColors.dockEggBlue,
      body: BlocListener(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          }
        },
        child: BlocListener(
          bloc: BlocProvider.of<LoginBloc>(context),
          listener: (context, state) {
            if (state is LoginFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder(
              bloc: BlocProvider.of<LoginBloc>(context),
              builder: (context, state) {
                return AnnotatedRegion(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        left: -1,
                        top: -8,
                        bottom: -9,
                        right: -19,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            "assets/images/signup.png",

                            // scale: 1.8,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 26),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25 -
                                        10),
                            SvgPicture.asset(
                              "assets/images/logo.svg",
                              width: 148,
                              height: 50,
                            ),
                            SizedBox(height: 45),
                            Padding(
                              padding: const EdgeInsets.only(left: 141),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 55,
                                      child: TextFormField(
                                        autovalidate: true,
                                        validator: (value) {
                                          if (!validator.isEmail(value)) {
                                            return "Invalid Email";
                                          }
                                          return null;
                                        },
                                        controller: _emailController,
                                        focusNode: usernameFocusNode,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(passwordFocusNode);
                                        },
                                        style: TextStyle(
                                            color: CognifeedColors.teal),
                                        decoration: InputDecoration(
                                          errorText: "",
                                          fillColor: CognifeedColors.aquaMarine,
                                          labelText: "Email",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      height: 55,
                                      child: TextFormField(
                                        autovalidate: true,
                                        validator: (val) =>
                                            validatePassword(val),
                                        controller: _passwordController,
                                        obscureText: obscurePassword,
                                        onEditingComplete: () {
                                          FocusScope.of(context).requestFocus(
                                              confirmPasswordFocusNode);
                                        },
                                        focusNode: passwordFocusNode,
                                        style: TextStyle(
                                            color: CognifeedColors.teal),
                                        decoration: InputDecoration(
                                          errorText: "",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              obscurePassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 17,
                                              color: CognifeedColors.teal,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                obscurePassword =
                                                    !obscurePassword;
                                              });
                                            },
                                          ),
                                          labelText: "Password",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      height: 55,
                                      child: TextFormField(
                                        autovalidate: true,
                                        validator: (val) {
                                          if (val != _passwordController.text) {
                                            return "Confirm password doesn't match.";
                                          }
                                          return null;
                                        },
                                        controller: _confirmPasswordController,
                                        obscureText: obscureConfirmPassword,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        focusNode: confirmPasswordFocusNode,
                                        style: TextStyle(
                                            color: CognifeedColors.teal),
                                        decoration: InputDecoration(
                                          errorText: "",
                                          suffixIcon: Container(
                                            height: 17,
                                            width: 17,
                                            child: FlatButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                obscureConfirmPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 17,
                                                color: CognifeedColors.teal,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  obscureConfirmPassword =
                                                      !obscureConfirmPassword;
                                                });
                                              },
                                            ),
                                          ),
                                          labelText: "Confirm Password",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      height: 33,
                                      width: 127,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text("Sign Up",
                                            style:
                                                CognifeedTypography.textStyle4),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _onSignUpPressed();
                                          }
                                        },
                                        color: CognifeedColors.aquaMarine,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Already have an account?",
                                  style: CognifeedTypography.textStyle4,
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Container(
                                  height: 33,
                                  width: 90,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text("Log In",
                                        style: CognifeedTypography.textStyle4),
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              Navigator.defaultRouteName));
                                    },
                                    color: CognifeedColors.duskyBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                      if (state is LoginLoading)
                        Container(
                          color: Colors.black38,
                          child: Center(child: LoadingIndicator()),
                        )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
