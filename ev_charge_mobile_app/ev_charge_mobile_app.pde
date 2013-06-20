// ======== Main Program ==========
Button btnSetCharge, btnStartCharge, btnExitCharge;

void setup() {
  size(400, 600);
  background(127);
  btnSetCharge = new Button(width/2, 50, "Set Charge");
  btnStartCharge = new Button(width/2, 150, "Start Charge");
  btnExitCharge = new Button(width/2, 250, "ExitCharge");
}

void draw() {
  btnSetCharge.display();
  btnStartCharge.display();
  btnExitCharge.display();
}


// ======== Button Class ===========
class Button {
  int xpos, ypos;
  int w, h;
  color buttonColor, buttonColorIn, buttonColorOut;
  color textColor;
  String t;
  boolean pressed;
  
  Button (int tempXpos, int tempYpos, String tempText) {
    xpos = tempXpos;
    ypos = tempYpos;
    w = 90;
    h = 35;
    buttonColorOut = color(200, 200, 200);
    buttonColorIn = color(230, 230, 230);
    buttonColor = buttonColorOut;
    textColor = color(50, 50, 50);
    t = tempText;
    pressed = false;
  }
  
  void display() {
    fill(buttonColor);
    rectMode(CENTER);
    rect(xpos, ypos, w, h);
    fill(textColor);
    textAlign(CENTER);
    text(t, xpos, ypos+0.3*h);
  }
  
  boolean isOver() {
    if (mouseX >= xpos && mouseX <= xpos+w && mouseY >= ypos && mouseY <= ypos+h) {
      buttonColor = buttonColorIn;
      return true;
    } else {
      buttonColor = buttonColorOut;
      return false;   
    }
  }
  
  boolean isPressed() {
    if (isOver() && mousePressed) {
      pressed = !pressed;
      return true;
    } else {
      return false;
    }
  }
}






