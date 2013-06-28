// ======== Main Program ==========
Button btnSetCharge, btnStartCharge, btnExitCharge, btnMenu, btnPauseCharge;

int viewMode;
boolean isCharge;

final int ViewModeMenu = 0;
final int ViewModeSet = 1;
final int ViewModeCharge = 2;


int currentCarID = int(random(40));

Car currentCar;

void setup() {

  orientation(PORTRAIT);
  background(255);
  PFont myFont = createFont("SimHei", 35);
  textFont(myFont);

  currentCar = new Car(width/2-100, 400, currentCarID%7, random(1000, 4000));
  viewMode = ViewModeMenu;
  isCharge = false;
  btnSetCharge = new Button(width/2+80, 700, "充电设置");
  btnStartCharge = new Button(width/2+80, 800, "开始充电");
  btnPauseCharge = new Button(width/2+80, 900, "暂停充电");
  btnExitCharge = new Button(width/2+80, 1000, "退出充电");
  // btnMenu = new Button(width/2, 400, "返回菜单");
}

void draw() {
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
void displayMenu() {
  
  btnSetCharge.display();
  btnStartCharge.display();
  btnPauseCharge.display();
  btnExitCharge.display();
}

void displayCharge() {
  currentCar.display();
   
}


void clearAll() {
  fill(255);
  rect(0,0,width,height);
}

void displayCarDetail() {

}
