import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../services/food_service.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final TextEditingController searchController = TextEditingController();
  final FoodService foodController = FoodService();

  List<Map<String, dynamic>> foodList = [];
  List<Map<String, dynamic>> filteredFoodList = [];

  @override
  void initState() {
    super.initState();
    fetchFoodList();
  }

  Future<void> fetchFoodList() async {
    try {
      final List<Map<String, dynamic>> foods = await foodController.getFoodList();
      foods.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
      
      setState(() {
        foodList = foods;
        filteredFoodList = foodList;
      });
    } catch (e) {
      print('Error fetching food list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: AppColors.white,
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              filteredFoodList = foodList
                                  .where((food) =>
                                      food['name'].toLowerCase().contains(query.toLowerCase()))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1, 
                        ),
                        itemCount: filteredFoodList.length,
                        itemBuilder: (context, index) {
                          return buildFoodCard(filteredFoodList[index]);
                        },
                      ),
                    ],
                  )
                )
              ],
            ),
        ),
      ),
    );
  }

  Widget buildFoodCard(Map<String, dynamic> food) {
    double price = (double.parse(food['price'] ?? 0));
    String formattedPrice = price.toStringAsFixed(0);

    return GestureDetector(
      onTap: () {
        // food details page 
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                food['thumb'] ?? '-',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 80,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food['name'] ?? '-',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$formattedPrice koin',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ 
                      Icon(Icons.favorite, color: AppColors.primary),
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}