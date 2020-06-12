class Job{
  final String name;
  final dynamic ratePerHour;

  Job({this.name, this.ratePerHour});

  Map<String, dynamic> toMap(){
    return{
      'name' : name,
      'ratePratePerHour' : ratePerHour,
    };
  }
}