import 'package:bem_estar/routes/app_routes.dart';
import 'package:flutter/material.dart';


class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: size.width * 0.2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
              },
              child: Image.asset("assets/logo.png", fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            height: size.height * 0.05,
            width: size.width * 0.7,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
