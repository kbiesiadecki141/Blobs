import processing.serial.*;
import processing.sound.*;
import cc.arduino.*;

Cursor bone;
Doge doge;
Animation dude;
Blob[] blobs2;
ArrayList<Blob> blobs;
ArrayList<Blob> explodingBlobs;

Timer spawnTimer;
Timer t;
Timer score;

int health;
int numBlobSpawned;
int numBlobsKilled;
int levelBlobs;

Arduino arduino;
int servoPin = 9;

Animation explode;
Animation spinnyBoi;

PImage title;
PImage inst;
PImage loading;
PImage gameover;

SoundFile ambience;
SoundFile explosion;
SoundFile laser;
SoundFile titlewav;
SoundFile shootingstar;
SoundFile shutdown;
SoundFile splat;

enum Screen { TITLE, INSTRUCTIONS, LOADING, PLAY, GAMEOVER };
Screen s;

void setup() 
{ 
  size(1280, 720);
  background(30, 30, 30);
  frameRate(24);
  
  arduino = new Arduino(this, Arduino.list()[5], 57600);
  arduino.pinMode(servoPin, Arduino.SERVO);
  
  bone = new Cursor();
  
  spinnyBoi = new Animation("piskel/blob/blob_", 4);
  
  title = loadImage("images/title.png");
  inst = loadImage("images/instructions.png");
  loading = loadImage("images/loading.png");
  gameover = loadImage("images/gameover.png");
  
  ambience = new SoundFile(this, "sounds/space.mp3");
  titlewav = new SoundFile(this, "sounds/titlewav.wav");
  explosion = new SoundFile(this, "sounds/pop.wav");
  laser = new SoundFile(this, "sounds/shoot.mp3");
  shootingstar = new SoundFile(this, "sounds/win.mp3");
  shutdown = new SoundFile(this, "sounds/gameover.mp3");
  splat = new SoundFile(this, "sounds/splat.wav");
  
  s = Screen.TITLE;
  
  titlewav.loop();
  
  score = new Timer(0);
}

void reset()
{
  health = 100;
  levelBlobs = 15; //TODO: make constant type (or add levels)
  numBlobSpawned = 0;
  numBlobsKilled = 0;
  
  blobs = new ArrayList<Blob>();
  
  spawnTimer = new Timer(5);
  spawnTimer.start();
  
  score.start();
  
  textSize(30);
}

void draw() 
{    
  background(50, 50, 50);
  
  switch (s) {
    case TITLE:
      bone.blackout(false);
      
      title.resize(1280, 0);
      image(title, 0, 0);
      
      bone.follow();
      
      if (mousePressed) {
        s = Screen.INSTRUCTIONS;
        laser.play();
        delay(500);
      }
      return;
      
    case INSTRUCTIONS:
      inst.resize(1280, 0);
      image(inst, 0, 0);
      bone.follow();
      
      // (Fake) load game (artificially induced for effect).
      if (mousePressed) {
        s = Screen.LOADING;
        shootingstar.play();
        titlewav.stop();
        
        t = new Timer(5);
        t.start();
      }
      return;
    case LOADING:
      if (!t.done()) {
        background(50, 50, 50);
        loading.resize(1280, 0);
        image(loading, 0, 0);
        frameRate(8);
        spinnyBoi.display(830, 310);
        
      } else {
        frameRate(24);
        ambience.loop();
        reset();
        s = Screen.PLAY;
        bone.blackout(true);
        
      }
      return;
     case PLAY:
       break;
     case GAMEOVER:
       bone.blackout(false);
       ambience.stop();
       
       
       gameover.resize(1280, 0);
       image(gameover, 0, 0);
       
       text(score.getElapsedTime(), 380, 380);
       text(numBlobsKilled, 530, 480);
       
       bone.follow();
      
       if (mousePressed) {
         s = Screen.LOADING;
         t.start();
         laser.play();
         delay(500);
       }
       return;
  }
  
  if (health > 0)
  {
    spawnBlob();
    displayBlobs();
 
    bone.follow();
    
    fill(255);
    text("health: " + health, 10, 10, 200, 200);
  } else if (health == 0) {
    score.stop();
    health -= 1;
    shutdown.play();
  } else {
    s = Screen.GAMEOVER;
  }
}

void increaseRate()
{
  // TODO: fix hard code.
  if (numBlobsKilled == 20) {
    spawnTimer.setDuration(1);
  } else if (numBlobsKilled == 15) {
    spawnTimer.setDuration(2);
  } else if (numBlobsKilled == 10) {
    spawnTimer.setDuration(3);
  } else if (numBlobsKilled == 5) {
    spawnTimer.setDuration(4);
  }
}


void spawnBlob()
{
   increaseRate();
   if (spawnTimer.done()) {
     Blob b = new Blob();
     blobs.add(b);
     spawnTimer.start();
     
     int servoPos = int(map(int(b.getX()), 0, 1280, 0, 180));
     print(servoPos);
     arduino.servoWrite(servoPin, servoPos);
   }
}

void displayBlobs()
{
   for (int i = 0; i < blobs.size(); i++) {
      Blob b = blobs.get(i);
      if (b != null) { // null safety check
        if (b.exploded()) {
          health -= 10;
          explosion.play();
          blobs.remove(i);
        } else if (b.killed()) {
          splat.play();
          numBlobsKilled++;
          blobs.remove(i);
        } else {
          b.beABlob();
          
          if (b.overCircle() && mousePressed) {
            b.attack();
          }
          if (mousePressed) {
            laser.play();
          }
        }
      } else {
        // cry
      }
    }
}
