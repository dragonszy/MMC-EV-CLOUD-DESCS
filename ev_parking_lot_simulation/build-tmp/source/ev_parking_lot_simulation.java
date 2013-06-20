import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ev_parking_lot_simulation extends PApplet {


// =============== Display Functions =================

public void displayCars() {
  for (int i=0; i < N; i++) {
    cars[i].display();
  }
}

public void displayMenu() {
  stroke(127, 127, 127);
  noFill();
  rect(20, 20, 800, 55);
  btnView.display();
  btnSimulate.display();
  btnAllStartCharge.display();
  btnAllReverseCharge.display();
  btnAllPauseCharge.display();
  btnExit.display();

}

public void displayMain() {
  stroke(127, 127, 127);
  noFill();
  rect(20, 90, 800, 570);
}

public void clearMain() {
  stroke(127, 127, 127);
  fill(255, 255, 255);
  rect(20, 90, 800, 570);
}

public void displayDetail() {
  stroke(127, 127, 127);
  noFill();
  rect(830, 20, 240, 640);
}

public void clearDetail() {
  stroke(127, 127, 127);
  fill(255, 255, 255);
  rect(830, 20, 240, 640);
}

public void showCarDetail() {
  for (int i=0; i<N; i++) {
    if (cars[i].isPressed()) {      
      currentCarID = i;
      break;
    }
  }
  // select box of car percent 
  noFill();
  strokeWeight(2);
  stroke(255,0,0);
  rect(cars[currentCarID].xpos,cars[currentCarID].ypos,cars[currentCarID].w,cars[currentCarID].h);
  // reset stroke
  strokeWeight(1);
  stroke(127);
    
  cars[currentCarID].showDetail();
    
  if (cars[currentCarID].btnStartCharge.isPressed()) {
    cars[currentCarID].startCharge();
  }
  if (cars[currentCarID].btnPauseCharge.isPressed()) {
    cars[currentCarID].pauseCharge();
  }
  if (cars[currentCarID].btnReverseCharge.isPressed()) {
    cars[currentCarID].reverseCharge();
  }
  if (cars[currentCarID].btnExitCharge.isPressed()) {
    cars[currentCarID].exitCharge();
  }
}

// show total detail - All Cars Stats
public void showAllDetail() {
  float totalChargeSpeed, totalReverseSpeed;
  totalChargeSpeed = 0;
  totalReverseSpeed = 0;
  for(int i = 0; i < N; i++) {
    totalChargeSpeed += cars[i].chargeSpeed;
    totalReverseSpeed += cars[i].reverseSpeed;
  }

  String strTotalChargeSpeed = "\u7535\u7f51->\u505c\u8f66\u573a\uff1a" + totalChargeSpeed;
  String strTotalReverseSpeed = "\u505c\u8f66\u573a->\u7535\u7f51\uff1a" + totalReverseSpeed;

  text(strTotalChargeSpeed, 840, 430);
  text(strTotalReverseSpeed, 840, 450);

}


// ================ Main Program ================
int N = 40;
int currentCarID;
int viewMode;
Button btnView, btnSimulate, btnExit, btnAllStartCharge, btnAllPauseCharge, btnAllReverseCharge;
// btnAddCar, btnRemoveCar,
Car [] cars = new Car[N];
Gif mmcAnimation;

public void setup() {
  size(1100, 680);
  background(255);
  PFont font = loadFont("SimHei-48.vlw");
  btnView = new Button(50, 30, "\u505c\u8f66\u573a"); 
  btnSimulate = new Button(150, 30, "\u5f00\u59cb\u6a21\u62df");
  // TODO add or remove a car
  // btnAddCar = new Button(250, 30, "\u6dfb\u52a0\u8f66\u8f86");
  // btnRemoveCar = new Button(350, 30, "\u5220\u9664\u8f66\u8f86");
  btnAllStartCharge = new Button(250, 30, "\u5168\u90e8\u5145\u7535");
  btnAllPauseCharge = new Button(350, 30, "\u5168\u90e8\u6682\u505c");
  btnAllReverseCharge = new Button(450, 30, "\u5168\u90e8\u653e\u7535");
  btnExit = new Button(550, 30, "\u9000\u51fa\u7a0b\u5e8f");

  mmcAnimation = new Gif(this, "MMC-animation.gif");
  mmcAnimation.loop();
  
  int carNo, row, col;
  col = 5;
  row = N / 5;
  
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < col; j++) {
      carNo = i * col + j;
      // car xpos ypos type batteryremain
      cars[carNo] = new Car(50+j*150, 100+i*70, carNo%7, random(1000,4000)); 
    }
  }
}


public void draw() {
  // display the layout of the app
  displayMenu();
  displayMain();
  displayDetail();

  // update battery
  for (int i=0; i < N; i++) {
    cars[i].updateBattery();
  }
  
  // view all cars and show car detail
  if (btnView.isPressed()) {
    viewMode = 1;
  }

  if (viewMode == 1) {
    clearMain();
    displayCars();
    clearDetail();
    showCarDetail();
    showAllDetail();
  }

  if (btnAllStartCharge.isPressed()) {
    for(int i = 0; i < N; i++) {
      cars[i].startCharge();
    }
  }

  if (btnAllPauseCharge.isPressed()) {
    for(int i = 0; i < N; i++) {
      cars[i].pauseCharge();
    }
  }

  if (btnAllReverseCharge.isPressed()) {
    for(int i = 0; i < N; i++) {
      cars[i].reverseCharge();
    }
  }


  // simulate mmc, gif from wiki
  if (btnSimulate.isPressed()) {
    viewMode = 2;
    clearMain();
    clearDetail();
    image(mmcAnimation, 50, 100);
  }
  


  // exit button
  if (btnExit.isPressed()) {
    exit();
  }
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
  String carInfo;
  float carChargeTime, carChargePrice, carBatteryTotal, carBatteryRemain;
  float chargeSpeed1, chargeSpeed2, chargeSpeed3, chargeSpeed;
  float reverseSpeed1, reverseSpeed2, reverseSpeed3, reverseSpeed;
  boolean pressed;
  Button btnStartCharge, btnPauseCharge, btnReverseCharge, btnExitCharge;
  PImage carImg;
  int chargeMode;
  
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
    
    chargeSpeed1 = 1.30f;
    chargeSpeed2 = 1.00f;
    chargeSpeed3 = 0.60f;
    reverseSpeed1 = 1.40f;
    reverseSpeed2 = 1.20f;
    reverseSpeed3 = 1.00f;
    
    chargeMode = 0;
    
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
    
    w = 120;
    h = 60;
  }

  public void display() {
    // the number of cells of each row and col
    int row = h/10;
    int col = w/10;
    int total = row * col;
    int remain = PApplet.parseInt(carBatteryRemain*total/carBatteryTotal);
    
    noFill();
    rect(xpos, ypos, w, h);  // draw total
    // draw battery remain
    fill(carColor);
    for(int i = 0; i < remain; i++) {
      rect(xpos+i%col*10, ypos+i/col*10, 10, 10);
    }
    // draw battery remain to total
    fill(carColor,63);
    for(int i = remain; i < total; i++) {
      rect(xpos+i%col*10, ypos+i/col*10, 10, 10);
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
    String strCarID = "\u60a8\u662f\u7b2c" + currentCarID + "\u53f7\u8f66";
    String strCarType = "\u60a8\u7684\u8f66\u578b\u662fType" + carType;
    String strChargeMode="";
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
    String strBatteryRemain = "\u5269\u4f59\u7535\u91cf\uff1a" + carBatteryRemain; 
    String strBatteryTotal = "\u603b\u5171\u7535\u91cf\uff1a" + carBatteryTotal;
    fill(50);
    text(strCarID, 840, 330);
    text(strCarType, 840, 350);
    text(strChargeMode, 840,370);
    text(strBatteryRemain, 840, 390);
    text(strBatteryTotal, 840, 410);
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
    switch(chargeMode) {
      case 1:  // start
        if (carBatteryRemain < carBatteryTotal/3) {
          chargeSpeed = chargeSpeed1;  // fast charge speed
        } else if (carBatteryRemain < 2*carBatteryTotal/3) {
          chargeSpeed = chargeSpeed2;  // middle charge speed
        } else if (carBatteryRemain < carBatteryTotal) {
          chargeSpeed = chargeSpeed3;
        } else {
          exitCharge();
        }
        reverseSpeed = 0;
        carBatteryRemain += chargeSpeed;
        break;
      case 2:  // pause
        break;
      case 3:  // reverse
        if (carBatteryRemain > 2*carBatteryTotal/3) {
          reverseSpeed = reverseSpeed1;
        } else if (carBatteryRemain > carBatteryTotal/3) {
          reverseSpeed = reverseSpeed2;
        } else if (carBatteryRemain > 10) {
          reverseSpeed = reverseSpeed3;
        } else {
          exitCharge();
        }
        chargeSpeed = 0;
        carBatteryRemain -= reverseSpeed;
        break;
      case 0: // exit
        break;
      default:
        break;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ev_parking_lot_simulation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
