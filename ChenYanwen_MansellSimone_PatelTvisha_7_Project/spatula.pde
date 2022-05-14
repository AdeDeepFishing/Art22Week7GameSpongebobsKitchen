class Spatula {
  int spatulaWide=30;
  int spatulaTall=150;
  float xPos;

  int yPos=760;

  Spatula(int paddleTall, int paddleWide, float xPos, int yPos) {
    this.spatulaTall=paddleTall;
    this.spatulaWide=paddleWide;
    this.xPos=xPos;
    this.yPos=yPos;
  }

  void update(float newXPos) {
    xPos=newXPos;
    xPos=constrain(xPos, 0, width-spatulaImage.width);
  }

  void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    image(spatulaImage, xPos, yPos);
  }
}
