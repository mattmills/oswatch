String hour = "";
String minutes = "";
String seconds = "";

void displayDigital(unsigned long epoch, Adafruit_SharpMem display) {
  // clear the display every loop because the text lib doesn't
  display.fillRect(0, 0, 128, 128, 1);

  // draw the epoch
  display.setCursor(X_OFFSET + 1,Y_OFFSET);
  currentHour(epoch / 3600 % 12);
  currentMinute(epoch / 60 % 60);
  currentSecond(epoch % 60);
  display.print(hour+":"+minutes+" :"+seconds);

  // write out the display from memory
  display.refresh();
}

void currentHour(unsigned long h_number){
  if (h_number == 0){
    hour = String(12, DEC);
  }else if (h_number < 10){
    hour = "0" + String(h_number, DEC);
  }else {
    hour = String(h_number, DEC);
  }
}

void currentMinute(unsigned long m_number){
  if (m_number < 10){
    minutes = "0" + String(m_number, DEC);
  }else {
    minutes = String(m_number, DEC);
  }
}

void currentSecond(unsigned long m_number){
  if (m_number < 10){
    seconds = "0" + String(m_number, DEC);
  }else {
    seconds = String(m_number, DEC);
  }
}
