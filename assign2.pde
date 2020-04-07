PImage bg;
PImage Groundhog;
PImage heart;
PImage heart1;
PImage heart2;
PImage soldier;
PImage robot;
PImage soil;
PImage title;
PImage start;
PImage startHovered;
PImage restart;
PImage restartHovered;
PImage lose;
PImage gameover;
PImage cabbage;
PImage groundhogLeft;
PImage groundhogRight;
PImage groundhogDown;

int gameState = 2;
int startX = 248;
int startY = 360;
int cabbageY = 0;
int cabbageX = 0;
int life = 2;

float GroundhogX = 320,GroundhogY = 80,robotX,robotY,soldierX=0,soldierY,soldierXspeed,robotRandomX,robotRandomY,soldierRandomX=0,soldierRandomY;
float laserXSpeed,laserX1,laserY,laserX,robotHand;
float cabbageRandomX,cabbageRandomY,Groundhogtab = 80;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;
boolean cabbageEaten = false;

final int RESTART_W = 144;
final int RESTART_H = 60;
final int GAME_RUN = 0;
final int GAME_LOSE = 1;
final int GAME_START = 2;
final int GROUNDHOG_H = 80; 
final int GABBAGE_H = 80;
final int SOLDIER_H = 80;

void setup() {
	size(640, 480, P2D);
  frameRate(60);
  title = loadImage("img/title.jpg");
  start = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restart = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  gameover = loadImage("img/gameover.jpg");
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  heart = loadImage("img/life.png");
  heart1 = loadImage("img/life.png");
  heart2 = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  //robot = loadImage("img/robot.png");
  Groundhog = loadImage("img/groundhogIdle.png");
  cabbage = loadImage("img/cabbage.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  //robotX = random(160,640-80);
  //robotRandomY = random(160,480);
  cabbageRandomX = random(0,640-80);
  cabbageRandomY = random(160,480);
  soldierRandomY = random(160,480);
  soldierXspeed = 1;
  laserXSpeed = 2;
  laserX1 = robotX;
  laserX = 0;//amount
  robotHand = 0;
}

void draw() {
	switch(gameState){
		case GAME_START:// Game Start
      image(title, 0, 0);
      image(start, startX, startY, RESTART_W, RESTART_H);
      if(mouseX < RESTART_W + startX && mouseY < RESTART_H + startY 
      && mouseX > startX && mouseY > startY) {
        image(startHovered, startX, startY, RESTART_W, RESTART_H);
        if(mousePressed == true) {
          gameState = 0;
        }       
      }// detect mouse
     break;
     
		case GAME_RUN:// Game Run
      background(bg);
      image(soil,0,160);
      strokeWeight(15);
      stroke(124,204,25);
      line(0,160-7.5,640,160-7.5);
      strokeWeight(5);
      stroke(255,255,0);
      fill(253,184,19);
      ellipse(590,50,120,120);
      
      //heart
      for(int i = 0 ; i < life ; i++){
        image(heart,10 + 70 * i,10);
      }
      
      //groundhog
      image(Groundhog,GroundhogX,GroundhogY);
      
      //detect boundery
      if(GroundhogX < 0){
        GroundhogX = 0;
      }
      if(GroundhogX+GROUNDHOG_H > width){
        GroundhogX = width-GROUNDHOG_H;
      }
      if(GroundhogY < 80){
        GroundhogY = 80;
      }
      if(GroundhogY > height - GROUNDHOG_H ){
        GroundhogY = height - GROUNDHOG_H;
      }
      
      //soldier
      soldierX+=soldierXspeed;
      soldierX=soldierX%(480+240);          
      if(soldierRandomY<241){soldierY=160;}
      else if(soldierRandomY<321){soldierY=240;}
      else if(soldierRandomY<401){soldierY=320;}
      else if(soldierRandomY<481){soldierY=400;}
      image(soldier,soldierX-SOLDIER_H,soldierY);
      
      //cabbage
      if(cabbageEaten==false){
        if(cabbageRandomY<240){cabbageY=160;}
        else if(cabbageRandomY<320){cabbageY=240;}
        else if(cabbageRandomY<400){cabbageY=320;}
        else if(cabbageRandomY<480){cabbageY=400;}
        if(cabbageRandomX<80){cabbageX=0;}
        else if(cabbageRandomX<160){cabbageX=80;}
        else if(cabbageRandomX<240){cabbageX=160;}
        else if(cabbageRandomX<320){cabbageX=240;}
        else if(cabbageRandomX<400){cabbageX=320;}
        else if(cabbageRandomX<480){cabbageX=400;}
        else if(cabbageRandomX<560){cabbageX=480;}
        else if(cabbageRandomX<640){cabbageX=560;}  
        image(cabbage,cabbageX,cabbageY);
        if(GroundhogX+GROUNDHOG_H>cabbageX&&GroundhogX<cabbageX+GABBAGE_H 
        && GroundhogY+GROUNDHOG_H>cabbageY&&GroundhogY<cabbageY+GABBAGE_H){
         cabbageEaten = true;
         life++;
         break;
        }
       }
       
       //groundhog hit solider
       if(GroundhogX+GROUNDHOG_H>soldierX-SOLDIER_H&&GroundhogX<soldierX
       && GroundhogY+GROUNDHOG_H>soldierY&&GroundhogY<soldierY+SOLDIER_H){
         life--;
         GroundhogX = 320;
         GroundhogY = 80;                 
       }
       if(life==0){
         gameState = 1;
       }
    break;
    
		case GAME_LOSE:// Game Lose
       image(gameover, 0, 0);
       image(restart, startX, startY, RESTART_W, RESTART_H);
       if(mouseX < RESTART_W + startX && mouseY < RESTART_H + startY 
       && mouseX > startX && mouseY > startY) {
         image(restartHovered, startX, startY, RESTART_W, RESTART_H);
         if(mousePressed == true) {
           gameState = 2;
           life = 2;
         }       
        }
    break;
 }
}

void keyPressed(){
  switch (keyCode){
      case UP:
        if(GroundhogY < 81){
          GroundhogY = 80;
        }else{
          GroundhogY -= Groundhogtab;
        }
      break;
      
      case DOWN:
        if(GroundhogY > height - GROUNDHOG_H - 1){
          GroundhogY = height - GROUNDHOG_H;
        }else{
          GroundhogY += Groundhogtab;
          for(int t = 0;t < 15;t++){              
            if(t == 0){
              image(Groundhog,GroundhogX,GroundhogY);
            }
            else if(t<15&&t>0){
              image(groundhogDown,GroundhogX,GroundhogY);
            }
            else if(t == 15){
              image(Groundhog,GroundhogX,GroundhogY);
            }
          }      
        }
      break;
      
      case RIGHT:
        if(GroundhogX+GROUNDHOG_H > width-1){
          GroundhogX = width-GROUNDHOG_H;
        }else{
          GroundhogX += Groundhogtab;
          for(int t = 0;t < 15;t++){                
            if(t == 0){
              image(Groundhog,GroundhogX,GroundhogY);
            }
            else if(t<15&&t>0){
              image(groundhogRight,GroundhogX,GroundhogY);
            }
            else if(t == 15){
              image(Groundhog,GroundhogX,GroundhogY);
            }
           }
         }       
      break;
      
      case LEFT:
        if(GroundhogX < 1){
          GroundhogX = 0;
        }else{
          GroundhogX -= Groundhogtab;
          for(int t = 0;t < 15;t++){                
            if(t == 0){
              image(Groundhog,GroundhogX,GroundhogY);
            }
            else if(t<15&&t>0){
              image(groundhogLeft,GroundhogX,GroundhogY);
            }
            else if(t == 15){
              image(Groundhog,GroundhogX,GroundhogY);
            }
          }        
        } 
        break;
  }
}   


