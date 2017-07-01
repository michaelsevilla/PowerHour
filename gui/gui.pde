PowerHourPhase current, start, running;

int clockStart, clockPrev;
int nvids;
int TIMEOUT = 59;

String videos[];

class Button {
  int x, y, xlen, ylen;
  String txt;
  int ACTION;
  PImage background;

  Button(int x, int y, int xlen, int ylen, String txt, PImage bg, int ACTION) {
    this.x = x;
    this.y = y;
    this.xlen = xlen;
    this.ylen = ylen;
    this.txt = txt;
    background = bg;
    this.ACTION = ACTION;
  }

  boolean overButton() {
    if (mouseX > x && mouseX < x + xlen &&
        mouseY > y && mouseY < y + ylen) {
      return true;
    }
    return false;
  }

  // TODO: pass the function
  void buttonPressed() {
    if (ACTION == 0) {
      current = running;
      clockStart = second();
      clockPrev = 0;
    } else if (ACTION == 1) {
      current = start;
    } else if (ACTION == 2) {
      link("http://youtube.com");
    } else if (ACTION == 3) {
      clockStart = second();
    }
  }

  void drawButton() {
    // color the button
    if (overButton()) {
      fill(255);
    } else {
      noFill();
    }
 
    // draw button and center the text
    rect(x, y, xlen, ylen);
    fill(0);
    text(txt, x + xlen/2 - 7*(txt.length()/2), y + ylen/2);
  }

  void drawBackground() {
    if (overButton()) {
      background(background);
    }
  }
}

/*
 * What is pasted on the back wall of the phase
 * 
 * TODO: this should be an abstract class; or whatever you call it when you
 * *have* to implement the functions.
 */
class Screen { 
  void draw() {}
}

class CountdownScreen extends Screen {
  void draw() {
    fill(0);
    noStroke();

    float radius = min(width, height) / 2.2;
    float clockDiameter = radius * 1.8;
    float cx = width / 2;
    float cy = height / 2;
    ellipse(cx, cy, clockDiameter, clockDiameter);

    // calculus
    int fakeTime = second() - clockStart;
    if (fakeTime < 0)
      fakeTime = fakeTime + 60;
    float secondsRadius = radius * 0.72;
    for (int i = 0; i < fakeTime + 1; i++) {
      float s = map(i-1, 0, 60, 0, TWO_PI) - HALF_PI;
      line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
      stroke(0, 255, 0);
      strokeWeight(20);
    }

    // Draw a face
    stroke(0);
    strokeWeight(1);
    ellipse(width/2 + width/8, height/2 - height/8, 40, 40);
    ellipse(width/2 - width/8, height/2 - height/8, 40, 40);
    strokeWeight(40);
    line(width/2 + width/8, height/2 + height/8, width/2 - width/8, height/2 + height/8);
    stroke(0);
    strokeWeight(1);

    // Notify higher levels if we need to start a new vid
    if (clockPrev == 1){
      if (clockPrev != fakeTime) {
        clockPrev = fakeTime;
      }
      nvids++;
    }
    text(" Video # " + nvids + " Time: " + fakeTime, width/3, height-height/16);
  }
}

class RunningScreen extends Screen {
  void draw() {
    for (int i = 0; i < videos.length; i++)
      text(i + ": " + videos[i], 10, 110 + 10*i);

    fill(0);   
  }
}

class PowerHourPhase {
  Button[] buttons;
  Screen screen;
  
  PowerHourPhase(Button[] bs, Screen s) {
    buttons = bs;
    screen = s;
  }

  void draw() {
    screen.draw();
  
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].drawBackground();
    }
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].drawButton();
    }
  }

  void pressed() {
    // figure out who got tickled
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].overButton()) {
        buttons[i].buttonPressed();
      }
    }
  }
}

void setup() {
  size(292, 311);
  PImage msevilla = loadImage("msevilla.jpg");
  PImage rickmorty = loadImage("rickmorty.png");

  int m = 20; // margin: pixls from the edge
  int l = 75; // length: size of the square buttons

  Button[] sButtons = new Button[2];
  sButtons[0] = new Button(m, m, l, l, "run", msevilla, 0);
  sButtons[1] = new Button(m + sButtons[0].x + sButtons[0].xlen, m , l, l, "shuffle", rickmorty, 2);
  start = new PowerHourPhase(sButtons, new RunningScreen());

  m = 5;
  l = 53;
  Button[] rButtons = new Button[2];
  rButtons[0] = new Button(m, m, l, l, "cancel", msevilla, 1);
  rButtons[1] = new Button(width - m - l, m, l, l, "++time", rickmorty, 3);
  running = new PowerHourPhase(rButtons, new CountdownScreen());

  // Read the list of links
  videos = loadStrings("vids.txt");
  if (videos == null)
    exit();

  current = start;
  nvids = 0;
}

/*
 * Processing defined callbacks
 */
void draw() {
  background(204);
  current.draw();
}

void mousePressed() {
  current.pressed();
}
