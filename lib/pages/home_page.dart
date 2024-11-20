import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_notification/api/local_notification_service.dart';
import 'package:flutter_notification/api/payload_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
      body: StreamBuilder(
          stream: PayloadService().streamPayload(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }

            final payload = snapshot.data ?? [];
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(payload[2]),
                    );
                  },
                ),

                ElevatedButton(
                  onPressed: () async {
                    await LocalNotificationService.showInstantNotification(
                        title: 'Test', body: payload[2]);
                  },
                  child: const Text('Send Instant Notification'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                   await LocalNotificationService.showScheduledNotification(
                        title: 'Test Scheduled', body: payload[4], time: DateTime.now().add(const Duration(seconds: 5)));
                  },
                  child: const Text('Send Scheduled Notification'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {

                    for(int i = 0; i < 7; i++){
                      await LocalNotificationService.showInstantNotification(
                          title: 'Test Recurring', 
                          body: payload[Random().nextInt(payload.length)]);

                      await Future.delayed(const Duration(seconds: 5));
                    }
                  },
                  child: const Text('Send Recurring Notification'),
                ),
              ],
            );
          })
    );
  }
}
