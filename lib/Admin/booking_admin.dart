import 'package:barber_app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barber_app/services/database.dart';
import 'package:flutter/material.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? bookingStream;

  Future<void> getOnTheLoad() async {
    bookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allBookings() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(45.0),
                      elevation: 8.0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffebd197),
                              Color(0xffb48811),
                              Color(0xffa2790d),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "Service: ${ds["Service"]}",
                              style: const TextStyle(
                                color: Color(0xff2c2108),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Name: ${ds["Username"]}',
                              style: const TextStyle(
                                color: Color(0xff2c2108),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Date: ${ds["Date"]}',
                              style: const TextStyle(
                                color: Color(0xff2c2108),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Time: ${ds["Time"]}',
                              style: const TextStyle(
                                color: Color(0xff2c2108),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().DeleteBooking(ds.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Appointment Done',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 25.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF252525),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Logout Confirmation"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text("No",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to the logout route
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LogIn(),
                                    ),
                                  );
                                },
                                child: Text("Yes",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const Center(
                child: Text(
                  'All Bookings',
                  style: TextStyle(
                    color: Color(0xff2c2108),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: allBookings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:barber_app/services/database.dart';
// import 'package:flutter/material.dart';

// class BookingAdmin extends StatefulWidget {
//   const BookingAdmin({super.key});

//   @override
//   State<BookingAdmin> createState() => _BookingAdminState();
// }

// class _BookingAdminState extends State<BookingAdmin> {
//   Stream? BookingStream;

//   getontheload() async {
//     BookingStream = await DatabaseMethods().getBookings();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getontheload();
//     super.initState();
//   }

//   Widget allBookings() {
//     return StreamBuilder(
//         stream: BookingStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: snapshot.data.docs.length,
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data.docs[index];
//                     return Material(
//                       borderRadius: BorderRadius.circular(45.0),
//                       elevation: 8.0,
//                       child: Container(
//                         padding: const EdgeInsets.all(10.0),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xffebd197),
//                               Color(0xffb48811),
//                               Color(0xffa2790d),
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(45.0),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(60.0),
//                                   child: Image.network(
//                                     ds["Image"],
//                                     height: 80.0,
//                                     width: 80.0,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//                             Text(
//                               "Service :   " + ds["Service"],
//                               style: const TextStyle(
//                                 color: Color(0xff2c2108),
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'Name :   ' + ds["Username"],
//                               style: const TextStyle(
//                                 color: Color(0xff2c2108),
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'Date :   ' + ds["Date"],
//                               style: const TextStyle(
//                                 color: Color(0xff2c2108),
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'Time :   ' + ds["Time"],
//                               style: const TextStyle(
//                                 color: Color(0xff2c2108),
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 10.0,
//                                 horizontal: 25.0,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF252525),
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                               child: const Text(
//                                 'Done',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   })
//               : Container();
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           margin: const EdgeInsets.only(
//             top: 60.0,
//             left: 20.0,
//             right: 20.0,
//             bottom: 60.0,
//           ),
//           child: Column(
//             children: [
//               const Center(
//                 child: Text(
//                   'All Bookings',
//                   style: TextStyle(
//                     color: Color(0xff2c2108),
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Material(
//                 borderRadius: BorderRadius.circular(45.0),
//                 elevation: 8.0,
//                 child: Container(
//                   padding: const EdgeInsets.all(10.0),
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color(0xffebd197),
//                         Color(0xffb48811),
//                         Color(0xffa2790d),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(45.0),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(60.0),
//                             child: Image.asset(
//                               "images/nestler.jpg",
//                               height: 80.0,
//                               width: 80.0,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                       const Text(
//                         'Service :   Hair Cutting',
//                         style: TextStyle(
//                           color: Color(0xff2c2108),
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         'Name :   Nestler Gevera',
//                         style: TextStyle(
//                           color: Color(0xff2c2108),
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         'Date :   12/04/2024',
//                         style: TextStyle(
//                           color: Color(0xff2c2108),
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         'Time :   06:30 PM',
//                         style: TextStyle(
//                           color: Color(0xff2c2108),
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10.0,
//                           horizontal: 25.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF252525),
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text(
//                           'Done',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: allBookings(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
