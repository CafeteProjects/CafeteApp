import 'package:flutter/material.dart';
import '/database_workhorse.dart';   // hier steht fetchActive()
import '/models/opening_hours_model.dart'; // falls du dort Zeiten pflegst
import '/models/menu_items.dart'; // deine Active-Klasse

class OpeningHoursBox extends StatelessWidget {
  const OpeningHoursBox({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Active>(
      future: fetchActive(), // 👈 API-Abfrage
      builder: (context, snapshot) {
        // Default: Status noch unbekannt
        String statusText = "Loading...";
        Color statusColor = Colors.grey.shade800;

        if (snapshot.connectionState == ConnectionState.waiting) {
          statusText = "Checking status...";
        } else if (snapshot.hasError) {
          statusText = "Error loading status";
          statusColor = Colors.red.shade700;
        } else if (snapshot.hasData) {
          final active = snapshot.data!;
          if (active.active) {
            statusText = "Currently open";
            statusColor = Colors.green.shade700;
          } else {
            statusText = "Currently closed";
            statusColor = Colors.red.shade700;
          }
        }

        return Container(
          width: 180,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF4B3621),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200.withOpacity(0.5),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "MO - FR",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "09:45 - 16:15",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
