int redLightIn1 = 7;
int redLightIn2 = 6;
int relaySwitch1 = 9;
int relaySwitch2 = 8;
int carStatus1, carStatus2;  // 1 for in, and 0 for out
int carIn1 = 2;
int carIn2 = 3;

void setup() {
  pinMode(redLightIn1, INPUT);
  pinMode(redLightIn2, INPUT);
  pinMode(relaySwitch1, OUTPUT);
  pinMode(relaySwitch2, OUTPUT);
  pinMode(carIn1, OUTPUT);
  pinMode(carIn2, OUTPUT);
  digitalWrite(relaySwitch1, LOW);
  digitalWrite(relaySwitch2, LOW);
  digitalWrite(carIn1, LOW);
  digitalWrite(carIn2, LOW);
  Serial.begin(9600);
}

void loop() {
  // if car comes, 1 -> 0
  int redLightState1 = digitalRead(redLightIn1);
  int redLightState2 = digitalRead(redLightIn2);
  // test
  delay(20);
  Serial.println(redLightState2);
  
  if (redLightState1 == LOW) {
    delay(50);
    if (redLightState1 == LOW) {
      carStatus1 = 1;  // car in
    }
  } else {
    delay(50);
    if (redLightState1 == HIGH) {
      carStatus1 = 0; // car out
    }
  }

  if (redLightState2 == LOW) {
    delay(50);
    if (redLightState2 == LOW) {
      carStatus2 = 1;  // car in
    }
  } else {
    delay(50);
    if (redLightState2 == HIGH) {
      carStatus2 = 0;  // car out
    }
  }

  if (carStatus1 == 1) {
    digitalWrite(relaySwitch1, HIGH);
    digitalWrite(carIn1, HIGH);
  } else {
    digitalWrite(relaySwitch1, LOW);
    digitalWrite(carIn1, LOW);
  }
  if (carStatus2 == 1) {
    digitalWrite(relaySwitch2, HIGH);
    digitalWrite(carIn2, HIGH);
  } else {
    digitalWrite(relaySwitch2, LOW);
    digitalWrite(carIn2, LOW);
  }

}
