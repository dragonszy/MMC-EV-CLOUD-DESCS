class Button {
  int xpos, ypos;
  int w, h;
  color buttonColor, buttonColorIn, buttonColorOut;
  color textColor;
  String t;
  
  Button (int tempXpos, int tempYpos, String tempText) {
    xpos = tempXpos;
    ypos = tempYpos;
    w = 60;
    h = 35;
    buttonColorOut = color(200, 200, 200);
    buttonColorIn = color(230, 230, 230);
    buttonColor = buttonColorOut;
    textColor = color(50, 50, 50);
    t = tempText;
  }
  
  void display() {
    fill(buttonColor);
    rect(xpos, ypos, w, h);
    fill(textColor);
    text(t, xpos+0.2*w, ypos+0.6*h);
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
      return true;
    } else {
      return false;
    }
  }
}

class Car {
  int xpos, ypos;
  int w, h;
  int carType;
  color carColor, carColorCharge, carColorBattery;
  color textColor;
  String carInfo;
  float carBatteryTotal, carBatteryRemain, carChargeTime, carChargePrice;
  
  Car(int tempXpos, int tempYpos, int tempCarType, float tempCarBatteryRemain, float tempCarChargePrice) {
    xpos = tempXpos;
    ypos = tempYpos;
    carType = tempCarType;
    carBatteryRemain = tempCarBatteryRemain;
    carChargePrice = tempCarChargePrice;
    if (carType == 1) {
      carBatteryTotal = 5000;
      carColor = color(127, 63, 63);
    } else if (carType == 2) {
      carBatteryTotal = 7000;
      carColor = color(63, 127, 63);
    } else if (carType == 3) {
      carBatteryTotal = 10000;
      carColor = color(63, 63, 127);
    }
    
    w = 140;
    h = 70;
  }

  void display() {
    fill(carColor);
    rect(xpos, ypos, w, h);
  }
}



Button btnView, btnSimulate, btnExit;
Car car1, car2, car3;

void setup() {
  size(960, 600);
  background(255);
  btnView = new Button(50,30,"View");
  btnSimulate = new Button(150,30,"Simu");
  btnExit = new Button(250,30,"Exit");
  car1 = new Car(50, 100, 1, 1000, 0.3);
  car2 = new Car(250, 100, 2, 2000, 0.2);
  car3 = new Car(450, 100, 3, 2500, 0.15);
}


void draw() {
  btnView.display();
  btnSimulate.display();
  btnExit.display();

  if (btnView.isPressed()) {
    car1.display();
    car2.display();
    car3.display();
  }
  
  if (btnSimulate.isPressed()) {
  
  }
  
  if (btnExit.isPressed()) {
    exit();
  }
}
