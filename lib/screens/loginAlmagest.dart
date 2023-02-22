// import 'package:flutter/material.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import '../providers/login_form_provider.dart';
// import '../services/services.dart';
// import '../ui/input_decorations.dart';
// import 'package:http/http.dart' as http;
// import '../widgets/card_container.dart';
// import '../widgets/widgets.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AuthBackground(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 250),
//             CardContainer(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     'Login',
//                     style: Theme.of(context).textTheme.headline4,
//                   ),
//                   const SizedBox(height: 30),
//                   ChangeNotifierProvider(
//                     create: (_) => LoginFormProvider(),
//                     child: const _LoginForm(),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 50),
//             TextButton(
//               onPressed: () =>
//                   Navigator.pushReplacementNamed(context, 'register'),
//               style: ButtonStyle(
//                   overlayColor:
//                       MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
//                   shape: MaterialStateProperty.all(StadiumBorder())),
//               child: const Text(
//                 'Create new account',
//                 style: TextStyle(fontSize: 18, color: Colors.black87),
//               ),
//             ),
//             const SizedBox(height: 50)
//           ],
//         ),
//       )),
//     );
//   }
// }

// class _LoginForm extends StatelessWidget {
//   const _LoginForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loginForm = Provider.of<LoginFormProvider>(context);
//     return Container(
//       child: Form(
//         key: loginForm.formKey,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         child: Column(
//           children: [
//             TextFormField(
//                 autocorrect: false,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecorations.authInputDecoration(
//                   hinText: 'Pepi.to@gmail.com',
//                   labelText: 'Email',
//                   prefixIcon: Icons.alternate_email_sharp,
//                 ),
//                 onChanged: (value) => loginForm.email = value,
//                 validator: (value) {
//                   String pattern =
//                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                   RegExp regExp = new RegExp(pattern);
//                   return regExp.hasMatch(value ?? '')
//                       ? null
//                       : 'Use a valid email';
//                 }),
//             const SizedBox(height: 30),
//             TextFormField(
//                 autocorrect: false,
//                 obscureText: true,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecorations.authInputDecoration(
//                     hinText: '*******',
//                     labelText: 'Password',
//                     prefixIcon: Icons.lock_clock_outlined),
//                 onChanged: (value) => loginForm.password = value,
//                 validator: (value) {
//                   return (value != null && value.length >= 6)
//                       ? null
//                       : 'the password must have more than 6 characters';
//                 }),
//             const SizedBox(height: 30),
//             MaterialButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.grey,
//               elevation: 0,
//               color: Colors.blueGrey[600],
//               onPressed: loginForm.isLoading
//                   ? null
//                   : () async {
//                       FocusScope.of(context).unfocus();
//                       final authService =
//                           Provider.of<AuthService>(context, listen: false);
//                       if (!loginForm.isValidForm()) return;
//                       final String? data = await authService.login(
//                           loginForm.email, loginForm.password);
//                       final splitted = data?.split(',');
//                       if (splitted?[0] == 'a') {
//                         Navigator.pushReplacementNamed(context, 'admin');
//                       } else if (splitted?[0] == 'u') {
//                         final userAloneService = Provider.of<UserAloneService>(
//                             context,
//                             listen: false);
//                         await userAloneService.readUserAlone();
//                         if (splitted?[2] == 1) {
//                           customToast('Your user was deleted', context);
//                         } else if (splitted?[1] == '1') {
//                           Navigator.pushReplacementNamed(context, 'user');
//                         } else {
//                           customToast(
//                               'Admin must active your account', context);
//                         }
//                       } else {
//                         customToast('Email or password incorrect', context);
//                       }
//                     },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                 child: Text(
//                   loginForm.isLoading ? 'Wait' : 'Submit',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void customToast(String message, BuildContext context) {
//     showToast(
//       message,
//       textStyle: const TextStyle(
//         fontSize: 14,
//         wordSpacing: 0.1,
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//       textPadding: const EdgeInsets.all(23),
//       fullWidth: true,
//       toastHorizontalMargin: 25,
//       borderRadius: BorderRadius.circular(15),
//       backgroundColor: Colors.blueGrey[500],
//       alignment: Alignment.topCenter,
//       position: StyledToastPosition.bottom,
//       duration: const Duration(seconds: 3),
//       animation: StyledToastAnimation.slideFromBottom,
//       context: context,
//     );
//   }
// }
