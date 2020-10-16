import processing.pdf.*;
ArrayList<Rec> rects;
boolean rec = false;

void setup() {
  size(252, 360);
  generateModernism();
}

void generateModernism() {
  rects = new ArrayList<Rec>();
  int randomW;
  int remainingW = 0;
  int max = width-5;
  for (int y = 10; y < height-10; y+=20) {
    for (int x = 5; x < width-5; x+=randomW+5) {
      remainingW = width-x;
      randomW = int(random(10, max));
      if (randomW > remainingW || remainingW - randomW < 20) randomW = remainingW-5;
      rects.add(new Rec(x, y, randomW, 10, color(-1)));
      max = (width/int(random(1, 4))-5);
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) generateModernism();
  else if (mouseButton == RIGHT) rec = true;
}

void draw() {
  if (rec) beginRecord(PDF, "modernism_" + year() + "_" + month() + "_" + day() + "_" + 
    hour() + "_" + minute() + "_#######.pdf");
  background(0);
  for (Rec r : rects) r.draw();
  if (rec) {
    endRecord();
    rec = false;
  }
}

class Rec {
  float x, y, w, h;
  color col, cIdle, cOver;

  Rec(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    cIdle = c;
    cOver = color(185, 0, 0);
    col = cIdle;
  }

  void draw() {
    if (isOver(mouseX, mouseY)) {
      col = cOver;
    } else col = cIdle;
    noStroke();
    fill(col);
    rect(x, y, w, h, 5, 5, 5, 5);
  }

  boolean isOver(float xIn, float yIn) {
    if (xIn > x && xIn < x+w && yIn > y && yIn < y+h) return true;
    else return false;
  }
}
