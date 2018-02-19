PImage CFrame;
int frameNum = 3268;
int cFrameID = 330;

float hueT = 40;
float staT = 20;
float brgT = 64;
int hlhue = 109;
int mode = 0; // 0 = HueHighlight, 1 = hueThreshold, 2 = saturationThreshold, 3 = brightnessThreshold  
color warnColor = color(255,0,0);

boolean EnableDetection = true;

public void setup () {
  size(1200, 800);
  background(0);
  textSize(15);
  colorMode(HSB, 255);
}


public void draw () {
  background(0);

  if (cFrameID >= frameNum) {cFrameID=1;} else {cFrameID++;}
  
  text("Frames: "+ cFrameID + "/"+ frameNum, 10, 740);
  text("Highlight Hue: " + hlhue + "/255", 10, 760);
  text("Hue Threshold < " + (int) hueT + "/255", 10, 780);
  text("Saturation Threshold > " + (int) staT + "/255", 210, 740);
  text("Brightness Threshold > " + (int) brgT + "/255", 210, 760);
  
  switch (mode) {
   case 0: 
    text("Hue Highlight", 1000, 740);
   break;
    case 1: 
    text("Hue Threshold", 1000, 740);
   break;
    case 2: 
    text("Saturation Threshold", 1000, 740);
   break;
    case 3: 
    text("Brightness Threshold", 1000, 740);
   break;
  }
  
  CFrame = loadImage("D:/raw_frames/frame"+cFrameID+".png");
  
  if (EnableDetection) {
  CFrame.loadPixels();
  
  int VirtualPointX = 0;
  int totalX = 0;
  int VirtualPointY = 0;
  int totalY = 0;
  
  for (int x = 0; x < 1200; x++) {
    for (int y = 0; y < 720; y++) {

      
      
      if(hue(CFrame.get(x,y)) < hueT) {
        
        if (saturation(CFrame.get(x,y)) > staT) {
          
          if(brightness(CFrame.get(x,y)) > brgT) {
            
            VirtualPointX = VirtualPointX + x;
            totalX++;
            
            VirtualPointY = VirtualPointY + y;
            totalY++;
            
            color highlight = color(hlhue, saturation(CFrame.get(x,y)), brightness(CFrame.get(x,y)));
            CFrame.set(x, y, highlight);
            
          }
        }
      }
      
    }
  }

  int TotalPixels = totalX+totalY;

   VirtualPointX = (int)Math.round(VirtualPointX/100)*100;
   VirtualPointY = (int)Math.round(VirtualPointY/100)*100;
   text("VirtualPoint X: " + (int) VirtualPointX/(totalX+1), 510, 760);
   text("VirtualPoint Y: " + (int) VirtualPointY/(totalY+1), 510, 740);
   text("Detected Pixels: " + TotalPixels, 700, 740);
   
   
  CFrame.updatePixels();
  }
  
  image(CFrame, 0, 0);
  
  

   
 
 

   text("FPS: " + Math.round(frameRate), 700, 760);

}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
    switch (mode) {
   case 0: 
      if (hlhue < 255 && hlhue > 0) {
    hlhue = hlhue + (int) e;
  } else {
    hlhue = 1;
  }
   break;
    case 1: 
      if (hueT < 255 && hueT > 0) {
    hueT = hueT + (int) e;
  } else {
    hueT = 1;
  }
   break;
    case 2: 
      if (staT < 255 && staT > 0) {
    staT = staT + (int) e;
  } else {
    staT = 1;
  }
   break;
    case 3: 
      if (brgT < 255 && brgT > 0) {
    brgT = brgT + (int) e;
  } else {
    brgT = 1;
  }
   break;
  }
  

}

void keyPressed(KeyEvent e) {
  if (keyCode == 69) {
    if (EnableDetection) {
     EnableDetection = false;
    } else {
     EnableDetection = true;
    }
  }
   if (keyCode == 70) {
     cFrameID = cFrameID + 10;
  }
   if (keyCode == 66) {
     if (cFrameID > 10) {
       cFrameID = cFrameID - 10;
     }
  }
  
}

void mouseClicked(MouseEvent e) {
  if (mode < 3) {
  mode++;
  } else {
  mode = 0;
  }
  
} 