import 'package:flutter/material.dart';

showGameDialog(
    BuildContext context, int playerScore, void Function()? onPressed) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 45, 14, 51),
            title: const Center(
              child: Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            alignment: Alignment.center,
            content: Text(
              'Your score: $playerScore',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 94, 28, 107)),
                  child: const Text(
                    'Play again',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          ));
}
