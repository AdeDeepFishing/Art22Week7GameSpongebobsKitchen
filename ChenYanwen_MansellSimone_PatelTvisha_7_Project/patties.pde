class Patty {

  float x, y, yspeed;
  //variable for random image selection
  PImage image;

  Patty() {
    image=randomize();
    x=random(width);
    x= constrain (x, 50, 650);
    y= random(-2000, image.height);
    yspeed=1.7;
  }

  void display() {
    image(image, x, y);
  }

  PImage randomize() {
    PImage result;
    int num= int(random(3));
    switch(num) {
    case 0:
      result=loadImage("patty1.png");
      break;
    case 1:
      result= loadImage("patty2.png");
      break;
    default:
      result= loadImage("patty3.png");
      break;
    }
    return result;
  }

  void move() {
    y += yspeed;
  }

  void reset() {

    for (int i = 0; i < numpatties; i++) {
      patties.add(new Patty());
    }
  }
}