import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tif_task/models/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({
    super.key,
  });
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Event clickedEvent =
        ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      body: _eventDetailsBody(clickedEvent, context),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Column _eventDetailsBody(Event clickedEvent, BuildContext context) {
    return Column(
      children: [
        _eventDetailsAppBar(clickedEvent, context),
        ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                clickedEvent.title,
                style: const TextStyle(
                    color: Color.fromRGBO(18, 13, 38, 1),
                    fontSize: 35,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          clickedEvent.organiserIcon,
                          height: 54,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            clickedEvent.organiserName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(13, 12, 38, 1)),
                          ),
                          const Text(
                            "Organizer",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(112, 110, 143, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/Date.png',
                          height: 54,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            formatDate(clickedEvent.dateTime),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(13, 12, 38, 1)),
                          ),
                          Text(
                            formatTime(clickedEvent.dateTime),
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(112, 110, 143, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/Location.png',
                          height: 54,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            clickedEvent.venueName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(13, 12, 38, 1)),
                          ),
                          Text(
                            "${clickedEvent.venueCity}, ${clickedEvent.venueCountry}",
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(112, 110, 143, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 30, bottom: 15),
              child: Text(
                "About Event",
                style: TextStyle(
                    color: Color.fromRGBO(18, 13, 38, 1),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                clickedEvent.description,
                style: const TextStyle(
                    color: Color.fromRGBO(18, 13, 38, 1),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Stack _eventDetailsAppBar(Event clickedEvent, BuildContext context) {
    return Stack(
      children: [
        Image.network(
          clickedEvent.bannerImage,
          width: MediaQuery.of(context).size.width,
        ),
        AppBar(
          title: const Text(
            "Event Details",
            style: TextStyle(
              // color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/fav-icon.png',
                    )),
              ),
            )
          ],
        ),
      ],
    );
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);
    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('EEEE, hh:mm a').format(dateTime);
    return formattedDate;
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _bookNowClicked(),
      backgroundColor: const Color.fromARGB(255, 71, 100, 246),
      label: const Text(
        "BOOK NOW",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      icon: Image.asset('assets/arrow.png'),
    );
  }

  void _bookNowClicked() {}
}
