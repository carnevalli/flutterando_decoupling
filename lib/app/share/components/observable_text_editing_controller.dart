import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ObservableTextEditingController extends TextEditingController with EquatableMixin{
  @override
  List<Object> get props => [text];

}