part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}
class Clean extends SearchEvent {}

class Search extends SearchEvent {
  final String query;

  const Search({required this.query});

  @override
  List<Object> get props => [query];
}
