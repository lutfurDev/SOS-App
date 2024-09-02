import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Rifat Hasan",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "rifat90@gmail.com",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                showFullScreenImageDialog(
                  context,
                  "assets/images/qr_code.png", // Replace with your image URL
                );
              },
              child: const Text('Share profile'),
            ),
            const SizedBox(height: 8),
            const Divider(thickness: .5),
            const SizedBox(height: 20),

            // Profile Info
            _buildProfileInfoField("First Name", "Jon Des"),
            const SizedBox(height: 8),
            _buildProfileInfoField("Last Name", "Doe"),
            const SizedBox(height: 8),
            _buildProfileInfoField("Phone Number", "+1 234 567 890"),
            const SizedBox(height: 8),
            _buildProfileInfoField("Address", "123 Main Street"),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

}

class FullScreenImageDialog extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageDialog({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
    );
  }
}

void showFullScreenImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (context) => FullScreenImageDialog(imageUrl: imageUrl),
  );
}
