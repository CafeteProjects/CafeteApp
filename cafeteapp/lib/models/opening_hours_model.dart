import 'package:flutter/material.dart';

class OpeningHoursBox extends StatelessWidget {
  const OpeningHoursBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF4B3621),
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
        mainAxisSize: MainAxisSize.min, // 👈 sehr wichtig
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "MO - FR",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "09:45 - 16:15",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
