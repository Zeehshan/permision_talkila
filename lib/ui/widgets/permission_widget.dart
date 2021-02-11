import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../blocs/blocs.dart';
import '../../model/permission_model.dart';


class PermissionWidget extends StatefulWidget {
  const PermissionWidget(this._permission);

  final Permission _permission;

  @override
  _PermissionState createState() => _PermissionState(_permission);
}

class _PermissionState extends State<PermissionWidget> {
  _PermissionState(this._permission);

  final Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
  }

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: (){
      requestPermission(_permission).then((value){
        BlocProvider.
        of<PermissionBloc>(context).
        add(CallToCheckPermissionEvent());
      }
      );
    },
    child: Column(
      children: [
        Row(
          children: [
            _ietm(_permission).icon,
            SizedBox(width: 8,),
            Text(_ietm(_permission).title,
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6,),
        Row(
          children: [
            Expanded(
                child: Text(
                    _ietm(_permission).subTitle,
                  style: TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.w400
                  ),
                ),
            ),
            SizedBox(width: 6,),
            Text(
              _permissionStatus.isGranted ? 'Approved' : 'Missing',
              style: TextStyle(
                color: getPermissionColor(),
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        SizedBox(height: 2,),
      ],
    ),
  );
  }

  void checkServiceStatus(BuildContext context, Permission permission) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text((await permission.status).toString()),
    ));
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }



  PermissionModel _ietm(Permission permission){
    switch(permission.value){
      case 1 :
        return PermissionModel(
            title: 'Camera',
            subTitle: 'Required so that you can make video call with the app',
            icon: Icon(Icons.camera)
        );
        break;
      case 7 :
        return PermissionModel(
            title: 'Microphone',
            subTitle: 'Required to talk with Talkila',
            icon: Icon(Icons.mic)
        );
        break;
      case 6 :
        return PermissionModel(
            title: 'Filesystem',
            subTitle:
            'Required so that you can add profile photos from your filesystem',
            icon: Icon(Icons.storage)
        );
        break;
      case 16 :
        return PermissionModel(
            title: 'Notifications',
            subTitle: 'Required to recieve notifications from Talkila',
            icon: Icon(Icons.notifications)
        );
        break;
      case 8 :
        return PermissionModel(
            title: 'Phone',
            subTitle: 'Required to get phone states',
            icon: Icon(Icons.phone)
        );
    }
  }
}