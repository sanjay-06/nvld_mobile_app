class Question{
  String question;
  String? image;
  List<String> options;
  int answer;
  int? selected;
  bool submitted=false;
  Question({required this.question,required this.answer,required this.options,this.image});
  
}