class Scoreboard {
  int score;

  Scoreboard() {
    score = 0;
  }

  void displayscore() {
    fill(255);
    textSize(50);

    text(score, 700, 80);
  }

  void increment() {
    score ++;
  }

  void reset() {
    score=0;
  }
}
