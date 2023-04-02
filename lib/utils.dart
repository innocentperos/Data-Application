

String? formatAmount(double value){
  List<String> splitted = value.toString().split(".");
  String formatted = "";

  int count = splitted[0].length;
  int index = 0;
  for(int i =count -1 ; i != -1; i--){
    index +=1;
    formatted =  splitted[0][i] + formatted;
    if(index == 3 && i!= 0){
      index = 0;
      formatted = ",$formatted";
    }
  }
  return "$formatted.${splitted[1]}";
}