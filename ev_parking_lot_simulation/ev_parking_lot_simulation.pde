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
  btnAllStartCharge.display();
  btnAllReverseCharge.display();
  btnAllPauseCharge.display();
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

// show total detail - All Cars Stats
void showAllDetail() {
  
  totalChargeSpeed = 0;
  totalReverseSpeed = 0;
  totalBatteryRemain = 0;
  totalBatteryCharge = 0;
  for(int i = 0; i < N; i++) {
    totalChargeSpeed += cars[i].chargeSpeed;
    totalReverseSpeed += cars[i].reverseSpeed;
    totalBatteryRemain += cars[i].carBatteryRemain;
    totalBatteryCharge += (cars[i].carBatteryTotal-cars[i].carBatteryRemain);
  }

  strTotalChargeSpeed = "电网->停车场：" + totalChargeSpeed;
  strTotalReverseSpeed = "停车场->电网：" + totalReverseSpeed;
  strTotalBatteryRemain = "剩余总电量：" + totalBatteryRemain;
  strTotalBatteryCharge = "需冲总电量：" + totalBatteryCharge;

  text("停车场总体情况：", 840,500);
  text(strTotalChargeSpeed, 840, 520);
  text(strTotalReverseSpeed, 840, 540);
  text(strTotalBatteryRemain, 840, 560);
  text(strTotalBatteryCharge, 840, 580);

}


// ================ Main Program ================
int N = 40;
int currentCarID;
int viewMode;
Button btnView, btnSimulate, btnExit, btnAllStartCharge, btnAllPauseCharge, btnAllReverseCharge;
// btnAddCar, btnRemoveCar,
Car [] cars = new Car[N];
Gif mmcAnimation;
float totalChargeSpeed, totalReverseSpeed, totalBatteryRemain, totalBatteryCharge;
String strTotalChargeSpeed, strTotalReverseSpeed, strTotalBatteryRemain, strTotalBatteryCharge;

void setup() {
  size(1100, 680);
  background(255);
  PFont font = loadFont("SimHei-48.vlw");
  btnView = new Button(50, 30, "停车场"); 
  btnSimulate = new Button(150, 30, "开始模拟");
  // TODO add or remove a car
  // btnAddCar = new Button(250, 30, "添加车辆");
  // btnRemoveCar = new Button(350, 30, "删除车辆");
  btnAllStartCharge = new Button(250, 30, "全部充电");
  btnAllPauseCharge = new Button(350, 30, "全部暂停");
  btnAllReverseCharge = new Button(450, 30, "全部放电");
  btnExit = new Button(550, 30, "退出程序");

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
