import 'package:flutter/material.dart';
import 'package:trace2treat/pages/dashboarddriver_page.dart';
import '../theme/app_colors.dart';

class TrashPickup3Page extends StatefulWidget {
  const TrashPickup3Page({Key? key}) : super(key: key);

  @override

  State<TrashPickup3Page> createState() => _TrashPickupPageState();
}

class _TrashPickupPageState extends State<TrashPickup3Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjemputan Sampah'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Diva Ariani', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Alamat Penjemputan', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Griya  Cibinong Indah, Kabupaten Bogor, Jawa Barat, Indonesia 16912', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Ongkos Kirim', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Rp 10.000', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Berat Sampah', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '0.2 kg', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Status', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Finished', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            Visibility(
              visible: true,
              // if status is finished turn visible true
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Bukti Penerimaan', 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                                      onPressed: () {
                                        // post attachment
                                      },
                                      child: Text(
                                        'Tambah lampiran',
                                          style: const TextStyle(color: AppColors.primary, decoration: TextDecoration.underline),
                                      ),
                                    ),
                ]
              ),
            ),
            Spacer(),
            Visibility(
              visible: false,
              // if status received, so the visible false
              child: GestureDetector(
                onTap: () {
                  // change status to received
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Selesai', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: false,
              // if status received, so the visible true
              child: GestureDetector(
                onTap: () {
                  // change status to received
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Kirim ke Pengepul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              )
            ),
            Visibility(
              visible: false,
              // if status delivered, so the visible true
              child: GestureDetector(
                onTap: () {
                  // change status to complete
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Diterima oleh Pengepul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              )
            ),
            Visibility(
              visible: true,
              // if status delivered, so the visible true
              child: GestureDetector(
                onTap: () {
                  // change status to complete
                  Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const DashboardDriverPage()
                  ), 
                );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Selesai', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0.2,
      color: Colors.grey,
    );
  }
}