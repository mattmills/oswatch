int hour_x[]= { 48, 51, 54, 57, 60, 63, 66, 68, 70, 72, 74, 75, 77, 77, 78, 78, 78, 77, 77, 75, 74, 72, 70, 68, 66, 63, 60, 57, 54, 51, 48, 45, 42, 39, 36, 33, 30, 28, 26, 24, 22, 21, 19, 19, 18, 18, 18, 19, 19, 21, 22, 24, 26, 28, 30, 33, 36, 39, 42, 45 };

int hour_y[]= { 18, 18, 19, 19, 21, 22, 24, 26, 28, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 68, 70, 72, 74, 75, 77, 77, 78, 78, 78, 77, 77, 75, 74, 72, 70, 68, 66, 63, 60, 57, 54, 51, 48, 45, 42, 39, 36, 33, 30, 28, 26, 24, 22, 21, 19, 19, 18 };

int minute_x[]= {48, 50, 52, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 74, 76, 78, 79, 81,82, 83, 84, 85, 86, 87, 88, 89, 89, 89, 90, 90, 90, 90, 90, 89, 89,89, 88, 87, 86, 85, 84, 83, 82, 81, 79, 78, 76, 74, 73, 71, 69, 67,65, 63, 61, 59, 57, 55, 52, 50, 48, 46, 44, 41, 39, 37, 35, 33, 31,29, 27, 25, 23, 22, 20, 18, 17, 15, 14, 13, 12, 11, 10, 9, 8, 7, 7,7, 6, 6, 6, 6, 6, 7, 7, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 20,22, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 44, 46 };

int minute_y[]= {6, 6, 6, 7, 7, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 20, 22, 23, 25,27, 29, 31, 33, 35, 37, 39, 41, 44, 46, 48, 50, 52, 55, 57, 59, 61,63, 65, 67, 69, 71, 73, 74, 76, 78, 79, 81, 82, 83, 84, 85, 86, 87,88, 89, 89, 89, 90, 90, 90, 90, 90, 89, 89, 89, 88, 87, 86, 85, 84,83, 82, 81, 79, 78, 76, 74, 73, 71, 69, 67, 65, 63, 61, 59, 57, 55,52, 50, 48, 46, 44, 41, 39, 37, 35, 33, 31, 29, 27, 25, 23, 22, 20,18, 17, 15, 14, 13, 12, 11, 10, 9, 8, 7, 7, 7, 6, 6 };

int x_outer_markers[]={69, 84, 90, 84, 69, 48, 27, 12, 6, 12, 27, 48};
int x_inner_markers[]={67, 80, 85, 80, 66, 48, 29, 16, 11, 16, 30, 48};
int y_outer_markers[]={12, 27, 48, 69, 84, 90, 84, 69, 48, 27, 12, 6};
int y_inner_markers[]={16, 30, 48, 67, 80, 85, 80, 66, 48, 29, 16, 11};


void displayAnalog(unsigned long epoch, Adafruit_SharpMem display) {
  display.fillRect(0, 0, 96, 96, 1);

  display.drawCircle(48, 48, 46, BLACK);
  drawMarkers(display);
  drawMinuteHand(epoch, display);
  drawHourHand(epoch, display);

  display.refresh();
}

void drawMinuteHand(long ms, Adafruit_SharpMem display){
  int minute = currentMinutePosition(ms);
  display.drawLine(47, 48, minute_x[minute]-1, minute_y[minute], BLACK);
  display.drawLine(48, 48, minute_x[minute], minute_y[minute], BLACK);
}

void drawHourHand(long ms, Adafruit_SharpMem display){
  int hour = currentHourPosition(ms);
  display.drawLine(47, 48, hour_x[hour]-1, hour_y[hour], BLACK);
  display.drawLine(48, 48, hour_x[hour], hour_y[hour], BLACK);
}


void drawMarkers(Adafruit_SharpMem display){
   for (int i=0; i <= 11; i++){
      display.drawLine(x_outer_markers[i], y_outer_markers[i], x_inner_markers[i], y_inner_markers[i], BLACK);
   }
}

int currentHourPosition(long epoch) {
  return epoch / 720 % 60;
}

int currentMinutePosition(long epoch){
  return (epoch / 30) % 120;
}
