
void initSetting(){
    setMaxMin("Temp", rangeTempValue);
    setMaxMin("Humidity", rangeHumidityValue);
    setMaxMin("Wind", rangeWindValue);
    setMaxMin("X", xMinMax);
    xMax = round(xMinMax[1] + 0.5);
    setMaxMin("Y", yMinMax);
    yMax = round(yMinMax[1] + 0.5);
    setTable();
}

void setMaxMin(String str, float[] array){
  String sql1 = "select min(" + str + ") from " + table_name;
  String sql2 = "select max(" + str + ") from " + table_name;
  ResultSet rs1 = null;
  ResultSet rs2 = null;
  try{
      rs1 = (ResultSet)DBHandler.exeQuery(sql1);
      rs1.beforeFirst();
      float f = -1;
  while(rs1!= null && rs1.next()){
     f = rs1.getFloat(1);
  }
  
  array[0] = f;
  
  rs2 = (ResultSet)DBHandler.exeQuery(sql2);
  rs2.beforeFirst();
  
  while(rs2!=null && rs2.next()){
     f = rs2.getFloat(1);
  }
     array[1] = f;
          
  }catch(Exception e){
      println(e.toString());
  }finally{
     try{
        if(rs1 != null)
            rs1.close();
        if(rs2 != null) 
            rs2.close(); 
     }catch(Exception ex){
        println(ex.toString());
     } 
  }
}

void setTable(){
  table = new Table();
  
  table.addColumn("id");
  table.addColumn("X");
  table.addColumn("Y");
  table.addColumn("xJitter");
  table.addColumn("yJitter");
  table.addColumn("Month");
  table.addColumn("Day");
  table.addColumn("Temp");
  table.addColumn("Humidity");
  table.addColumn("Wind");
}