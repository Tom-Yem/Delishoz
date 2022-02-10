import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserError extends StatelessWidget {
  UserError({
    Key? key,
    required this.svgUrl,
    required this.title,
    required this.description,
    required this.btnText,
    required this.btnAction,
  }) : super(key: key);

  final String svgUrl;
  final String title;
  final String description;
  final String btnText;
  final Function() btnAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        Center(child: SvgPicture.asset(svgUrl)),
        const SizedBox(
          height: 112,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 56,
        ),
        ElevatedButton(
          onPressed: btnAction,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14),
            child: Text(
              btnText.toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}
