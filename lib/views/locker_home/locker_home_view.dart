import 'package:fitvault/services/credential_store.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LockerHomeView extends StatefulWidget {
  final CredentialStore credStore;
  const LockerHomeView({
    super.key,
    required this.credStore,
  });

  @override
  State<LockerHomeView> createState() => _LockerHomeViewState();
}

class _LockerHomeViewState extends State<LockerHomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locker Home'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Permission.photos.request().then((status) {
                  if (status.isGranted) {
                    print('Video permission granted');
                  } else {
                    // Handle permission denial
                    print('Video permission denied');
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: size.width * 0.3,
                height: size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_collection_rounded,
                      size: 50,
                      color: Colors.indigo,
                    ),
                    SizedBox(height: 5),
                    RichText(text: TextSpan(
                      text: 'Videos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                        fontFamily: 'Poppins',
                      ),  
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(width: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              width: size.width * 0.3,
              height: size.width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.indigo,
                  ),
                  SizedBox(height: 5),
                  RichText(text: TextSpan(
                    text: 'Images',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                      fontFamily: 'Poppins',
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
