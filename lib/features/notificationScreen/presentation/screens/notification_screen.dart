import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "New Course Available",
      "message": "Check out the latest UI/UX Design course!",
      "time": "5 min ago",
      "isRead": false
    },
    {
      "title": "Assignment Due Soon",
      "message": "Your Mobile App Development assignment is due tomorrow.",
      "time": "2 hours ago",
      "isRead": false
    },
    {
      "title": "Profile Updated",
      "message": "Your profile information has been updated successfully.",
      "time": "1 day ago",
      "isRead": true
    },
  ];

  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  void removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Text("Notifications", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all, color: Colors.white),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text("No new notifications",
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    removeNotification(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: () => markAsRead(index),
                    child: Card(
                      color: item['isRead']
                          ? Colors.grey[850]
                          : Colors.blueGrey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(item['title'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(item['message'],
                                style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 5),
                            Text(item['time'],
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        trailing: item['isRead']
                            ? const Icon(Icons.check_circle,
                                color: Colors.green)
                            : const Icon(Icons.circle,
                                color: Colors.redAccent, size: 12),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
