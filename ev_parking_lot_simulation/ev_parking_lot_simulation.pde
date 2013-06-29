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

// get the index of sorted cars by battery remain
float[] getArrayOfBatteryRemain() {
  float[] arrayBatteryRemain = new float[N];
  for (int i = 0; i<N; i++) {
    arrayBatteryRemain[i] = cars[i].carBatteryRemain;
  }
  return arrayBatteryRemain;
}

int[] getIndexOfBatteryRemain() {
  float[] arrayBatteryRemainOrigin = getArrayOfBatteryRemain();
  float[] arrayBatteryRemainSort = sort(arrayBatteryRemainOrigin);
  
  int[] index = new int[N];
  for (int i = 0; i<N; i++) { // sort
    for(int j=0; j<N; j++) { //origin
      if (arrayBatteryRemainSort[i] == arrayBatteryRemainOrigin[j]) {
        index[i] = j;
        break;
      }
    }
  }
  return index;
}

// pause all cars charging
void pauseAllCarsCharge() {
  for(int i = 0; i < N; i++) {
    cars[i].pauseCharge();
  }
}

// ================ Main Program ================
int N = 40;
int currentCarID;
int viewMode, chargeMode;
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

final int ChargeModeNone = 00;
final int ChargeModeDC = 11;
final int ReverseChargeDC = 12;
final int ChargeModeAC = 21;
final int ReverseChargeAC = 22;

int loop = 0;

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
    chargeMode = ChargeModeDC;
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
  // a car 300V  40 car 12kv 
  
  if (btnAllStartChargeAC.isPressed()) {   
    chargeMode = ChargeModeAC;
  }
/* test of batteryIndex *
    batteryIndex = getIndexOfBatteryRemain();
    for (int i=0;i<N;i++) {
      println("No"+i+" is: "+batteryIndex[i]);
    }
*/

/* reductant code *
    for (time=0; time < T/10; time++) {
      // all cars pause charge
      pauseAllCarsCharge();
      // sort and find the min 0.3 * N => sin(90/5)
      batteryIndex = getIndexOfBatteryRemain();
      for(int i=0; i<0.3*N; i++) {
        cars[batteryIndex[i]].startCharge();
      }
    }
    for (time=T/10; time < T/10*2; time++) {
      pauseAllCarsCharge();
      // sort and find the min 0.6 * N => sin(90/5*2)
      batteryIndex = getIndexOfBatteryRemain();
      for(int i=0; i<0.6*N; i++) {
        cars[batteryIndex[i]].startCharge();
      }
    }
    for (time=T/10*2; time < T/10*3; time++) {
      pauseAllCarsCharge();
      // sort and find the min 0.8 * N => sin(90/5*3)
      batteryIndex = getIndexOfBatteryRemain();
      for(int i=0; i<0.8*N; i++) {
        cars[batteryIndex[i]].startCharge();
      }
    }
    for (time=T/10*3; time < T/10*4; time++) {
      pauseAllCarsCharge();
      // sort and find the min 0.95 * N => sin(90/5*4)
      batteryIndex = getIndexOfBatteryRemain();
      for(int i=0; i<0.95*N; i++) {
        cars[batteryIndex[i]].startCharge();
      }
    }
    for (time=T/10*4; time < T/2; time++) {
      pauseAllCarsCharge();
      // sort and find the min 1.0 * N => sin(90)
      for(int i=0; i<N; i++) {
        cars[batteryIndex[i]].startCharge();
      }
    }
*/
    //while (chargeMode == ChargeModeAC) {
    
  
  
  if (chargeMode == ChargeModeAC) {
    int time = 0;
    int T = 400;
    int[] batteryIndex = new int[N];
    
    for (time = 0; time < T/2; time++) {    
      pauseAllCarsCharge();    
      batteryIndex = getIndexOfBatteryRemain();
      if (time < T/10) {
        for(int i=0; i<0.3*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/10 * 2) {
        for(int i=0; i<0.6*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/10*3) {
        for(int i=0; i<0.8*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/10*4) {
        for(int i=0; i<0.95*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/2) {
        for(int i=0; i<N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      }
    }
  
    for (time = T/2; time < T; time++) {
      pauseAllCarsCharge();
      batteryIndex = getIndexOfBatteryRemain();
      if (time < T/10*6) {
        for(int i=0; i<N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/10*7) {
        for(int i=0; i<0.95*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/10*8) {
        for(int i=0; i<0.8*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T/10*9) {
        for(int i=0; i<0.6*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      } else if (time < T) {
        for(int i=0; i<0.3*N; i++) {
          cars[batteryIndex[i]].startCharge();
        }
      }
    }
  }
  

  // different time different cars are reverse charging, altogether a AC wave, mmc
  if (btnAllReverseChargeAC.isPressed()) {
    chargeMode = ReverseChargeAC;
  }

  // pause all charging cars 
  if (btnAllPauseCharge.isPressed()) {
    viewMode = ViewModeCar;
    chargeMode = ChargeModeNone;
    pauseAllCarsCharge();
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
