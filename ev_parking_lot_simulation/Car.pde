// ================= Car Object =================
class Car {
  int xpos, ypos;
  int w, h;
  int carType;
  color carColor, carColorCharge, carColorBattery;
  color textColor;
  String carInfo;
  float carChargeTime, carChargePrice, carBatteryTotal, carBatteryRemain;
  float chargeSpeed1, chargeSpeed2, chargeSpeed3;
  boolean pressed;
  Button btnStartCharge, btnPauseCharge, btnExitCharge;
  PImage carImg;
  int chargeMode;
  
  Car(int tempXpos, int tempYpos, int tempCarType, float tempCarBatteryRemain) {
    xpos = tempXpos;
    ypos = tempYpos;
    carType = tempCarType;
    carBatteryRemain = tempCarBatteryRemain;
    pressed = false;
    
    btnStartCharge = new Button(835, 70, "开始充电");
    btnPauseCharge = new Button(915, 70, "暂停充电");
    btnExitCharge = new Button(995, 70, "取消充电");
    
    chargeSpeed1 = 0.80;
    chargeSpeed2 = 0.65;
    chargeSpeed3 = 0.50;
    
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
    }
    
    w = 120;
    h = 60;
  }

  void display() {
    // the number of cells of each row and col
    int row = h/10;
    int col = w/10;
    int total = row * col;
    int remain = int(carBatteryRemain*total/carBatteryTotal);
    
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
    String strCarID = "您是第" + currentCarID + "号车";
    String strCarType = "您的车型是Type" + carType;
    String strChargeMode="";
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
    String strBatteryRemain = "剩余电量：" + carBatteryRemain; 
    String strBatteryTotal = "总共电量：" + carBatteryTotal;
    fill(50);
    text(strCarID, 840, 280);
    text(strCarType, 840, 300);
    text(strChargeMode, 840,320);
    text(strBatteryRemain, 840, 340);
    text(strBatteryTotal, 840, 360);
  }
  
  void showDetail() {
    // text must have fill color
    fill(50, 50, 50);
    text("欢迎来到电动汽车智能充电站！",850,50);
    // btn Sart Pause Exit Charge
    btnStartCharge.display();
    btnPauseCharge.display();
    btnExitCharge.display();

    // car Image
    image(carImg, 840, 130);
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
    if (chargeMode == 1) {
      if (carBatteryRemain < carBatteryTotal/3) {
        carBatteryRemain += chargeSpeed1;  // fast charge speed
      } else if (carBatteryRemain < 2*carBatteryTotal/3) {
        carBatteryRemain += chargeSpeed2;  // middle charge speed
      } else if (carBatteryRemain < carBatteryTotal) {
        carBatteryRemain += chargeSpeed3;
      }
    } else if (chargeMode == 2) {
      
    } else if (chargeMode == 3) {
      if (carBatteryRemain > 2*carBatteryTotal/3) {
        carBatteryRemain -= chargeSpeed1;
      } else if (carBatteryRemain > carBatteryTotal/3) {
        carBatteryRemain -= chargeSpeed2;
      } else if (carBatteryRemain > 0) {
        carBatteryRemain -= chargeSpeed3;
      }
    }
    
    
  }
}
