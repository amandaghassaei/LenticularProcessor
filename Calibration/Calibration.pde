
//variables
float statedLPI = 60;//LPI described by spec sheet
float statedDPI = 600;//dpi of printer, according to manufacturer
float calibrationRes = 0.1;//resolution of calibration tests, measured in LPI
int numTests = 8;//num tests (on each side of statedLPI)
int testStripHeight = 300;//px
int testStripWidth = 3000;//px

void setup(){
  
  int marginWidth = 600;
  
  size(3000+marginWidth, (numTests*2+1)*testStripHeight);
  background(255);
  textSize(140);
  fill(0);
  
  PImage output = createImage(testStripWidth, height, RGB);
  output.loadPixels();
  
  for (int index=-numTests;index<=numTests;index++){
    float delta = float(index)*calibrationRes;
    float lpi = statedLPI+delta;
    text(lpi, 20, (index+numTests)*testStripHeight+190);
    float pxPerLenticular = statedDPI/lpi;
    int offset = (index+numTests)*testStripWidth*testStripHeight;
    for (int i=0;i<testStripWidth*testStripHeight;i++){
      int x = i%testStripWidth;
      color pxColor = color(255,255,255);
      if (x%pxPerLenticular>=pxPerLenticular/2) pxColor = color(0,0,0);
      output.pixels[i+offset] = pxColor;
    }
  }
  
  
  
  output.updatePixels();
  image(output,marginWidth,0);
  
  save("CalbrationImg.png");
  println("finished");
  exit();
}

void draw(){
}
