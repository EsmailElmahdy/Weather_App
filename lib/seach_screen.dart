import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/Country_List.dart'; 
import 'package:untitled8/home_screen.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  List<String> countries = helper.countriesCoordinates.keys.toList(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(countries),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              helper.Country = countries[index];
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            title: Text(countries[index]),
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<String> items;

  MySearchDelegate(this.items);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResultsList(context);
  }

  Widget _buildResultsList(BuildContext context) {
    List<String> matchQuery = [];
    
    for (var item in items) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]),
          onTap: () {
            helper.Country = matchQuery[index]; 
            Navigator.pop(context, matchQuery[index]); 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()), 
            );
          },
        );
      },
    );
  }
}
