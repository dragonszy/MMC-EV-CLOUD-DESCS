// ================= Car Object =================
class Car {
  int xpos, ypos;
  int w, h;
  int carType;
  color carColor, carColorCharge, carColorBattery;
  color textColor;
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
    
    btnStartCharge = new Button(860, 70, "开始充电");
    btnPauseCharge = new Button(970, 70, "暂停充电");
    btnReverseCharge = new Button(860, 120, "反向充电");
    btnExitCharge = new Button(970, 120, "取消充电");

    totalChargePrice = 0;
    chargePrice1 = 0.05;
    chargePrice2 = 0.04;
    chargePrice3 = 0.03;
    
    chargeSpeed1 = 1.30;
    chargeSpeed2 = 1.00;
    chargeSpeed3 = 0.60;
    reverseSpeed1 = 1.40;
    reverseSpeed2 = 1.20;
    reverseSpeed3 = 1.00;
    
    chargeMode = 0;

    offset = 300;
    
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
    
    w = 400;
    h = 200;
  }

  void display() {
    // the number of cells of each row and col
    int row = h/10;
    int col = w/10;
    int total = row * col;
    int remain = int(carBatteryRemain*total/carBatteryTotal);
    int offset1 = 100;
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
  
  boolean isOver() {
    if (mouseX >= xpos && mouseX <= xpos+w && mouseY >= ypos && mouseY <= ypos+h) {
      return true;
    } else {
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
  
  void showInfo() {
    strCarID = "您是第" + currentCarID + "号车";
    strCarType = "您的车型是Type" + carType;
    strChargeMode="";
    switch(chargeMode) {
      case 1:
        strChargeMode = "您的汽车状态：正在充电";
        break;
      case 2:
        strChargeMode = "您的汽车状态：暂停充电";
        break;
      case 3:
        strChargeMode = "您的汽车状态：反向充电";
        break;
      case 0:
        strChargeMode = "您的汽车状态：退出充电";
        break;
    }
    strBatteryRemain = "剩余电量：" + carBatteryRemain; 
    strBatteryTotal = "总共电量：" + carBatteryTotal;
    strTimeRemain = "剩余时间：" + (carBatteryTotal-carBatteryRemain)/chargeSpeed/15 + " 分钟";
    strChargePrice = "充电花费：" + totalChargePrice + " 元";

    fill(50);
    image(carImg, width/2-200, 100);
    text(strCarID, width/2-offset, 750);
    text(strCarType, width/2-offset, 810);
    text(strBatteryRemain, width/2-offset, 870);
    text(strBatteryTotal, width/2-offset, 930);
    text(strTimeRemain, width/2-offset, 990);
    text(strChargePrice, width/2-offset, 1050);
  }
  
  void showDetail() {
    // text must have fill color
    fill(50, 50, 50);
    text("欢迎来到电动汽车智能充电站！",850,50);
    // btn Sart Pause Exit Charge
    btnStartCharge.display();
    btnPauseCharge.display();
    btnReverseCharge.display();
    btnExitCharge.display();

    // car Image
    image(carImg, 840, 220);
    // car detail Info
    showInfo();
  }
  
  void startCharge() {
    chargeMode = 1;
  }
  
  void pauseCharge() {
    chargeMode = 2;
  }
  
  void reverseCharge() {
    chargeMode = 3;
  }
  
  void exitCharge() {
    chargeMode = 0;
  }
  
  void updateBattery() {
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
