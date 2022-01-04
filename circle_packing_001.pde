//  R.A. Robertson 2012.03 "Circle Packing 3" ~ www.rariora.org ~
// Original code online at: http://www.openprocessing.org/sketch/57325
// modified by Rupert Russell 31 July 2014
float x, y, r, minR, maxR, radii, distance; // Location, radius parameters, and distance.
Circle[] circleList = new Circle[1];
boolean toggleLoop = true;
color ground = #ff0000;   // Background color.
color colorTest;          // Checks if XY are inside or outside of Circles, using background color.
boolean colorOK;          // Sets boolean from colorTest.
int maxCircles = 5000;    // Limit number of Circles. Too high, and program will freeze.
int fileNumber;           // increment file name each save
 
void setup() {
//  frame.setTitle("Circle Packing");
  float base = 720, aspect = 2;  // Window handling properties.

  size(1320, 1120);
  frameRate(2200);
  background(ground);
  stroke(0, 0, 0);
  colorMode(HSB, 100);
  
  smooth();
  ellipseMode(RADIUS);
  circleList[0] = new Circle(0, 0, 0);  // Set first Circle at origin, no dimension.
  minR = .15;  // Increase minimum radius value to concentrate packing away from window edges.
  maxR = 1600;
}
 
void draw() {
//  noLoop();
  r = random(minR, maxR);  // Radius set.
  x = constrain(random(width), r, width - r);  // XY set w/in window boundaries.
  y = constrain(random(height), r, height - r);
  colorOK = true;  // Boolean set.
  colorTest = get(int(x), int(y));  // Test if landing on background color.
 
  colorOK = (colorTest == ground) ? true : false;  // If XY not on background, relocate.
    while (!colorOK) {
      x = constrain(random(width), r, width - r);
      y = constrain(random(height), r, height - r);
      colorTest = get(int(x), int(y));
      colorOK = (colorTest == ground) ? true : false;
      r--;                         // Optional. Reduce R to fill in, esp. near edges.
      r = constrain(r, .1, maxR);  // If NOT using, may need to reduce maxCircles.
    }
 
  // Find distance to all Circles in list. If XY too close, reset R.
  if (colorOK) {
    for (int i = 0; i < circleList.length; i++) {
      distance = dist(x, y, circleList[i].x, circleList[i].y);
      radii = circleList[i].r + r;  // Combined R values.
      if (distance < radii) {  // Distance not ok (Circles overlap).
        r = distance - circleList[i].r;  // Reset R.
        strokeWeight(.35);
        // line(x, y, circleList[i].x, circleList[i].y);  // Optional connector lines.
      }
    }
  }
   
// Draw Circle.
strokeWeight(1);
circleList = (Circle[]) append(circleList, new Circle(x, y, r));
   
if ((circleList.length - 1) % maxCircles == 0) { noLoop(); }  // Limit Circle count.
     
//  println(frameCount + "  " + (circleList.length - 1) + "  " + frameRate);
}
 
/* ======================= Circle Class ======================= */
 
class Circle {
  float x, y, r;
  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    fill(random(100),100,100);
    ellipse(x, y, r, r);  // Turn off and run with lines only for variety.
  }
}
 
/* =======================       UI       ======================= */
 
void mousePressed() {
  if (mouseButton == LEFT) {
    if (toggleLoop) {
      noLoop();
      toggleLoop = false;
    }
    else {
      loop();
      toggleLoop = true;
    }
    
  }
   if (mouseButton == RIGHT) {
      
      save("cirlce_packing_" + fileNumber + ".png");
      fileNumber ++;
 }
}

void mouseWheel(MouseEvent event) {
     circleList = new Circle[1];  // clear circle list
     setup();  // clear screen
} 
