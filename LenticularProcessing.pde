

//variables to change
int LPI = 60;//number of lenticulars per inch - this is a spec of the lectucular sheet
int printerDPI = 600;//dpi of printer
String filename = "michael/michael";
String extension = ".png";//filetype of source images
int numImgs = 2;//number of source images -> (printerDPI/LPI)/numImgs should be an integer

void setup(){
  
  int index = 0;
  PImage img = loadImage(filename+index+extension);
  size(img.width,img.height);
  println("image size: " + width + " x " + height + " px");
  
  PImage output = createImage(width, height, RGB);
  output.loadPixels();
  
  if (printerDPI%LPI > 0) {
    println("printer DPI " + printerDPI + " is not divisible by LPI " + LPI);
    exit();
    return;
  }
  int pxPerLenticular = printerDPI/LPI;
  if (width%pxPerLenticular > 0) {
    println("image width " + width + "px is not divisible by px per lenticular " + pxPerLenticular + "px, please crop image to multiple of " + pxPerLenticular + "px");
    exit();
    return;
  }
  if (pxPerLenticular%numImgs > 0) {
    println("number of images " + numImgs + " is not a factor of px per lenticular " + pxPerLenticular + "px");
    exit();
    return;
  }
  println("pixels per lenticular: " + pxPerLenticular);
    
  int pxPerImg = pxPerLenticular/numImgs;
  for (index=0;index<pxPerLenticular;index++){
    int fileNum = floor(index/pxPerImg);
    img = loadImage(filename+fileNum+extension);
    if (img.width != width || img.height != height){
      println("images should all be the same size, please fix");
      exit();
      return;
    }
    blurImage(img, output, index, pxPerLenticular);
    println(int((index+1)/float(pxPerLenticular)*100) + "% complete");
  }
  
  output.updatePixels();
  image(output,0,0);
  save(filename+"Processed.png");
  println("finished");
//  exit();
}

void blurImage(PImage img, PImage output, int index, int blurWidth){
  img.loadPixels();
  for (int i=0;i<img.width*img.height/blurWidth;i++){
    int mean[] = {0,0,0};
    for (int j=0;j<blurWidth;j++){
      mean[0] += red(img.pixels[i*blurWidth+j]);
      mean[1] += green(img.pixels[i*blurWidth+j]);
      mean[2] += blue(img.pixels[i*blurWidth+j]);
    }
    mean[0] /= blurWidth;
    mean[1] /= blurWidth;
    mean[2] /= blurWidth;
    output.pixels[i*blurWidth+index] = color(mean[0], mean[1], mean[2]);
  }
}


void draw(){
}
