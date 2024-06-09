import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/criteria.dart';

// Events
abstract class CriteriaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCriteria extends CriteriaEvent {}

// States
abstract class CriteriaState extends Equatable {
  @override
  List<Object> get props => [];
}

class CriteriaInitial extends CriteriaState {}

class CriteriaLoading extends CriteriaState {}

class CriteriaLoaded extends CriteriaState {
  final List<Criteria> criteria;

  CriteriaLoaded(this.criteria);

  @override
  List<Object> get props => [criteria];
}

class CriteriaError extends CriteriaState {
  final String message;

  CriteriaError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class CriteriaBloc extends Bloc<CriteriaEvent, CriteriaState> {
  final Future<List<Criteria>> Function() fetchCriteria;

  CriteriaBloc({required this.fetchCriteria}) : super(CriteriaInitial()) {
    on<FetchCriteria>((event, emit) async {
      emit(CriteriaLoading());
      try {
        final criteria = await fetchCriteria();
        emit(CriteriaLoaded(criteria));
      } catch (e) {
        emit(CriteriaError(e.toString()));
      }
    });
  }
}
