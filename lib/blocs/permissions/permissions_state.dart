
part of 'permissons_bloc.dart';


class PermissionState extends Equatable {

  final bool allPermissionGranted;

  factory PermissionState.initial() => PermissionState._internal(false);
  PermissionState._internal(this.allPermissionGranted);

  factory PermissionState.checkStatus(bool status) =>
      PermissionState._internal(status);

  @override
  List<Object> get props => [allPermissionGranted];
}


