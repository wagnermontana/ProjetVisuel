float rotationX = 0;
float rotationZ = 0;
float rotateSpeed = 0.4;
int plateLength = 800;
int plateHeight = 10;
int sphereRadius = 40;
int obstacleRadius = 50;
int obstacleHeight = 50;
int obstacleRes = 40;

boolean run = true;

Mover mover;
Obstacle obstacle;
PGraphics bigRectangle;
PGraphics myGame;


void settings() {
  size (800, 700, P3D);
  
}
void setup() {
  bigRectangle = createGraphics(800, 200, P2D);
  myGame = createGraphics(800, 500, P3D);
  noStroke();
  mover = new Mover();
  obstacle = new Obstacle(obstacleRadius, obstacleHeight, obstacleRes);
 
}
void draw() {
  drawMyGame();
  image(myGame, 0, 0);
  drawMySurface();
  image(bigRectangle, 0, 500);
}

void drawBasics()
{
    myGame.background(50);
    myGame.noStroke();
    myGame.lights();
    myGame.ambientLight(0,0,0);
}
void mouseDragged() {
  float speed = PI/30;
  if ((mouseY - pmouseY)<0) {
    if (rotationX < PI/3) {
      rotationX += (speed)*rotateSpeed;
    }
  }
  if ((mouseY - pmouseY)>0) {
    if (rotationX > -PI/3) {
      rotationX -= (speed)*rotateSpeed;
    }
  }
  if ((mouseX - pmouseX)>0) {
    if (rotationZ < PI/3) {
      rotationZ += (speed)*rotateSpeed;
    }
  }
  if ((mouseX - pmouseX)<0) {
    if (rotationZ > -PI/3) {
      rotationZ -= (speed)*rotateSpeed;
    }
  }
}
void mouseWheel (MouseEvent event) {
  float e = event.getAmount();
  if (e < 0) {
    if (rotateSpeed <= 1.4) {
      rotateSpeed += 0.1;
    }
  }
  if (e > 0) {
    if (rotateSpeed >= 0.1 ) {
      rotateSpeed -= 0.1;
    }
  }
}
void keyPressed(){
  if (keyCode == SHIFT){
   run = false;
  }
}
void keyReleased(){
  run = true;
}
  
void mouseClicked(){
  if(run == false)
 {
     // on decale aussi de plateLength afin davoir les points dans les coord de "base"
     PVector position = new PVector(mouseX - plateLength/2, 0  ,mouseY - plateLength/2); // on decale selon y de height/2 car l'origine se trouve "dans" la box
     obstacle.positionObstacle.add(position);
    
 }
}

void drawMySurface(){
  pushMatrix();
  bigRectangle.beginDraw();
  bigRectangle.background(120);
  bigRectangle.ellipse(250, 50, 45, 25);
  bigRectangle.endDraw();
  popMatrix();
}
void drawMyGame(){
  pushMatrix();
  myGame.beginDraw();
  
  if (run == true){
    drawBasics();
    //myGame.camera(width/4, -150 ,width/2, width/2,width/2,-width/2,0,0,1);
    myGame.translate(width/2, width/2, -width/2);
    myGame.rotateX(rotationX);
    myGame.rotateZ(rotationZ);
    
    myGame.fill(34,162,176);
    myGame.box (plateLength, plateHeight, plateLength);

    pushMatrix();
    myGame.translate(0,-(plateHeight/2 + sphereRadius),0);
    mover.drawMover();
    obstacle.obstaclesDrawer();
    mover.checkCylinderCollision();
    popMatrix();
    }
    
    else if(run == false) {
    myGame.pushMatrix();
    myGame.translate(width/2, width/2, -width/2); // on retranslate pour avoir le meme origine que pdt run
    myGame.rotateX(-PI/2);
    drawBasics();
    myGame.fill(34,162,136);
    myGame.box (plateLength, plateHeight, plateLength);

    //myGame.translate(0,-(plateHeight/2 + sphereRadius),0); // le translate uniquement pour dessiner la boule ...  cette ligne ne serte a rien en fait
    mover.display();

    obstacle.obstaclesDrawer();
    myGame.popMatrix();
    }
    myGame.endDraw();
    popMatrix();

}