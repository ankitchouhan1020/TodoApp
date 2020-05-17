class Task{
  List<Task> tasks;
  String note;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  String taskId;
  String title;

  Task({this.taskId, this.title, this.completed, this.deadline});
}