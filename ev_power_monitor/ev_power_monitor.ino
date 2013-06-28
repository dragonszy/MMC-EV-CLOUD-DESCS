#include "LCD12864RSPI.h"
#define AR_SIZE(a) sizeof(a)/sizeof(a[0])

unsigned char strWelcome[] = "Welcome!";
unsigned char strPower1[] = "The Power is:";
unsigned char strPower2[4] = "";
unsigned char strCarIn1[] = "1 Charging";
unsigned char strCarOut1[] = "not Charging";
unsigned char strCarIn2[] = "2 Charging";
unsigned char strCarOut2[] = "not Charging";
int power = 0;
int carIn1 = 12;
int carIn2 = 13;

void setup() {
  pinMode(carIn1, INPUT);
  pinMode(carIn2, INPUT);
  LCDA.Initialise();
  delay(100);
}

void loop() {
  LCDA.CLEAR();
  delay(50);
  
  LCDA.DisplayString(0,1,strWelcome,AR_SIZE(strWelcome));
  if (digitalRead(carIn1)) {
    LCDA.DisplayString(1,1,strCarIn1,AR_SIZE(strCarIn1));
  } else {
    LCDA.DisplayString(1,1,strCarOut1,AR_SIZE(strCarOut1));
  }
  if (digitalRead(carIn2)) {
    LCDA.DisplayString(1,1,strCarIn2,AR_SIZE(strCarIn2));
  } else {
    LCDA.DisplayString(1,1,strCarOut2,AR_SIZE(strCarOut2));
  }
  LCDA.DisplayString(2,1,strPower1,AR_SIZE(strPower1));
  LCDA.DisplayString(3,1,strPower2,AR_SIZE(strPower2));
  
  
  delay(1000);
}
