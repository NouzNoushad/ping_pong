part of 'ping_pong_cubit.dart';

@immutable
sealed class PingPongState {}

final class PingPongInitial extends PingPongState {}

final class BallMovementUpdate extends PingPongState {}

final class SliderDragUpdate extends PingPongState {}

