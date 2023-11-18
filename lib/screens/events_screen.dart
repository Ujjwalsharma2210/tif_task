import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tif_task/models/event_model.dart';
import 'package:tif_task/utils/custom_search_delegate.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<dynamic> searchData = [];

  Future fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://sde-007.api.assignment.theinternetfolks.works/v1/event'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      Map<String, dynamic> data = json.decode(response.body);

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('E, MMM dd • hh:mm a').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _eventsScreenAppBar(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Use the data from the API to build a list
            Map<String, dynamic> data = snapshot.data;
            List<dynamic> events = data['content']['data'];
            searchData = events;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _openEventDetailsScreen(
                    // events, index,
                    events[index]['title'],
                    events[index]['description'],
                    events[index]['banner_image'],
                    events[index]['date_time'],
                    events[index]['organiser_name'],
                    events[index]['organiser_icon'],
                    events[index]['venue_name'],
                    events[index]['venue_city'],
                    events[index]['venue_country'],
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                    height: 106,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(87, 92, 138, 0.08),
                          offset: Offset(0, 10),
                          blurRadius: 35,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.normal,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 92,
                          width: 79,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.network(events[index]['organiser_icon']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                formatDateTime(events[index]['date_time']),
                                style: const TextStyle(
                                  color: Color.fromRGBO(86, 105, 255, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                events[index]['title'],
                                style: const TextStyle(
                                  color: Color.fromRGBO(18, 13, 38, 1),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    size: 17,
                                    color: Color.fromRGBO(116, 118, 136, 1),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 219,
                                    child: Text(
                                      events[index]['venue_name'] +
                                          " • " +
                                          events[index]['venue_city'] +
                                          ", " +
                                          events[index]['venue_country'],
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color.fromRGBO(116, 118, 136, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  AppBar _eventsScreenAppBar() {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Events",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => _search(),
            icon: Image.asset(
              'assets/search.png',
            )),
        IconButton(
            onPressed: () => _menu(),
            icon: Image.asset(
              'assets/more-vertical.png',
            )),
      ],
    );
  }

  void _search() {
    // Navigator.pushNamed(context, 'search_screen');
    print(searchData);
    showSearch(context: context, delegate: CustomSearchDelegate(searchData));
  }

  void _menu() {}

  _openEventDetailsScreen(
    // List<dynamic> events,
    // int index,
    String title,
    String description,
    String banner_image,
    String date_time,
    String organiser_name,
    String organiser_icon,
    String venue_name,
    String venue_city,
    String venue_country,
  ) {
    Event clickedEvent = Event(
      id: 0,
      title: title,
      description: description,
      bannerImage: banner_image,
      dateTime: date_time,
      organiserName: organiser_name,
      organiserIcon: organiser_icon,
      venueName: venue_name,
      venueCity: venue_city,
      venueCountry: venue_country,
    );
    Navigator.pushNamed(context, 'event_details_screen',
        arguments: clickedEvent);
  }
}
