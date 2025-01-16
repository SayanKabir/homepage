import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';
import 'package:homepage/components/simple_button.dart';
import 'package:homepage/auth/widgets/simple_textfield.dart';
import 'package:homepage/user_prefs/models/user_prefs_model.dart';
import 'package:homepage/auth/services/auth_service.dart';
import 'package:homepage/user_prefs/services/user_prefs_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final authService = AuthService();
  int visibleContainerNum = 0;
  final int numContainers = 3;
  bool showEmailPasswordTextfields = false;
  bool buttonPressed = false;

  void loginUser() async {
    await authService.login(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    saveUserName();
  }

  void saveUserName() async {
    final userPrefsService = UserPrefsService();
    await userPrefsService.upsertUserPref(
      tag: TAG_USERNAME,
      value: nameController.text,
    );
  }

  @override
  void initState() {
    super.initState();
    // Sequentially update the visibleContainerNum for fade-in effect
    for (int i = 1; i <= numContainers; i++) {
      Future.delayed(Duration(seconds: i), () {
        setState(() {
          visibleContainerNum = i;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //BACKGROUND
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pine_trees.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Blur(
            blurSigma: 5,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Welcome Heading
                      AnimatedOpacity(
                        opacity: (visibleContainerNum >= 1) ? 1 : 0,
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            'Welcome to homepage',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Sub-heading
                      AnimatedOpacity(
                        opacity: (visibleContainerNum >= 2) ? 1 : 0,
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            'A place to call home \nin the vast ocean of the internet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      //ENTER AUTH DETAILS
                      AnimatedOpacity(
                        opacity: (visibleContainerNum >= 3) ? 1 : 0,
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          // height: 250,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                          child: Column(
                            children: [
                              SimpleTextfield(
                                controller: nameController,
                                hintText: 'First name',
                              ),
                              const SizedBox(height: 20,),
                              SimpleTextfield(
                                controller: emailController,
                                hintText: 'Email',
                              ),
                              SimpleTextfield(
                                controller: passwordController,
                                hintText: 'Password',
                              ),

                              const SizedBox(height: 30,),
                              //LOGIN BUTTON
                              HoverBuilder(
                                builder: (context, isHovered) {
                                  return AnimatedScale(
                                    scale: isHovered ? 1.1 : 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOutCirc,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 80),
                                      child: MyTextButton(
                                        onPressed: (){
                                          if(nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                                            return;
                                          }
                                          setState(() {
                                            buttonPressed = true;
                                          });
                                          loginUser();
                                        },
                                        child: AnimatedAlign(
                                          alignment: buttonPressed ? Alignment.centerRight : Alignment.center,
                                          duration: const Duration(milliseconds: 1500),
                                          curve: Curves.easeOutCirc,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowRight,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
