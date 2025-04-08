PImage img;

String inputText = "";
boolean active = false;
int boxX = 385;
int boxY = 530;
int boxW = 365;
int boxH = 40; 
int baseUpdateInterval = 300; 
long lastUpdateTime = 0;
ArrayList<DigitAttributes> digitAttrs = new ArrayList<DigitAttributes>();
class DigitAttributes {
  float x, y;
  float size;
  color col;
  DigitAttributes(float x, float y, float size, color col) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.col = col;
  }
}

void setup() {
  size(1024, 819);
  img = loadImage("CPU.jpg");  
  textSize(20);               
  smooth();
}

void draw() {
  image(img, 0, 0);
  int effectiveInterval = max(50, baseUpdateInterval - inputText.length() * 10);
  if (millis() - lastUpdateTime > effectiveInterval) {
    digitAttrs.clear();
    for (int i = 0; i < inputText.length(); i++) {
      float rx = random(width);
      float ry = random(height);
      float rSize = random(10, 200);
      color neonBlue = color(0, 0, 255);
      color neonGreen = color(0, 255, 0);
      color chosen = random(1) < 0.5 ? neonBlue : neonGreen;
      digitAttrs.add(new DigitAttributes(rx, ry, rSize, chosen));
    }
    lastUpdateTime = millis();
  }
  for (int i = 0; i < inputText.length(); i++) {
    char c = inputText.charAt(i);
    if (Character.isLetter(c)) {
      char upc = Character.toUpperCase(c);
      int digit = (upc - 'A') % 10;  
      if (i < digitAttrs.size()) {
        DigitAttributes d = digitAttrs.get(i);
        pushStyle();
        textSize(d.size);
        fill(d.col);
        text(digit, d.x, d.y);
        popStyle();
      }
    }
  }

  fill(0);       
  textSize(20); 
  text(inputText, boxX + 5, boxY + boxH/2 + 7);
}

void mousePressed() {
  if (mouseX >= boxX && mouseX <= boxX + boxW &&
      mouseY >= boxY && mouseY <= boxY + boxH) {
    active = true;
  } else {
    active = false;
  }
}

void keyTyped() {
  if (active) {
    if (key != '\b') {
      inputText += key;
    }
  }
}

void keyPressed() {
  if (active) {
    if (keyCode == BACKSPACE && inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    }
    if (keyCode == DELETE) {
      inputText = "";
    }
  }
}
