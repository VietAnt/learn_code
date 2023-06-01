part of 'general_bloc.dart';

//Todo: Sự_Kiện_Chung
class GeneralEvent extends Equatable {
  const GeneralEvent();

  @override
  List<Object> get props => [];
}

//Todo: ISScrollTopAppBarEvent: Sự_kiện_cuộn
class IsScrollTopAppBarEvent extends GeneralEvent {
  final bool isScroll; //Cuộn

  const IsScrollTopAppBarEvent(this.isScroll);
}
