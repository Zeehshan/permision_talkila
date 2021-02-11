
part of 'permissons_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();
  @override
  List<Object> get props => [];
}

class CallToCheckPermissionEvent extends PermissionEvent{}