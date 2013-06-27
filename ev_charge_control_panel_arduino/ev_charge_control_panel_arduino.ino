int redLightIn1 = 7;
int redLightIn2 = 6;
int relaySwitch1 = 9;
int relaySwitch2 = 8;

void setup() {
  pinMode(redLightIn1, INPUT);
  pinMode(redLightIn2, INPUT);
  pinMode(relaySwitch1, OUTPUT);
  pinMode(relaySwitch2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // if car comes, 1 -> 0
  int redLightState1 = digitalRead(redLightIn1);
  int redLightState2 = digitalRead(redLightIn2);
  
  if (redLightState1 == LOW) {
    delay(10);
    if (redLightState1 == LOW) {
      digitalWrite(relaySwitch1, LOW);
    }
  } else {
    delay(10);
    if (redLightState1 == HIGH) {
      digitalWrite(relaySwitch1, HIGH);
    }
  }

  if (redLightState2 == LOW) {
    delay(10);
    if (redLightState2 == LOW) {
      digitalWrite(relaySwitch2, LOW);
    }
  } else {
    delay(10);
    if (redLightState2 == HIGH) {
      digitalWrite(relaySwitch2, HIGH);
    }
  }


}
