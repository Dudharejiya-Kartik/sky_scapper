import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/whether_provider.dart';
import '../search_page/search_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ));
            },
          ),
        ],
      ),
      body: Consumer<WhetherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.weather == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildLocationInfo(weatherProvider),
              const SizedBox(height: 16.0),
              _buildCurrentWeather(weatherProvider),
              const SizedBox(height: 16.0),
              _buildHourlyForecast(weatherProvider),
              const SizedBox(height: 16.0),
              _buildDailyForecast(weatherProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLocationInfo(WhetherProvider weatherProvider) {
    var location = weatherProvider.weather!.locationModal;
    return Card(
      child: ListTile(
        title: Text('${location.name}, ${location.region}'),
        subtitle:
            Text('${location.country} | Local Time: ${location.localtime}'),
      ),
    );
  }

  Widget _buildCurrentWeather(WhetherProvider weatherProvider) {
    var current = weatherProvider.weather!.currentModal;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Current Weather'),
            subtitle: Text('${current.conditionModel.text}'),
            trailing: Image.network('https:${current.conditionModel.icon}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('Temp'),
                    Text('${current.tempC} °C'),
                  ],
                ),
                Column(
                  children: [
                    const Text('Feels Like'),
                    Text('${current.feelsLikeC} °C'),
                  ],
                ),
                Column(
                  children: [
                    const Text('Humidity'),
                    Text('${current.humidity} %'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast(WhetherProvider weatherProvider) {
    var hourly =
        weatherProvider.weather!.weatherForecast.forecastday.first.hour;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            title: Text('Hourly Forecast'),
          ),
          Container(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourly.length,
              itemBuilder: (context, index) {
                var hour = hourly[index];
                return Container(
                  width: 60.0,
                  child: Column(
                    children: [
                      Text('${hour.time.split(' ')[1]}'),
                      Image.network('https:${hour.condition.icon}'),
                      Text('${hour.tempC} °C'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyForecast(WhetherProvider weatherProvider) {
    var daily = weatherProvider.weather!.weatherForecast.forecastday;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            title: Text('7-Day Forecast'),
          ),
          Column(
            children: daily.map((day) {
              return ListTile(
                title: Text('${day.date}'),
                leading: Image.network('https:${day.day.condition.icon}'),
                subtitle: Text('${day.day.condition.text}'),
                trailing: Column(
                  children: [
                    Text('Max: ${day.day.maxtempC} °C'),
                    Text('Min: ${day.day.mintempC} °C'),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class WeatherSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final weatherProvider =
        Provider.of<WhetherProvider>(context, listen: false);
    weatherProvider.fetchData();
    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final weatherProvider = Provider.of<WhetherProvider>(context);
    final suggestions = weatherProvider.list
        .where((location) =>
            location.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name),
          onTap: () {
            query = suggestions[index].name;
            showResults(context);
          },
        );
      },
    );
  }
}
