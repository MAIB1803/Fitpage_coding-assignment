import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/criteria_bloc.dart';
import 'repositories/criteria_repository.dart';
import 'screens/criteria_list.dart';

void main() {
  final CriteriaRepository criteriaRepository = CriteriaRepository();
  runApp(MyApp(criteriaRepository: criteriaRepository));
}

class MyApp extends StatelessWidget {
  final CriteriaRepository criteriaRepository;

  MyApp({required this.criteriaRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Scan App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white, fontSize: 16),
          bodyText2: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      home: BlocProvider(
        create: (context) =>
            CriteriaBloc(fetchCriteria: criteriaRepository.fetchCriteria)
              ..add(FetchCriteria()),
        child: CriteriaList(),
      ),
    );
  }
}
