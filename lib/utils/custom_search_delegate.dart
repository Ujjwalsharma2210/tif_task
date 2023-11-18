import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tif_task/models/event_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Event> searchTerms = [];
  // List<Event> listEvents = [];

  CustomSearchDelegate(List<dynamic> events) {
    for (int i = 0; i < events.length; i++) {
      searchTerms.add(Event(
        id: events[i]['id'],
        title: events[i]['title'],
        description: events[i]['description'],
        bannerImage: events[i]['banner_image'],
        dateTime: events[i]['date_time'],
        organiserName: events[i]['organiser_name'],
        organiserIcon: events[i]['organiser_icon'],
        venueName: events[i]['venue_name'],
        venueCity: events[i]['venue_city'],
        venueCountry: events[i]['venue_country'],
      ));
    }
    // print(searchTerms.length);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Event> matchQueryResults = [];
    for (var event in searchTerms) {
      if (event.title.toLowerCase().contains(query.toLowerCase()) ||
          event.venueCity.toLowerCase().contains(query.toLowerCase()) ||
          event.venueName.toLowerCase().contains(query.toLowerCase()) ||
          event.venueCountry.toLowerCase().contains(query.toLowerCase())) {
        matchQueryResults.add(event);
      }
    }

    return ListView.builder(
      itemCount: matchQueryResults.length,
      itemBuilder: (context, index) {
        var result = matchQueryResults[index];
        return _eventsListTile(context, result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Event> matchQuerySuggestions = [];
    for (var event in searchTerms) {
      if (event.title.toLowerCase().contains(query.toLowerCase()) ||
          event.venueCity.toLowerCase().contains(query.toLowerCase()) ||
          event.venueName.toLowerCase().contains(query.toLowerCase()) ||
          event.venueCountry.toLowerCase().contains(query.toLowerCase())) {
        matchQuerySuggestions.add(event);
      }
    }

    return ListView.builder(
      itemCount: matchQuerySuggestions.length,
      itemBuilder: (context, index) {
        var result = matchQuerySuggestions[index];
        return _eventsListTile(context, result);
      },
    );
  }

  GestureDetector _eventsListTile(BuildContext context, Event result) {
    return GestureDetector(
      onTap: () => _openEventDetalisScreen(context, result),
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
              child: Image.network(result.organiserIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    formatDateTime(result.dateTime),
                    style: const TextStyle(
                      color: Color.fromRGBO(86, 105, 255, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    result.title,
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
                          "${result.venueName} • ${result.venueCity}, ${result.venueCountry}",
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
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('E, MMM dd • hh:mm a').format(dateTime);
    return formattedDate;
  }

  void _openEventDetalisScreen(BuildContext context, Event event) {
    Navigator.pushNamed(context, 'event_details_screen', arguments: event);
  }
}
