import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ping_pong/core/constant.dart';
import 'package:ping_pong/screens/dialog_box.dart';

part 'ping_pong_state.dart';

class PingPongCubit extends Cubit<PingPongState> {
  PingPongCubit() : super(PingPongInitial());

  late AnimationController animationController;
  late Animation<double> animation;
  Movement verticalMove = Movement.down;
  Movement horizontalMove = Movement.right;

  // ball
  double height = 0;
  double width = 0;
  double xPosition = 0;
  double yPosition = 0;
  double ballRadius = 7;

  // slider
  double sliderHeight = 0;
  double sliderWidth = 0;
  double sliderXPosition = 0;
  double sliderYPosition = 40;

  double xRandom = 1;
  double yRandom = 1;

  int playerScore = 0;
  int increment = 5;

  updateBallMovement() {
    (horizontalMove == Movement.right)
        ? xPosition += (increment * xRandom).round()
        : xPosition -= (increment * xRandom).round();
    (verticalMove == Movement.down)
        ? yPosition += (increment * yRandom).round()
        : yPosition -= (increment * yRandom).round();
  }

  double randomNumber() {
    double random = (50 + Random().nextInt(101)) / 100;
    return random;
  }

  checkBorder(context) {
    double ballDiameter = 2 * ballRadius;
    if (xPosition <= 0 && horizontalMove == Movement.left) {
      horizontalMove = Movement.right;
      xRandom = randomNumber();
    }
    if (xPosition > (width - ballDiameter) &&
        horizontalMove == Movement.right) {
      horizontalMove = Movement.left;
      xRandom = randomNumber();
    }
    if (yPosition <= 0 && verticalMove == Movement.up) {
      verticalMove = Movement.down;
      yRandom = randomNumber();
    }
    if (yPosition >= height - ballDiameter - sliderHeight &&
        verticalMove == Movement.down) {
      if (xPosition >= (sliderXPosition - ballDiameter) &&
          xPosition <= sliderXPosition + sliderWidth + ballDiameter) {
        print('scored');
        verticalMove = Movement.up;
        yRandom = randomNumber();
        playerScore += 1;
      } else {
        animationController.stop();
        print('you loose');
        showGameDialog(context, playerScore, () {
          resetGame();
          Navigator.pop(context);
        });
      }
    }
  }

  initGame() {
    xPosition = 0;
    yPosition = 0;
    playerScore = 0;
  }

  resetGame() {
    initGame();
    animationController.repeat();
  }

  sliderDragUpdate(DragUpdateDetails drag) {
    sliderXPosition += drag.delta.dx;
    emit(SliderDragUpdate());
  }
}
