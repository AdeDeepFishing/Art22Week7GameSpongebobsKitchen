class Timer {
  int startTime;
  int totalTime;

  Timer(int totalTime) {
    this.totalTime = totalTime;
  }

  void start() {
    startTime = millis();
  }

  boolean complete() {
    int elapsedTime = millis() - startTime;
    if (elapsedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}