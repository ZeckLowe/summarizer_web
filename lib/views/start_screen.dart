import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summarizer_web/providers/providers.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              LoginContainer(
                  screenHeight: screenHeight, screenWidth: screenWidth),
              SignUpContainer(
                  screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          )
        ],
      ),
    );
  }
}

class SignUpContainer extends StatelessWidget {
  const SignUpContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth - 888,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight - 550,
          ),
          OrText(),
          SizedBox(
            height: 80,
          ),
          OtherSignUp(),
          SizedBox(
            height: 150,
          ),
          Row(
            children: [
              SizedBox(
                width: 160,
              ),
              Text(
                'Don\'t have an account?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              TextButton(
                onPressed: () {
                  //INSERT SIGN UP PAGE
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OtherSignUp extends StatelessWidget {
  const OtherSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
        ),
        Container(
          width: 40, // Adjust the size as needed
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black, // Border color
              width: 1.0, // Border width
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/logo_google.jpg',
              width: 24, // Adjust the size of the logo as needed
              height: 24,
            ),
          ),
        ),
        SizedBox(
          width: 100,
        ),
        Container(
          width: 40, // Adjust the size as needed
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black, // Border color
              width: 1.0, // Border width
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/logo_fb.png',
              width: 24, // Adjust the size of the logo as needed
              height: 24,
            ),
          ),
        ),
        SizedBox(
          width: 100,
        ),
        Container(
          width: 40, // Adjust the size as needed
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black, // Border color
              width: 1.0, // Border width
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/discord_logo.jpg',
              width: 24, // Adjust the size of the logo as needed
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class OrText extends StatelessWidget {
  const OrText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
        ),
        Container(
          height: 3,
          width: 200,
          decoration: BoxDecoration(color: Color.fromARGB(255, 121, 121, 121)),
        ),
        Text(
          'or',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 3,
          width: 200,
          decoration: BoxDecoration(color: Color.fromARGB(255, 121, 121, 121)),
        ),
      ],
    );
  }
}

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth - 600,
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight - 650,
          ),
          Text(
            'Welcome Back!',
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 60,
          ),
          EmailAddressText(),
          SizedBox(
            height: 10,
          ),
          EmailTextField(),
          SizedBox(
            height: 30,
          ),
          PasswordText(),
          SizedBox(
            height: 10,
          ),
          PasswordTextField(),
          SizedBox(
            height: 10,
          ),
          ForgotPasswordTExt(),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ForgotPasswordTExt extends StatelessWidget {
  const ForgotPasswordTExt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 570,
        ),
        Text(
          'Forgot Password?',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 199, 199, 199)),
        ),
      ],
    );
  }
}

class PasswordTextField extends ConsumerWidget {
  const PasswordTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool hidePass = ref.watch(showPassIconProvider);
    return Row(
      children: [
        SizedBox(
          width: 200,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          width: 500,
          height: 45,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: Icon(Icons.lock),
              ),
              Container(
                width: 300,
                height: 45,
                child: TextField(
                  obscureText: hidePass,
                  // controller: controller,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: 40,
                width: 40,
                child: IconButton(
                  icon:
                      Icon(hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    ref.read(showPassIconProvider.notifier).state = !hidePass;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PasswordText extends StatelessWidget {
  const PasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
        ),
        Text(
          'Password:',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          width: 500,
          height: 45,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: Icon(Icons.email),
              ),
              Container(
                width: 300,
                height: 45,
                child: TextField(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SearchView2()),
                    // );
                  },
                  // controller: controller,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmailAddressText extends StatelessWidget {
  const EmailAddressText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
        ),
        Text(
          'Email Address:',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}
