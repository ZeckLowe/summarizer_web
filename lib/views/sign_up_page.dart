import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summarizer_web/models/models.dart';
import 'package:summarizer_web/providers/providers.dart';
import 'package:summarizer_web/views/start_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
    return Expanded(
      child: Container(
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
            SIgnUp(),
          ],
        ),
      ),
    );
  }
}

class SIgnUp extends StatelessWidget {
  const SIgnUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 160,
        ),
        Text(
          'Already have an account?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        TextButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SignUpPage(),
            //   ),
            // );
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
      ],
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
            child: Image.network(
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
            child: Image.network(
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
            child: Image.network(
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
      child: Expanded(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight - 700,
            ),
            SignUpText(),
            JustAQuickText(),
            SizedBox(
              height: 40,
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
              height: 30,
            ),
            ConfirmPasswordText(),
            SizedBox(
              height: 10,
            ),
            ConfirmPassword(),
            SizedBox(
              height: 100,
            ),
            SignUpButton()
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends ConsumerWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        // final AsyncValue<List<User>> usersAsyncValue = ref.watch(userProvider);
        final List<User> users = ref.watch(usersAsyncValue);
        final String inputEmail = ref.watch(inputEmailProvider);
        final String inputPassword = ref.watch(inputPasswordProvider);
        final String inputConfirmPassword =
            ref.watch(inputConfirmPasswordProvider);
        bool emailAlreadyExists = false;
        bool emailIsValid = true;
        bool passwordLength = false;
        bool passwordMatch = false;

        for (var user in users) {
          if (user.email == inputEmail) {
            emailAlreadyExists = true;
          }
        }
        if (!EmailValidator.validate(inputEmail)) {
          emailIsValid = false;
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Invalid Email Format'),
              content: const Text("Please enter a valid email address."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
        if (emailAlreadyExists) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Email Already exists'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please enter Another Email"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
        if (inputPassword.length < 8) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Password Too Short'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password length must at least be 8 characters"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        } else {
          passwordLength = true;
        }
        if (inputPassword != inputConfirmPassword) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Password Match Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password does not match confirm password"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        } else {
          passwordMatch = true;
        }
        if (emailIsValid == true &&
            emailAlreadyExists == false &&
            passwordMatch == true &&
            passwordLength == true) {
          await ref
              .read(userCreateProvider.notifier)
              .addUser(User(email: inputEmail, password: inputPassword));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StartScreen(),
            ),
          );
        }
      },
      child: Center(
        child: Container(
          width: 500,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordText extends StatelessWidget {
  const ConfirmPasswordText({
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
          'Confirm Password:',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}

class ConfirmPassword extends ConsumerWidget {
  const ConfirmPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool hidePass = ref.watch(showPassIconProvider2);
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
                width: 410,
                height: 45,
                child: TextField(
                  obscureText: hidePass,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(inputConfirmPasswordProvider.notifier).state =
                        value;
                  },
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
                    ref.read(showPassIconProvider2.notifier).state = !hidePass;
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

class JustAQuickText extends StatelessWidget {
  const JustAQuickText({
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
          'Just a few quick things to get started',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ],
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({
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
          'Sign Up',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
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
                width: 410,
                height: 45,
                child: TextField(
                  obscureText: hidePass,
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
                  onChanged: (value) {
                    ref.read(inputPasswordProvider.notifier).state = value;
                  },
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

class EmailTextField extends ConsumerWidget {
  const EmailTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                width: 450,
                height: 45,
                child: TextField(
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
                  onChanged: (value) async {
                    ref.read(inputEmailProvider.notifier).state = value;
                    final userList = await ref.watch(userProvider.future);
                    ref.read(usersAsyncValue.notifier).state = userList;
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
