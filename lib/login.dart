import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checked = false;
  bool showPassword = true;

  Color getColor(Set<MaterialState> states) {
    if (checked) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontSize: 40,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    style: TextStyle(color: Color(0xFFF5F5F5)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFF242E49),
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    obscureText: showPassword,
                    style: TextStyle(
                        color: Color(0xFFF5F5F5)), // Change text color here
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFF242E49),
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              showPassword = !showPassword;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    3), // Adjust the border radius if needed
                                side: BorderSide(
                                  color: Colors.grey, // Set the border color
                                  width: 0, // Adjust the border width
                                ),
                              ),
                            ),
                          ),
                          child: Checkbox(
                            visualDensity: VisualDensity(
                              vertical:
                                  0, // Adjust the vertical density to make the checkbox less thick
                              horizontal:
                                  0, // Adjust the horizontal density if needed
                            ),
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            checkColor: Colors.white,
                            value: checked,
                            onChanged: (bool? value) {
                              setState(() {
                                checked = value!;
                              });
                            },
                          ),
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            height: 0.06,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF0F67FD), // Specify the background color here
                    padding: EdgeInsets.symmetric(
                      horizontal: 170.0, // Adjust button width
                      vertical: 24.0, // Add vertical padding to increase height
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Color(0xFFF5F5F5),
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold, // Make the text bold
                      height: 0.06,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 15.0),
                        child: const Divider(color: Color(0xFFF5F5F5)),
                      ),
                    ),
                    Text(
                      "or continue with",
                      style: TextStyle(color: Color(0xFFF5F5F5)),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: const Divider(color: Color(0xFFF5F5F5)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Color(0xFFF5F5F5),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'assets/apple.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          //AuthMethods().signInWithGoogle(context);
                        },
                        icon: Image.asset('assets/google.png',
                            width: 54, height: 54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        icon: Image.asset('assets/facebook.png',
                            width: 36, height: 36),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color(0xFFF5F5F5),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 58.5,
                      height: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            height: 0.06,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
