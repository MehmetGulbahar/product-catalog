import '../models/product_model.dart';

class ProductMockDataSource {
  const ProductMockDataSource();

  List<ProductModel> getProducts() {
    return _mockProducts
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
  }
}

const List<Map<String, dynamic>> _mockProducts = [
  {
    'id': '1',
    'title': 'Executive Notebook',
    'description': 'Hardcover notebook with premium paper for daily planning.',
    'price': 19.99,
    'image': 'https://picsum.photos/seed/notebook/600/600',
  },
  {
    'id': '2',
    'title': 'Desk Lamp Pro',
    'description': 'Adjustable LED desk lamp with warm and cool light modes.',
    'price': 49.90,
    'image': 'https://picsum.photos/seed/lamp/600/600',
  },
  {
    'id': '3',
    'title': 'Wireless Keyboard',
    'description': 'Slim wireless keyboard designed for comfortable typing.',
    'price': 89.00,
    'image': 'https://picsum.photos/seed/keyboard/600/600',
  },
  {
    'id': '4',
    'title': 'Ceramic Mug Set',
    'description': 'Minimal ceramic mug pair for office and home use.',
    'price': 24.50,
    'image': 'https://picsum.photos/seed/mug/600/600',
  },
  {
    'id': '5',
    'title': 'Portable SSD 1TB',
    'description': 'Fast and compact storage for work and backups.',
    'price': 129.99,
    'image': 'https://picsum.photos/seed/ssd/600/600',
  },
  {
    'id': '6',
    'title': 'Smart Water Bottle',
    'description': 'Tracks hydration and keeps beverages cool all day.',
    'price': 39.75,
    'image': 'https://picsum.photos/seed/bottle/600/600',
  },
  {
    'id': '7',
    'title': 'Noise Control Headphones',
    'description': 'Over-ear headphones with clear sound and deep bass.',
    'price': 179.00,
    'image': 'https://picsum.photos/seed/headphones/600/600',
  },
  {
    'id': '8',
    'title': 'Travel Backpack',
    'description': 'Water-resistant backpack with laptop and tablet sections.',
    'price': 74.20,
    'image': 'https://picsum.photos/seed/backpack/600/600',
  },
  {
    'id': '9',
    'title': 'Mechanical Pencil Kit',
    'description': 'Precision pencil kit for sketching and note taking.',
    'price': 15.40,
    'image': 'https://picsum.photos/seed/pencil/600/600',
  },
  {
    'id': '10',
    'title': 'Monitor Stand',
    'description': 'Wood finish stand to organize desk and improve posture.',
    'price': 54.30,
    'image': 'https://picsum.photos/seed/monitor-stand/600/600',
  },
];
