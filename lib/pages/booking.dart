import 'package:barber_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:barber_app/services/shared_pref.dart';

class Booking extends StatefulWidget {
  String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email;

  getthedatafromsharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    email = await SharedPreferenceHelper().getUserEmail();

    setState(() {});
  }

  getontheload() async {
    await getthedatafromsharedpref();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF252525),
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Let the\njourney begin!',
                style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 28.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'images/discount.png',
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: 40.0,
              ),
              Text(
                widget.service,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Set a Date',
                      style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Icon(
                            Icons.calendar_month,
                            color: Color(0xFFb98715),
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: TextStyle(
                              color: Color(0xFFb98715),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Set a Time',
                      style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Icon(
                            Icons.alarm,
                            color: Color(0xFFb98715),
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          _selectedTime.format(context),
                          style: TextStyle(
                              color: Color(0xFFb98715),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                onTap: () async {
                  Map<String, dynamic> userBookingmap = {
                    "Service": widget.service,
                    "Date":
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                            .toString(),
                    "Time": _selectedTime.format(context).toString(),
                    "Username": name,
                    "Image": image,
                    "Email": email,
                  };
                  await DatabaseMethods()
                      .addUserBooking(userBookingmap)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Service Booked Successfully',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF252525),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'BOOK NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
