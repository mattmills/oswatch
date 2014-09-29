#include "Main.h"
#include <Wire.h>
#include "RTClib.h"

#include <Adafruit_GFX.h>
#include <Adafruit_SharpMem.h>
#include <RFduinoBLE.h>

#define SCK 6
#define MOSI 5
#define SS 4

RTC_DS1307 rtc;

#define BLACK 0
#define WHITE 1

#define Y_OFFSET 34
#define X_OFFSET 5

uint8_t offsetSeconds;

Adafruit_SharpMem display(SCK, MOSI, SS);

void setup(){
  display.begin();
  display.clearDisplay();
  display.setTextSize(4);
  display.setTextColor(BLACK);

  Wire.beginOnPins(2,3);

  if (! rtc.isrunning()) {
    rtc.adjust(DateTime(__DATE__, __TIME__));
  }

  RFduinoBLE.txPowerLevel = -20;
  RFduinoBLE.advertisementData = "r";
  RFduinoBLE.begin();
}

void loop(){
    DateTime now = rtc.now();
    if (offsetSeconds < 1){
      displayAnalog(now, display);
    }else{
      displayDigital(now.unixtime(), display);
    }
    RFduino_ULPDelay(200);
    // delay(100);
}

void RFduinoBLE_onConnect(bool start)
{
  if (start)
    display.setCursor(0,0);
}

void RFduinoBLE_onReceive(char *data, int len) {
  if (len >= 3){
    uint8_t hours = data[0];
    uint8_t minutes = data[1];
    uint8_t seconds = data[2];

    offsetSeconds = seconds;
  }
}
