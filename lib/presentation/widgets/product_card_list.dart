// import 'package:flutter/material.dart';

// class ProductCardList extends StatelessWidget {
//   const ProductCardList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Drug Types', style: TextStyle(fontSize: 20)),
//           SizedBox(
//             height: 50,
//             child: ListView.builder(
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     color: Colors.red,
//                     child: Center(child: Text('Headeach')),
//                   ),
//                 );
//               },
//               itemCount: 8,
//               scrollDirection: Axis.horizontal,
//             ),
//           ),
//           SizedBox(
//             height: 400,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: GridView.builder(
//                   itemBuilder: (context, index) {
//                     return Container(
//                       child: Image.asset('assets/images/man2.jpg'),
//                     );
//                   },
//                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProductCardList extends StatelessWidget {
  const ProductCardList({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Pain Relief', 'icon': Icons.healing_rounded, 'color': Colors.red},
    {
      'name': 'Antibiotics',
      'icon': Icons.local_hospital_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'Vitamins',
      'icon': Icons.energy_savings_leaf_rounded,
      'color': Colors.green,
    },
    {
      'name': 'Heart Care',
      'icon': Icons.favorite_rounded,
      'color': Colors.pink,
    },
    {'name': 'Allergy', 'icon': Icons.air_rounded, 'color': Colors.orange},
    {
      'name': 'Diabetes',
      'icon': Icons.water_drop_rounded,
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> featuredMedicines = const [
    {
      'name': 'Paracetamol',
      'price': '\$12.99',
      'rating': 4.5,
      'image': 'assets/images/man2.jpg',
      'prescription': false,
    },
    {
      'name': 'Amoxicillin',
      'price': '\$24.99',
      'rating': 4.8,
      'image': 'assets/images/man2.jpg',
      'prescription': true,
    },
    {
      'name': 'Ibuprofen',
      'price': '\$8.99',
      'rating': 4.2,
      'image': 'assets/images/man2.jpg',
      'prescription': false,
    },
    {
      'name': 'Vitamin D3',
      'price': '\$15.99',
      'rating': 4.6,
      'image': 'assets/images/man2.jpg',
      'prescription': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('See All')),
          ],
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildCategoryCard(
                  category['name'],
                  category['icon'],
                  category['color'],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Featured Medicines Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Medicines',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: featuredMedicines.length,
          itemBuilder: (context, index) {
            final medicine = featuredMedicines[index];
            return _buildMedicineCard(medicine);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String name, IconData icon, Color color) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> medicine) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with Flexible instead of Expanded
          Flexible(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      medicine['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (medicine['prescription'])
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Rx',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Content section with Flexible instead of Expanded
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // Important: Use minimum space needed
                children: [
                  Text(
                    medicine['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        medicine['rating'].toString(),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ), // Replace Spacer with fixed spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        medicine['price'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
