import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/cubit/ping_pong_cubit.dart';

class PingPongGame extends StatefulWidget {
  const PingPongGame({super.key});

  @override
  State<PingPongGame> createState() => _PingPongGameState();
}

class _PingPongGameState extends State<PingPongGame>
    with SingleTickerProviderStateMixin {
  late PingPongCubit pingPongCubit;

  @override
  void initState() {
    pingPongCubit = BlocProvider.of<PingPongCubit>(context);
    pingPongCubit.initGame();
    pingPongCubit.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100000));
    pingPongCubit.animation = Tween<double>(begin: 0, end: 100)
        .animate(pingPongCubit.animationController);
    pingPongCubit.animation.addListener(() {
      pingPongCubit.checkBorder(context);
      setState(() {
        pingPongCubit.updateBallMovement();
      });
    });
    pingPongCubit.animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    pingPongCubit.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 13, 56),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return BlocBuilder<PingPongCubit, PingPongState>(
            builder: (context, state) {
              pingPongCubit.height = constraints.maxHeight;
              pingPongCubit.width = constraints.maxWidth;
              pingPongCubit.sliderWidth = pingPongCubit.width / 5;
              pingPongCubit.sliderHeight = pingPongCubit.height / 25;
              return SizedBox(
                height: pingPongCubit.height,
                width: pingPongCubit.width,
                child: Stack(
                  children: [
                    Positioned(
                        top: 10,
                        right: 10,
                        child: Column(
                          children: [
                            Text(
                              'Score: ${pingPongCubit.playerScore}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                pingPongCubit.resetGame();
                              },
                              icon: const Icon(Icons.replay),
                              color: Colors.pinkAccent,
                            )
                          ],
                        )),
                    Positioned(
                        left: pingPongCubit.xPosition,
                        top: pingPongCubit.yPosition,
                        child: CircleAvatar(
                          radius: pingPongCubit.ballRadius,
                          backgroundColor: Colors.amber,
                        )),
                    Positioned(
                        left: pingPongCubit.sliderXPosition,
                        bottom: 0,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (drag) =>
                              pingPongCubit.sliderDragUpdate(drag),
                          child: Container(
                            height: pingPongCubit.sliderHeight,
                            width: pingPongCubit.sliderWidth,
                            color: Colors.pink,
                            child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.keyboard_double_arrow_left,
                                    color: Colors.pinkAccent,
                                  ),
                                  Icon(
                                    Icons.keyboard_double_arrow_right,
                                    color: Colors.pinkAccent,
                                  ),
                                ]),
                          ),
                        )),
                    const Center(
                      child: Text(
                        'Ping \nPong',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(55, 65, 16, 73),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
