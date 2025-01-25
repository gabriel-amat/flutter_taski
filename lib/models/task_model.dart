// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class TaskModel extends HiveObject {

  static const String boxKey = "taskModelKey";

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final bool done;

  TaskModel({
    required this.id,
    required this.title,
    required this.content,
    required this.done,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  TaskModel copyWith({
    String? id,
    String? title,
    String? content,
    bool? done,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      done: done ?? this.done,
    );
  }
}
