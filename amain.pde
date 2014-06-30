#include "Main.h"
#include <Adafruit_GFX.h>
#include <Adafruit_SharpMem.h>

#define SCK 2
#define MOSI 5
#define SS 4

#define BLACK 0
#define WHITE 1

#define Y_OFFSET 28
#define X_OFFSET 4


unsigned long epoch = 0;

uint8_t offsetHours = 7;
uint8_t offsetMinutes = 46;
int sensorPin = 6;    // select the input pin for the buttons
int sensorValue = 0;
volatile int faceId = 2;

Adafruit_SharpMem display(SCK, MOSI, SS);

void setup(){
  Serial.begin(9600);
  Serial.println("Hello!");

  // start & clear the display
  display.begin();
  display.clearDisplay();
  display.setTextSize(3);
  display.setTextColor(BLACK);
  pinMode(6, INPUT);
  attachPinInterrupt(6, changeFace, HIGH);
}

void loop(){
  noInterrupts ();
    epoch = millis() / 1000 + offsetHours*3600 + offsetMinutes*60;
    long face = faceId;  // get value set by ISR

  if (face % 2 == 0){
    displayDigital(epoch, display);
  }else{
    displayAnalog(epoch, display);
  }
  delay(100);
  interrupts ();
}

int changeFace(uint32_t){
  noInterrupts ();
    faceId++;
  interrupts ();
}
