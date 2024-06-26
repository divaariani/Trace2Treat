import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'home_page.dart';
import 'foodorderqr_page.dart';
import '../themes/app_colors.dart';
import '../services/transaction_service.dart';
import '../services/restaurant_service.dart';
import '../utils/session_manager.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({Key? key}) : super(key: key);

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  final TransactionService apiService = TransactionService(); 
  late List<Transaction> transactions = [];
  Map<String, dynamic> restaurant = {};
  int restaurantId = 0;
  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year} "
        "[${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}]";
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchTransactions();
      await fetchRestaurantData();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      if (mounted) {
        setState(() {
          apiService.isLoading = false;
        });
      }
    }
  }

  Future<void> fetchTransactions() async {
    setState(() {
      apiService.isLoading = true;
    });
    try {
      final List<Transaction> result = await apiService.getTransactions();
      
      result.sort((a, b) => b.id.compareTo(a.id));

      setState(() {
        transactions = result.isNotEmpty ? [result.first] : [];
        restaurantId = transactions[0].restoId;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  Future fetchRestaurantData() async {
    final String accessToken = SessionManager().getAccess() ?? '';

    try {
      final restaurantService = RestaurantService();

      restaurant = await restaurantService.fetchRestaurantData(restaurantId, accessToken);

    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()), 
              );
            },
          ),
          title: const Text('Pesanan'),
          centerTitle: true,
        ),
        body: apiService.isLoading || transactions == null || transactions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                  child: ListView(
                  controller: scrollController,
                  children: [
                    
                    ...transactions.map((transaction) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                restaurant['logo'] ?? '-',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    restaurant['name'] ?? '-',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatDateTime(transaction.createdAt),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    transaction.transactionCode,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.grey, 
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...buildFoodItemsList(transactions[0].items),
                            ]
                          )
                        ),
                        const SizedBox(height: 20),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0.3,
                          indicatorStyle: IndicatorStyle(
                            iconStyle: IconStyle(
                              color: Colors.white,
                              iconData: Icons.done,
                            ),
                            width: 20,
                            color: (transaction.status == 'preparing' || transaction.status == 'prepared' || transaction.status == 'success') ? AppColors.secondary : Colors.grey,
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Restoran sedang menyiapkan pesanan',
                              style: TextStyle(
                                color: (transaction.status == 'preparing' || transaction.status == 'prepared' || transaction.status == 'success') ? AppColors.secondary : Colors.grey,
                                fontSize: 14
                              ),
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0.3,
                          indicatorStyle: IndicatorStyle(
                            iconStyle: IconStyle(
                              color: Colors.white,
                              iconData: Icons.done,
                            ),
                            width: 20,
                            color: (transaction.status == 'prepared' || transaction.status == 'success') ? AppColors.secondary : Colors.grey,
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Pesanan Anda telah jadi !', 
                              style: TextStyle(
                                color: (transaction.status == 'prepared' || transaction.status == 'success') ? AppColors.secondary : Colors.grey,
                                fontSize: 14
                              ),
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0.3,
                          indicatorStyle: IndicatorStyle(
                            iconStyle: IconStyle(
                              color: Colors.white,
                              iconData: Icons.done,
                            ),
                            width: 20,
                            color: transaction.status == 'success' ? AppColors.secondary : Colors.grey,
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Koin berhasil ditukar !', 
                              style: TextStyle(
                                color: transaction.status == 'success' ? AppColors.secondary : Colors.grey,
                                fontSize: 14
                              ),
                            ),
                          ),
                        ),
                        if (transaction.status == 'prepared') const SizedBox(height: 30),
                        if (transaction.status == 'prepared') TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FoodOrderQrPage()), 
                            );
                          },
                          child: const Text(
                            'Bayar',
                            style: const TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                          ),
                        ),   
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: AppColors.secondary,
                                      backgroundImage:
                                          AssetImage('assets/avatar.jpg'),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(restaurant['name']),
                                const Text('Admin'),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                // Call admin
                              },
                              icon: const Icon(Icons.phone, color: AppColors.secondary),
                            ),
                            IconButton(
                              onPressed: () {
                                // Chat with admin
                              },
                              icon: const Icon(Icons.chat, color: AppColors.secondary),
                            ),
                          ],
                        ),
                      ],
                    )).toList(),
                  ]
                )
              )
            );
          },
        ),
      )
    );
  }

  List<Widget> buildFoodItemsList(List<dynamic> foodItems) {
    return foodItems.map((item) {
      return ListTile(
        leading: Image.network(
              item['food']['thumb'],
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            title: Text(item['food']['name']),
            subtitle: Text('Jumlah: ${item['qty']}'),
      );
    }).toList();
  }
}