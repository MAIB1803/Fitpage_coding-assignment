import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/criteria_bloc.dart';
import 'criteria_detail.dart';

class CriteriaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CriteriaBloc, CriteriaState>(
        builder: (context, state) {
          if (state is CriteriaLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CriteriaLoaded) {
            final criteria = state.criteria;
            return Center(
              child: Container(
                width: 400,
                height: 400,
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: criteria.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        criteria[index].name,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text(
                        criteria[index].tag,
                        style: TextStyle(
                          color: criteria[index].color == 'green'
                              ? Colors.green
                              : criteria[index].color == 'red'
                                  ? Colors.red
                                  : Colors.yellow,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CriteriaDetail(criteria: criteria[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(child: Text('Failed to load criteria'));
          }
        },
      ),
    );
  }
}
