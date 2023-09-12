// convert datetime obj into string
String convertDateTimeIntoString(DateTime datetime){
  String yyyy = datetime.year.toString();
  String mm = datetime.month.toString();
  String dd = datetime.day.toString();

  if(mm.length == 1){
    mm = '0$mm';
  }

  if(dd.length == 1){
    mm = '0$dd';
  }

  String yyyymmdd = yyyy + mm + dd;
  return yyyymmdd;
}