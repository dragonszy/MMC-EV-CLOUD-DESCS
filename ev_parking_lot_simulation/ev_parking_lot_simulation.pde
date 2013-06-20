import gifAnimation.*;

// ================= Button Object ===================
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
    w = 60;
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
  color carColor, carColorCharge, carColorBattery;
  color textColor;
  String carInfo;
  float carChargeTime, carChargePrice, carBatteryTotal, carBatteryRemain;
  boolean pressed;
  
  Car(int tempXpos, int tempYpos, int tempCarType, int tempCarBatteryRemain) {
    xpos = tempXpos;
    ypos = tempYpos;
    carType = tempCarType;
    carBatteryRemain = tempCarBatteryRemain;
    pressed = false;
    
    switch(carType) {
      case 0:
        carBatteryTotal = 5000;
        carColor = color(63, 63, 63);
        break;
      case 1:
        carBatteryTotal = 5500;
        carColor = color(63, 63, 127);
        break;
      case 2:
        carBatteryTotal = 6000;
        carColor = color(63, 63, 255);
        break;
      case 3:
        carBatteryTotal = 6500;
        carColor = color(63, 127, 63);
        break;
      case 4:
        carBatteryTotal = 7000;
        carColor = color(63, 255, 63);
        break;
      case 5:
        carBatteryTotal = 7500;
        carColor = color(127, 63, 63);
        break;
      case 6:
        carBatteryTotal = 7500;
        carColor = color(255, 63, 63);
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
    //int remain = int(carBatteryRemain*total/carBatteryTotal);
    int remain = 30;  // hardcode
    noFill();
    rect(xpos, ypos, w, h);
    // draw battery remain
    fill(carColor);
    for(int i = 0; i < remain; i++) {
      rect(xpos+i%col, ypos+i/col, 10, 10);
    }
    // draw battery total
    fill(carColor);
    for(int i = remain; i < total; i++) {
      rect(xpos+i%col, ypos+i/col, 10, 10);
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
  
  void showDetail() {
    // text must have fill color
    fill(50, 50, 50);
    text("Hello Strings!",850,50);
    
  }
  
}


// =============== Display Functions =================

void displayCars() {
  for (int i=0; i < N; i++) {
    cars[i].display();
  }
}

void displayMenu() {
  stroke(127, 127, 127);
  noFill();
  rect(20, 20, 800, 55);
  btnView.display();
  btnSimulate.display();
  btnAddCar.display();

  btnExit.display();

}

void displayMain() {
  stroke(127, 127, 127);
  noFill();
  rect(20, 90, 800, 570);
}

void clearMain() {
  stroke(127, 127, 127);
  fill(255, 255, 255);
  rect(20, 90, 800, 570);
}

void displayDetail() {
  stroke(127, 127, 127);
  noFill();
  rect(830, 20, 240, 640);
}

void clearDetail() {
  stroke(127, 127, 127);
  fill(255, 255, 255);
  rect(830, 20, 240, 640);
}

void showCarDetail() {
  for (int i=0; i<N; i++) {
    if (cars[i].isPressed()) {
      clearDetail(); 
      cars[i].showDetail();
    }
  }
}


// ================ Main Program ================
int N = 30;
Button btnView, btnSimulate, btnAddCar, btnExit;
Car [] cars = new Car[N];
Gif mmcAnimation;

void setup() {
  size(1100, 680);
  background(255);
  btnView = new Button(50, 30, "View"); 
  btnAddCar = new Button(150, 30, "Add");
  btnSimulate = new Button(250, 30, "Simu");
  btnExit = new Button(350, 30, "Exit");

  mmcAnimation = new Gif(this, "MMC-animation.gif");
  mmcAnimation.loop();
  
  int carNo, row, col;
  col = 5;
  row = N / 5;
  
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < col; j++) {
      carNo = i * col + j;
      cars[carNo] = new Car(50+j*150, 100+i*70, carNo%7, 2000);
    }
  }
}


void draw() {
  // display the layout of the app
  displayMenu();
  displayMain();
  displayDetail();
  
  // view all cars and show car detail
  if (btnView.isPressed()) {
    clearMain();
    displayCars();
  }
  showCarDetail();
  
  if (btnAddCar.isPressed()) {
    
  }

  // simulate mmc, gif from wiki
  if (btnSimulate.isPressed()) {
    clearMain();
    clearDetail();
    image(mmcAnimation, 50, 100);
  }
  
  // exit button
  if (btnExit.isPressed()) {
    exit();
  }
  
  
}
