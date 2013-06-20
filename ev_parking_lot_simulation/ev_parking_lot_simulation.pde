import gifAnimation.*;
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


// ================ Main Program ================
int N = 40;
int currentCarID;
int viewMode;
Button btnView, btnSimulate, btnAddCar, btnExit;
Car [] cars = new Car[N];
Gif mmcAnimation;

void setup() {
  size(1100, 680);
  background(255);
  PFont font = loadFont("SimHei-48.vlw");
  btnView = new Button(50, 30, "停车场"); 
  btnAddCar = new Button(150, 30, "添加车辆");
  btnSimulate = new Button(250, 30, "开始模拟");
  btnExit = new Button(350, 30, "退出程序");

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


void draw() {
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
  }

  
  if (btnAddCar.isPressed()) {
    // TODO
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
