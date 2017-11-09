int xMax = -1; 
float[] xMinMax = new float[2];
int yMax = -1;
float[] yMinMax = new float[2];

color pointColor = color(49,130,189,150);
color pointColorMouseOn = color(3,78,123,128);
color flagColor = color(218,219,240,160);

int pointSize = 6;
int pointSizeMouseOn = 10;
int marginCanvas = 50;

void draw() {
  drawCanvas();
  drawAxes();
  strokeWeight(pointSize);
  stroke(pointColor);
  if(table != null){
      for(int i = 0; i < table.getRowCount(); i++){
        TableRow row = table.getRow(i); //<>//
        
        float x = row.getFloat(1);
        float y = row.getFloat(2);
        
        stroke(pointColor);
        point(xScale(x), yScale(y)); 
    }
    
    tableChange = false;
  }
  hover();
  strokeWeight(1);
}

float xScale(float x){
    float step = (height - 2 * marginCanvas) / float(xMax);
    return (x * step + marginCanvas);
}

float yScale(float y){
    float step = (height - 2 * marginCanvas) / float(yMax);
    return height - y * step - marginCanvas;
}

void drawAxes(){
    stroke(0);
    fill(0);
    line(xScale(0),yScale(0),xScale(0), yScale(yMax));
    text("X", xScale(5), yScale(-0.6));
    line(xScale(0),yScale(0),xScale(xMax), yScale(0));
    text("Y", xScale(-0.6), yScale(5));
 
    for(int i = 1; i <= xMax; i++){
        stroke(240);
        line(xScale(float(i)),yScale(0),xScale(float(i)), yScale(yMax));
        fill(0);
        text(i, xScale(i),yScale(-0.3));  
    }
    
    for(int i = 1; i <= yMax; i++){
        stroke(240);
        line(xScale(0), yScale(float(i)), xScale(xMax), yScale(float(i)));
        fill(0);
        text(i, xScale(-0.2),yScale(float(i)));  
    }
}

void hover(){
    if(table != null){
        for(int i = 0; i < table.getRowCount(); i++){
            
        // ######################################################################## //
        // Finish this:
        // finish the hover function
        // we go through each point to check if the mouse is on a point
        // you need to figure out 
        // a) what are the X and Y values for a point
        // b) where is that point on the canvas
        // c) if the mouse is on the point and give the condition to the if statement

        //
        // remember to give tX and tY the place where the point is so that the following 
        // code will automatically draw it for you

        // tops: a) the xScale and yScale functions should be helpful
        //       b) the size of the points is pointSize
        // ######################################################################## //

            TableRow row = table.getRow(i);
            float tX = xScale(row.getFloat(1));
            float tY = yScale(row.getFloat(2));

            if(dist(mouseX, mouseY, tX, tY) < pointSize){
                     strokeWeight(pointSizeMouseOn);
                     stroke(pointColorMouseOn);
                     point(tX, tY); 
                     fill(flagColor);   
                     noStroke();
                     rect(tX - textSizeSmall * 3.5, tY - textSizeSmall * 4.5, textSizeSmall * 7, textSizeSmall * 4);
                     fill(color(3,78,123));
                     textSize(textSizeSmall);
                     text("Temp: " + row.getFloat("Temp"), tX, tY - textSizeSmall * 3);
                     text("Humi: " + row.getFloat("Humidity"), tX, tY - textSizeSmall * 2);
                     text("Wind: " + row.getFloat("Wind"), tX, tY - textSizeSmall);
                     break;               
               }       
        }   
    }
}

void mouseReleased() {
  if (queryReady == true) {
      submitQuery();
      queryReady = false;
  }
}