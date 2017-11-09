
import java.sql.ResultSet;

void controlEvent(ControlEvent theEvent) {
   if(interfaceReady){
       if(theEvent.isFrom("checkboxMon") ||
          theEvent.isFrom("checkboxDay")){
          submitQuery();  
       }
   
       if(theEvent.isFrom("Temp") ||
          theEvent.isFrom("Wind")){
         //submitQuery();
         queryReady = true;
       }
   
       if(theEvent.isFrom("Submit")) {
          submitQuery();
       }
   
       if(theEvent.isFrom("Close")){
          closeAll();
       }
   }
}

void submitQuery(){
  
  // ######################################################################## //
  // Finish this:
  // write down the sql, given the constraints from the interface
  // ######################################################################## //
  ArrayList<String> monthDisplay = new ArrayList<String>();
  
  for (int i = 0; i < checkboxMon.getArrayValue().length; i++) {
        int n = (int)checkboxMon.getArrayValue()[i];
        if(n == 1){
          monthDisplay.add(months[i].toLowerCase());
        }
  }
  
  // concatenate months to add to sql query
  String months = "(";
  for (int i = 0; i < monthDisplay.size(); i++) {
    if (i == monthDisplay.size() - 1) months += "'" + monthDisplay.get(i)+ "'";
    else months += "'" + monthDisplay.get(i)+ "'" + ", ";
  }
  months += ")";
  println(months);

  ArrayList<String> dayDisplay = new ArrayList<String>();
  for (int i = 0; i < checkboxDay.getArrayValue().length; i++) {
        int n = (int)checkboxDay.getArrayValue()[i];
        if(n == 1){
          dayDisplay.add(days[i].toLowerCase());
        }
  }
  
  String days = "(";
  for (int i = 0; i < dayDisplay.size(); i++) {
    if (i == dayDisplay.size() - 1) days += "'" + dayDisplay.get(i)+ "'";
    else days += "'" + dayDisplay.get(i)+ "'" + ", ";
  }
  days += ")";
  println(days);

  float maxTemp = rangeTemp.getHighValue();
  float minTemp = rangeTemp.getLowValue();
  
  float maxHum = rangeHumidity.getHighValue();
  float minHum = rangeHumidity.getLowValue();
 
  float maxWind = rangeWind.getHighValue();
  float minWind = rangeWind.getLowValue(); 

  String sql = "SELECT id, temp, humidity, month, day, wind, x, y FROM forestfire WHERE month IN " + months + " AND day IN " + days + ";";
  println(sql);
  
  try{
      ResultSet rs = (ResultSet)DBHandler.exeQuery(sql);
      toTable(rs);
  }catch (Exception e){
      println(e.toString());
  }  
}

void toTable(ResultSet rs){
    if(rs == null){
       println("In EventHandler, ResultSet is empty!");
       return;
    }
    int rsSize = -1;
    table.clearRows();
    tableChange = true;
    try{
         rs.beforeFirst();
         int count  = 0;
       while(rs.next()){
         count++;
         TableRow newRow = table.addRow();
         newRow.setInt("id", rs.getInt("id"));

         newRow.setString("X", rs.getString("x"));
         newRow.setString("Y", rs.getString("y"));
         newRow.setString("Month", rs.getString("month"));
         newRow.setString("Day", rs.getString("day"));
         newRow.setFloat("Temp", rs.getFloat("temp"));   
         newRow.setFloat("Humidity", rs.getFloat("humidity"));   
         newRow.setFloat("Wind", rs.getFloat("wind"));  
     }
    }catch (Exception e){
       println(e.toString());
    }finally{
        try{
            rs.close();
        }catch(Exception ex){
            println(ex.toString());
        }
    }
}

void closeAll(){
    DBHandler.closeConnection();
    frame.dispose();
    exit();
}