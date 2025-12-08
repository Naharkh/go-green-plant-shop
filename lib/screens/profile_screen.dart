// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'add_plant_screen.dart';
import 'manage_plants_screen.dart';
import 'analytics_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;
  String? _adminName;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _isLoggedIn = true;
        _adminName = _emailController.text.split('@')[0].capitalize();
      });
      _emailController.clear();
      _passwordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
    }
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
      _adminName = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A4D2E),
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoggedIn ? _buildAdminDashboard() : _buildLoginPage(),
    );
  }

  Widget _buildLoginPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            // Logo/Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.admin_panel_settings,
                size: 50,
                color: Color(0xFF1A4D2E),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Admin Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A4D2E),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Manage your plant shop',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),

            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Admin Email',
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1A4D2E),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1A4D2E),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A4D2E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Demo Credentials
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Demo: Use any email & password to login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminDashboard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _adminName ?? 'Admin',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Shop Management Section
            _buildSectionTitle('Shop Management'),
            const SizedBox(height: 12),
            _buildMenuCard(
              'Add New Plant',
              'Add a new plant to your catalog',
              Icons.add_circle_outline,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPlantScreen()),
                );
              },
            ),
            _buildMenuCard(
              'Manage Plants',
              'Edit or delete existing plants',
              Icons.local_florist,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManagePlantsScreen()),
                );
              },
            ),
            _buildMenuCard(
              'View Analytics',
              'See sales and shop statistics',
              Icons.analytics,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
                );
              },
            ),
            const SizedBox(height: 24),

            // Account Section
            _buildSectionTitle('Account Settings'),
            const SizedBox(height: 12),
            _buildMenuCard(
              'Edit Profile',
              'Update your admin information',
              Icons.person,
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final nameController = TextEditingController(text: _adminName ?? '');
                    return AlertDialog(
                      title: const Text('Edit Profile'),
                      content: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Admin Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _adminName = nameController.text;
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated!')),
                            );
                          },
                          child: const Text('Save'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildMenuCard(
              'Change Password',
              'Update your login password',
              Icons.lock,
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final passwordController = TextEditingController();
                    return AlertDialog(
                      title: const Text('Change Password'),
                      content: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'New Password'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password changed!')),
                            );
                          },
                          child: const Text('Save'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildMenuCard(
              'Shop Information',
              'Manage shop details and settings',
              Icons.storefront,
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final shopController = TextEditingController(text: 'My Plant Shop');
                    return AlertDialog(
                      title: const Text('Shop Information'),
                      content: TextField(
                        controller: shopController,
                        decoration: const InputDecoration(labelText: 'Shop Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Shop info updated!')),
                            );
                          },
                          child: const Text('Save'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),

            // Security Section
            _buildSectionTitle('Security & Support'),
            const SizedBox(height: 12),
            _buildMenuCard(
              'Activity Log',
              'View recent admin activities',
              Icons.history,
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Activity Log'),
                      content: const Text('No recent activities.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildMenuCard(
              'Help & Support',
              'Contact support or view documentation',
              Icons.help,
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Help & Support'),
                      content: const Text('For help, contact: support@plantshop.com'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.red[300]!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A4D2E),
      ),
    );
  }

  Widget _buildMenuCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF1A4D2E),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A4D2E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}