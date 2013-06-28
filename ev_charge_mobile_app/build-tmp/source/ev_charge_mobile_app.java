import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ev_charge_mobile_app extends PApplet {

// ======== Main Program ==========
Button btnSetCharge, btnStartCharge, btnExitCharge, btnMenu, btnPauseCharge;

int viewMode;
boolean isCharge;

final int ViewModeMenu = 0;
final int ViewModeSet = 1;
final int ViewModeCharge = 2;


int currentCarID = PApplet.parseInt(random(40));

Car currentCar;

public void setup() {
  size(400, 600);
  background(255);
  PFont font = loadFont("SimHei-48.vlw");

  currentCar = new Car(width/2-100, 200, currentCarID%7, random(1000, 4000));
  viewMode = ViewModeMenu;
  isCharge = false;
  btnSetCharge = new Button(width/2+40, 360, "\u5145\u7535\u8bbe\u7f6e");
  btnStartCharge = new Button(width/2+40, 410, "\u5f00\u59cb\u5145\u7535");
  btnPauseCharge = new Button(width/2+40, 460, "\u6682\u505c\u5145\u7535");
  btnExitCharge = new Button(width/2+40, 510, "\u9000\u51fa\u5145\u7535");
  // btnMenu = new Button(width/2, 400, "\u8fd4\u56de\u83dc\u5355");
}

public void draw() {
  clearAll();
  // set charge button text
  if (btnStartCharge.isPressed()) {
    isCharge = true;
  }
  if (btnPauseCharge.isPressed()) {
    isCharge = false;
  }


  currentCar.showInfo();
  displayMenu();
  currentCar.display();
  // display Menu Buttons
  /*
  if (viewMode == ViewModeMenu) {
    currentCar.showInfo();
	  displayMenu();
  }
  // display Charge 
  if (viewMode == ViewModeCharge) {
    currentCar.showInfo();
    displayMenu();
    currentCar.display();
  }
  */
  // setting view mode
	if (btnSetCharge.isPressed()) {

	}
  // charge view mode
	

  if (isCharge == true) {
    currentCar.updateBattery();
  }

	if (btnExitCharge.isPressed()) {
	  exit();
  }
}


// ========= Main functions ============
public void displayMenu() {
  
  btnSetCharge.display();
  btnStartCharge.display();
  btnPauseCharge.display();
  btnExitCharge.display();
}

public void displayCharge() {
  currentCar.display();
   
}


public void clearAll() {
  fill(255);
  rect(0,0,width,height);
}

public void displayCarDetail() {

}

// ================= Button Object ===================
class Button {
  int xpos, ypos;
  int w, h;
  int buttonColor, buttonColorIn, buttonColorOut;
  int textColor;
  String t;
  boolean pressed;
  
  Button (int tempXpos, int tempYpos, String tempText) {
    xpos = tempXpos;
    ypos = tempYpos;
    w = 70;
    h = 35;
    buttonColorOut = color(200, 200, 200);
    buttonColorIn = color(230, 230, 230);
    buttonColor = buttonColorOut;
    textColor = color(50, 50, 50);
    t = tempText;
    pressed = false;
  }
  
  public void display() {
    fill(buttonColor);
    rect(xpos, ypos, w, h);
    fill(textColor);
    text(t, xpos+0.2f*w, ypos+0.6f*h);
  }
  
  public boolean isOver() {
    if (mouseX >= xpos && mouseX <= xpos+w && mouseY >= ypos && mouseY <= ypos+h) {
      buttonColor = buttonColorIn;
      return true;
    } else {
      buttonColor = buttonColorOut;
      return false;   
    }
  }
  
  public boolean isPressed() {
    if (isOver() && mousePressed) {
      pressed = !pressed;
      return true;
    } else {
      return false;
    }
  }
}
// ================= Car Object =================
class Car {
  int xpos, ypos;
  int w, h;
  int carType;
  int carColor, carColorCharge, carColorBattery;
  int textColor;
  float carChargeTime, carBatteryTotal, carBatteryRemain;
  float chargeSpeed1, chargeSpeed2, chargeSpeed3, chargeSpeed;
  float reverseSpeed1, reverseSpeed2, reverseSpeed3, reverseSpeed;
  float chargePrice1, chargePrice2, chargePrice3, chargePrice, totalChargePrice;
  boolean pressed;
  Button btnStartCharge, btnPauseCharge, btnReverseCharge, btnExitCharge;
  PImage carImg;
  int chargeMode;
  String strCarID, strCarType, strChargeMode, strBatteryRemain, strBatteryTotal, strTimeRemain, strChargePrice;
  int offset;
  Car(int tempXpos, int tempYpos, int tempCarType, float tempCarBatteryRemain) {
    xpos = tempXpos;
    ypos = tempYpos;
    carType = tempCarType;
    carBatteryRemain = tempCarBatteryRemain;
    pressed = false;
    
    btnStartCharge = new Button(860, 70, "\u5f00\u59cb\u5145\u7535");
    btnPauseCharge = new Button(970, 70, "\u6682\u505c\u5145\u7535");
    btnReverseCharge = new Button(860, 120, "\u53cd\u5411\u5145\u7535");
    btnExitCharge = new Button(970, 120, "\u53d6\u6d88\u5145\u7535");

    totalChargePrice = 0;
    chargePrice1 = 0.05f;
    chargePrice2 = 0.04f;
    chargePrice3 = 0.03f;
    
    chargeSpeed1 = 1.30f;
    chargeSpeed2 = 1.00f;
    chargeSpeed3 = 0.60f;
    reverseSpeed1 = 1.40f;
    reverseSpeed2 = 1.20f;
    reverseSpeed3 = 1.00f;
    
    chargeMode = 0;

    offset = 140;
    
    switch(carType) {
      case 0:
        carBatteryTotal = 5000;
        carColor = color(63, 63, 63);
        carImg = loadImage("car1.png");
        break;
      case 1:
        carBatteryTotal = 5500;
        carColor = color(63, 63, 127);
        carImg = loadImage("car2.png");
        break;
      case 2:
        carBatteryTotal = 6000;
        carColor = color(63, 63, 255);
        carImg = loadImage("car3.png");
        break;
      case 3:
        carBatteryTotal = 6500;
        carColor = color(63, 127, 63);
        carImg = loadImage("car4.png");
        break;
      case 4:
        carBatteryTotal = 7000;
        carColor = color(63, 255, 63);
        carImg = loadImage("car5.png");
        break;
      case 5:
        carBatteryTotal = 8500;
        carColor = color(127, 63, 63);
        carImg = loadImage("bus1.png");
        break;
      case 6:
        carBatteryTotal = 9000;
        carColor = color(255, 63, 63);
        carImg = loadImage("bus2.png");
        break;
      default:
        carBatteryTotal = 9000;
        carColor = color(255, 63, 63);
        carImg = loadImage("bus2.png");
        break;
    }
    
    w = 200;
    h = 100;
  }

  public void display() {
    // the number of cells of each row and col
    int row = h/10;
    int col = w/10;
    int total = row * col;
    int remain = PApplet.parseInt(carBatteryRemain*total/carBatteryTotal);
    int offset1 = 0;
    noFill();
    rect(xpos-offset1, ypos, w, h);  // draw total
    // draw battery remain
    fill(carColor);
    for(int i = 0; i < remain; i++) {
      rect(xpos-offset1+i%col*10, ypos+i/col*10, 10, 10);
    }
    // draw battery remain to total
    fill(carColor,63);
    for(int i = remain; i < total; i++) {
      rect(xpos-offset1+i%col*10, ypos+i/col*10, 10, 10);
    }
  }
  
  public boolean isOver() {
    if (mouseX >= xpos && mouseX <= xpos+w && mouseY >= ypos && mouseY <= ypos+h) {
      return true;
    } else {
      return false;   
    }
  }
  
  public boolean isPressed() {
    if (isOver() && mousePressed) {
      pressed = !pressed;
      return true;
    } else {
      return false;
    }
  }
  
  public void showInfo() {
    strCarID = "\u60a8\u662f\u7b2c" + currentCarID + "\u53f7\u8f66";
    strCarType = "\u60a8\u7684\u8f66\u578b\u662fType" + carType;
    strChargeMode="";
    switch(chargeMode) {
      case 1:
        strChargeMode = "\u60a8\u7684\u6c7d\u8f66\u72b6\u6001\uff1a\u6b63\u5728\u5145\u7535";
        break;
      case 2:
        strChargeMode = "\u60a8\u7684\u6c7d\u8f66\u72b6\u6001\uff1a\u6682\u505c\u5145\u7535";
        break;
      case 3:
        strChargeMode = "\u60a8\u7684\u6c7d\u8f66\u72b6\u6001\uff1a\u53cd\u5411\u5145\u7535";
        break;
      case 0:
        strChargeMode = "\u60a8\u7684\u6c7d\u8f66\u72b6\u6001\uff1a\u9000\u51fa\u5145\u7535";
        break;
    }
    strBatteryRemain = "\u5269\u4f59\u7535\u91cf\uff1a" + carBatteryRemain; 
    strBatteryTotal = "\u603b\u5171\u7535\u91cf\uff1a" + carBatteryTotal;
    strTimeRemain = "\u5269\u4f59\u65f6\u95f4\uff1a" + (carBatteryTotal-carBatteryRemain)/chargeSpeed/15 + " \u5206\u949f";
    strChargePrice = "\u5145\u7535\u82b1\u8d39\uff1a" + totalChargePrice + " \u5143";

    fill(50);
    image(carImg, width/2-100, 30);
    text(strCarID, width/2-offset, 400);
    text(strCarType, width/2-offset, 420);
    text(strChargeMode, width/2-offset,440);
    text(strBatteryRemain, width/2-offset, 460);
    text(strBatteryTotal, width/2-offset, 480);
    text(strTimeRemain, width/2-offset, 500);
    text(strChargePrice, width/2-offset, 520);
  }
  
  public void showDetail() {
    // text must have fill color
    fill(50, 50, 50);
    text("\u6b22\u8fce\u6765\u5230\u7535\u52a8\u6c7d\u8f66\u667a\u80fd\u5145\u7535\u7ad9\uff01",850,50);
    // btn Sart Pause Exit Charge
    btnStartCharge.display();
    btnPauseCharge.display();
    btnReverseCharge.display();
    btnExitCharge.display();

    // car Image
    image(carImg, 840, 180);
    // car detail Info
    showInfo();
  }
  
  public void startCharge() {
    chargeMode = 1;
  }
  
  public void pauseCharge() {
    chargeMode = 2;
  }
  
  public void reverseCharge() {
    chargeMode = 3;
  }
  
  public void exitCharge() {
    chargeMode = 0;
  }
  
  public void updateBattery() {
    if (carBatteryRemain < carBatteryTotal/3) {
      chargeSpeed = chargeSpeed1;  // fast charge speed
      chargePrice = chargePrice1;
    } else if (carBatteryRemain < 2*carBatteryTotal/3) {
      chargeSpeed = chargeSpeed2;  // middle charge speed
      chargePrice = chargePrice2;
    } else if (carBatteryRemain < carBatteryTotal) {
      chargeSpeed = chargeSpeed3;
      chargePrice = chargePrice3;
    } else {
      chargeSpeed = 0;  
      chargePrice = 0;
    }
    carBatteryRemain += chargeSpeed;
    totalChargePrice += chargePrice;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ev_charge_mobile_app" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
