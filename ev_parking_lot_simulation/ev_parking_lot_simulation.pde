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
  btnWave.display();
  btnAllStartChargeDC.display();
  btnAllReverseChargeDC.display();
  btnAllStartChargeAC.display();
  btnAllReverseChargeAC.display();
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
Button btnView, btnSimulate, btnWave, btnExit;
Button btnAllStartChargeDC, btnAllStartChargeAC, btnAllReverseChargeDC, btnAllReverseChargeAC, btnAllPauseCharge;
// btnAddCar, btnRemoveCar,
Car [] cars = new Car[N];
Gif mmcAnimation;
float totalChargeSpeed, totalReverseSpeed, totalBatteryRemain, totalBatteryCharge;
String strTotalChargeSpeed, strTotalReverseSpeed, strTotalBatteryRemain, strTotalBatteryCharge;
// define view mode
final int ViewModeCar = 1;
final int ViewModeSimulate = 2;
final int ViewModeWave = 3;


void setup() {
  size(1100, 680);
  background(255);
  PFont font = loadFont("SimHei-48.vlw");
  btnView = new Button(40, 30, "停车场"); 
  btnSimulate = new Button(120, 30, "原理示意");
  btnWave = new Button(200, 30, "波形分析");
  // TODO add or remove a car
  // btnAddCar = new Button(250, 30, "添加车辆");
  // btnRemoveCar = new Button(350, 30, "删除车辆");
  btnAllStartChargeDC = new Button(280, 30, "DC充电");
  btnAllReverseChargeDC = new Button(360, 30, "DC放电");
  btnAllStartChargeAC = new Button(440, 30, "AC充电");
  btnAllReverseChargeAC = new Button(520, 30, "AC放电");
  btnAllPauseCharge = new Button(600, 30, "全部暂停");
  btnExit = new Button(680, 30, "退出程序");

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
    viewMode = ViewModeCar;
  }

  if (viewMode == ViewModeCar) {
    clearMain();
    displayCars();
    clearDetail();
    showCarDetail();
    showAllDetail();
  }

  // charge at the same speed, altogether a DC voltage
  if (btnAllStartChargeDC.isPressed()) {
    for(int i = 0; i < N; i++) {
      cars[i].startCharge();
    }
  }

  // reverse charge at the same speed, altogether a DC voltage
  if (btnAllReverseChargeDC.isPressed()) {
    for(int i = 0; i < N; i++) {
      cars[i].reverseCharge();
    }
  }

  // different time different cars are charging, altogether a AC wave, mmc
  if (btnAllStartChargeAC.isPressed()) {


  }

  // different time different cars are reverse charging, altogether a AC wave, mmc
  if (btnAllReverseChargeAC.isPressed()) {

  }

  // pause all charging cars 
  if (btnAllPauseCharge.isPressed()) {
    for(int i = 0; i < N; i++) {
      cars[i].pauseCharge();
    }
  }


  // simulate mmc, gif from wiki
  if (btnSimulate.isPressed()) {
    viewMode = ViewModeSimulate;
    clearMain();
    clearDetail();
    image(mmcAnimation, 50, 100);
  }
  
  if (btnWave.isPressed()) {
    viewMode = ViewModeWave;
  }

  if (viewMode == ViewModeWave) {
    //TODO
    clearMain();
    clearDetail();
  }


  // exit button
  if (btnExit.isPressed()) {
    exit();
  }
}
