import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends Equatable {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [icon, title, description];
}
