import 'dart:io';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionState.initial()) {
    add(CallToCheckPermissionEvent());
  }

  @override
  Stream<PermissionState> mapEventToState(PermissionEvent event) async* {
    if(event is CallToCheckPermissionEvent){
      bool check = await isGrantedAll();
      yield PermissionState.checkStatus(check);
    }
  }


 Future<bool> isGrantedAll() async{
    if(Platform.isIOS){
      return
        await Permission.camera.isGranted
            &&
            await Permission.microphone.isGranted
            &&
            await Permission.storage.isGranted
            &&
            await Permission.notification.isGranted;
    }else{
      return
        await Permission.camera.isGranted
            &&
            await Permission.microphone.isGranted
            &&
            await Permission.storage.isGranted
            &&
            await Permission.phone.isGranted
            &&
            await Permission.notification.isGranted;
    }
  }
}
