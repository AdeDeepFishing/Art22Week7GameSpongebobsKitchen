/*
 * Course: ART 22  - Computer Programming for the Arts
 * Assignment: Assignment Name
 *
 * by Tvisha Patel, Simone Mansell, Yanwen Chen
 *
 * Initiated: 5/4/22
 * Last updated: 5/5/22
 *
 * CITATIONS:
 *   IMAGES: lose bkgd img: https://quotesgram.com/img/sad-spongebob-quotes/15740300/
 *           win bkgd img: https://animesuperhero.com/spongebob-squarepants-10-happiest-moments-sap-happy/
 *           cover img: https://play.google.com/store/apps/details?id=com.tiltingpoint.spongebob&hl=en_US&gl=US
 *           kitchen img: https://www.pinterest.com/pin/217017275783829549/
 *           instruction img: by Yanwen
 *           spatula img: by Yanwen
 *           patty img: https://unsplash.com/photos/hyIE90CN6b0
 *                      https://www.pexels.com/photo/photo-of-beef-patties-being-grilled-8880744/                  
 *            
 *  `CODE: timer modified from: http://learningprocessing.com/examples/chp10/example-10-04-timer
Make: Getting Started with Processing by Casey Reas and Ben Fry pg. 64, 159, 
https://www.programiz.com/java-programming/arraylist, Processing Array List Reference, Processing True/False Reference

 *
 * NOTE: 
 * Yanwen worked on: welcome page, enums, patties array, scoreboard, spatula, comments
 * Simone worked on: patties array, scoreboard, comments
 * Tvisha worked on: timer, win scene, loose scene, welcome page
 *
 * Instruction: In the playing scene, users can control the (x) position of the spatula and catch the falling patties. When the spatula catch the middle part of the patties, users get 1-3 points depends on how long the spatula spend time tauching the patties. When users get over or equal to 25 points, they win. Otherwise, less than 25, they lose the game.
 *
 * Concept and Customized: Our idea was to transform pong into a single player game in which you are taksed with catching burgers in Spongebob's kitchen. Instead of a paddle, you now have a spatula, and instead of a single ball, you are catching lots of burgers. We have lots of fun images such as the Spongebob Krabby Patty kitchen background to fit the theme. 
 *
 * */

PImage front, instruction, kitchen, spatulaImage, youWin, youLost;
int numpatties= 20;
Timer timer;
int timeLeft;
ArrayList<Patty> patties = new ArrayList<Patty>();
Spatula spatula =  new Spatula(30, 100, 0, 760);
Scoreboard board = new Scoreboard();


//creates different scenes to make the game display
enum Scene {
  INTROSCENE, INSTRUCTIONSCENE, PLAYSCENE, WINSCENE, LOSESCENE
};

Scene scene = Scene.INTROSCENE;


void setup() {
  size(800, 800);
  textSize(50);

  spatula=new Spatula(30, 150, mouseY, 700);
  timer = new Timer(1000);
  timeLeft = 30;

  front=loadImage("spongebob0.png");
  instruction=loadImage("instruction.png");
  kitchen=loadImage("spongebobKitchen.jpeg");
  spatulaImage=loadImage("spatulaImage.png");
  youLost=loadImage("spongebob_youlost.png");
  youWin=loadImage("spongebob_youwin.png");

  //create an arraylist of patties that contains the number of patties we need
  for (int i = 0; i < numpatties; i++) {
    patties.add(new Patty());
  }

  smooth();
}

void draw() {


  switch (scene) {
  case INTROSCENE:
    image(front, 0, 0);
    break;
  case INSTRUCTIONSCENE:
    image(instruction, 0, 0);
    break;
  case PLAYSCENE:
    image(kitchen, 0, 0);
    //show the patties falling down
    for (int i = 0; i < patties.size(); i++) {
      Patty patty = patties.get(i);
      patty.display();
      patty.move();

      //if spatula hits the patties, we get points
      if (hitSpatula(spatula, patty.x, patty.y)) {
        board.increment();
      }
    }

    //show the spatula
    spatula.update(mouseX);
    spatula.display();

    //show the score
    board.displayscore();

    //show the time
    if (timer.complete() == true) {
      if (timeLeft > 1) {
        timeLeft--;
        timer.start();
      } else {
        //when the time runs out, if the score reach ceratin number (25 here), we win. Otherwise, we lose.
        //before the scene guide to winscene or losescene, we reset numbers to enable the game replay later
        if (board.score>=25) {
          board.reset();

          for (int i = 0; i < numpatties; i++) {
            patties.add(new Patty());
          }
          numpatties=20;
          timeLeft=30;
          scene = Scene.WINSCENE;
        } else {
          board.reset();
          numpatties=20;
          timeLeft=30;

          for (int i = 0; i < numpatties; i++) {
            patties.add(new Patty());
          }
          scene = Scene.LOSESCENE;
        }
      }
    }
    String time = "Time Left: " + timeLeft;
    textAlign(CENTER);
    text(time, 200, 80);
    break;
  case WINSCENE:
    image(youWin, 0, 0);
    break;
  case LOSESCENE:
    image(youLost, 0, 0);
    break;
  }
}

void mouseClicked() {
  switch (scene) {
  case INTROSCENE:
    scene = Scene.INSTRUCTIONSCENE;
    break;
  case INSTRUCTIONSCENE:
    scene = Scene.PLAYSCENE;
    break;
  case PLAYSCENE:
    break;
  case WINSCENE:
    if (mouseX<width/2) {
      scene = Scene.PLAYSCENE;
    } else {
      scene = Scene.INTROSCENE;
    }
    break;
  case LOSESCENE:
    if (mouseX<width/2) {
      scene = Scene.PLAYSCENE;
    } else {
      scene = Scene.INTROSCENE;
    }
    break;
  }
}


boolean hitSpatula(Spatula spatula, float x, float y) {
  //if the spatula hit the patties, user get points
  if ((x+35)> spatula.xPos && (x+35) < spatula.xPos+spatula.spatulaWide && y > spatula.yPos  && y < (spatula.yPos+ 4)) {
    return true;
  } else {
    return false;
  }
}