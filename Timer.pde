class Timer {
  int startTime = 0, stopTime = 0;
  int duration;
  boolean running = false;  
  
  Timer(int seconds)
  {
    duration = seconds * 1000;
  }
    
    void start() {
        startTime = millis();
        running = true;
    }
    
    void stop() {
        stopTime = millis();
        running = false;
    }
    
    int getElapsedTime() {
        int elapsed;
        if (running) {
             elapsed = (millis() - startTime);
        }
        else {
            elapsed = (stopTime - startTime);
        }
        return elapsed;
    }
    
    boolean done()
    {
      stopTime = millis();
   
      return getElapsedTime() >= duration;
    }
    
    void setDuration(int seconds)
    {
      duration = seconds * 1000;
    }
    
    int second() {
      return (getElapsedTime() / 1000) % 60;
    }
    int minute() {
      return (getElapsedTime() / (1000*60)) % 60;
    }
    int hour() {
      return (getElapsedTime() / (1000*60*60)) % 24;
    }
    
}
