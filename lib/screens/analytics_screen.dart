// lib/screens/analytics_screen.dart
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop Analytics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A4D2E),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              _buildSectionTitle('Overview'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Total Sales', '\$2,450', Icons.trending_up, Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Orders', '48', Icons.shopping_cart, Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Plants Sold', '125', Icons.local_florist, Colors.orange),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Customers', '42', Icons.people, Colors.purple),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Top Selling Plants
              _buildSectionTitle('Top Selling Plants'),
              const SizedBox(height: 12),
              _buildPlantAnalytic('Monstera Deliciosa', 35, 0.75),
              _buildPlantAnalytic('Snake Plant', 28, 0.60),
              _buildPlantAnalytic('Fiddle Leaf Fig', 22, 0.47),
              _buildPlantAnalytic('Peace Lily', 20, 0.43),
              _buildPlantAnalytic('ZZ Plant', 20, 0.43),
              const SizedBox(height: 28),

              // Category Performance
              _buildSectionTitle('Sales by Category'),
              const SizedBox(height: 12),
              _buildCategoryAnalytic('Popular', 62, Colors.green),
              _buildCategoryAnalytic('Low Maintenance', 35, Colors.blue),
              _buildCategoryAnalytic('New Arrivals', 28, Colors.orange),
              const SizedBox(height: 28),

              // Performance Metrics
              _buildSectionTitle('Key Metrics'),
              const SizedBox(height: 12),
              _buildMetricRow('Average Order Value', '\$51.04'),
              _buildMetricRow('Customer Retention Rate', '85%'),
              _buildMetricRow('Most Active Day', 'Saturday'),
              _buildMetricRow('Peak Hour', '2:00 PM - 4:00 PM'),
            ],
          ),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A4D2E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantAnalytic(String name, int sales, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A4D2E),
                ),
              ),
              Text(
                '$sales sold',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1A4D2E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryAnalytic(String category, int sales, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A4D2E),
              ),
            ),
          ),
          Text(
            '$sales sales',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1A4D2E),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A4D2E),
            ),
          ),
        ],
      ),
    );
  }
}
