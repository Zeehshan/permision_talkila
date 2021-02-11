import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../blocs/blocs.dart';
import '../../theme/app_colors.dart';
import '../../utils/const.dart';
import '../widgets/permission_widget.dart';

class PermissionsScreen extends StatefulWidget {
  @override
  _PermissionsScreenState createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PermissionBloc>(
        create: (context) => PermissionBloc(),
      child: BlocConsumer<PermissionBloc, PermissionState>(
          listener: (BuildContext context,PermissionState state){
            print(state.allPermissionGranted);
          },
          builder: (BuildContext context,PermissionState state) {
            return Scaffold(
              backgroundColor: Color.fromRGBO(237, 237, 237, 1.0),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 10),
                      child: Text(
                        'Permissions',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14)
                        ),
                        child:Container(
                          color: AppThemeColor.colorWhite,
                          padding: EdgeInsets.
                          symmetric(horizontal: 20,vertical: 20),
                          child: Column(
                            children: [
                              if(!state.allPermissionGranted)
                                _row1('Permission missing'),
                              if(state.allPermissionGranted)
                                _row1('Permissions sufficient'),
                              SizedBox(height: 20,),
                              Text(ConstValue.permisionDesc),
                              SizedBox(height: 18,),
                              Row(
                                children: [
                                  Text('Name'),
                                  Spacer(),
                                  Text('Status')
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                    children: Permission.values
                                        .where((permission) {
                                      if (Platform.isIOS) {
                                        return permission ==
                                            Permission.camera ||
                                            permission ==
                                                Permission.microphone ||
                                            permission ==
                                                Permission.mediaLibrary ||
                                            permission ==
                                                Permission.notification;
                                      } else {
                                        return permission ==
                                            Permission.camera ||
                                            permission ==
                                                Permission.microphone ||
                                            permission ==
                                                Permission.mediaLibrary ||
                                            permission ==
                                                Permission.phone ||
                                            permission ==
                                                Permission.notification;
                                      }
                                    })
                                        .map((permission) => Column(
                                      children: [
                                        Divider(),
                                        PermissionWidget(permission),
                                      ],
                                    ))
                                        .toList()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
  Widget _row1(String statusText){
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppThemeColor.colorGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(Icons.settings,color: Colors.white,size: 28,),
          ),
        ),
        SizedBox(width: 14,),
        Text(statusText,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
      ],
    );
  }
}
