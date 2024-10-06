import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetectLocationEvent extends MapEvent {}

class SwitchMapTypeEvent extends MapEvent {}
