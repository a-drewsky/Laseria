import processing.sound.*; //You must import the processing sound library. (sketch/import library)
SoundFile loop1;           //Sorry nothing is commented this was one of the first things I made with code
SoundFile loop2;
SoundFile loop3;
SoundFile loop4;
SoundFile loop5;
SoundFile loop6;
SoundFile loop7;
SoundFile loop8;
SoundFile loop9;
SoundFile extended;


SoundFile coinSound;
SoundFile laserSound;
SoundFile endLevelSound;
SoundFile deathSound;
SoundFile menuButtonSound;
SoundFile buttonClickSound;
SoundFile enemyDeathSound;
SoundFile saveSound;

static grid Grid;
static ArrayList <block> blocks;
static ArrayList <triBlock> triBlocks;
static ArrayList <deathBlock> deathBlocks;
static ArrayList <triDeathBlock> triDeathBlocks;
static ArrayList<laser> lasers;
static ArrayList<trigger> triggers;
static ArrayList<door> doors;
static ArrayList<endZone> endZones;
static ArrayList<enemy> enemyArrays;
static ArrayList<radialEnemy> radialEnemies;
static ArrayList<coin> coins;
static ArrayList<button> buttons;
levelBuilder LB = new levelBuilder();
static mover Mover;
triPusher tP = new triPusher();
gui Gui;
saveData SaveData = new saveData();
static int gameState = -1;

static float moveTime = 60;
static float cornerGap = 8;

color enColor = color(220, 60, 100);
color enStroke = color(160, 10, 80);
color col1 = color(90, 200, 70); //freq1
color col2 = color(80, 200, 170); //freq2
color col3 = color(80, 160, 200); //freq3
color col4 = color(180, 120, 210); //freq4
color col1S = color(80, 180, 60); //freq1
color col2S = color(70, 180, 150); //freq2
color col3S = color(70, 140, 180); //freq3
color col4S = color(160, 110, 190); //freq4
color[] freqColors = {col1, col2, col3, col4};
color[] freqSColors = {col1S, col2S, col3S, col4S};

float coinSize;
float enemySize;
boolean showEnemyCenter = false;

float fadeT = 30;
float t = 0;

int moverSize;
int levelNum;
int gridSize = 14;

int selectRadius = 10;

boolean objectivesComplete;
boolean saved = false;
float saveFlashTime = 30;
int stopMoverTime=0;
int StopMoverLim=1;

float h;
float w;

PImage title;
PImage[] textures;

PImage[] textures_;
PImage broFist;
PFont font;
PFont font2;

boolean showTexture = true;
color[] blockStrokes;
boolean initialized = false;
int loadingTime=0;
float loadingRotation = 0;
float loadingSize = 100;

int enemyDeathTimer = 0;
int coinTimer = 0;

boolean soundOn;
boolean texturesOn;

boolean cursorOn=true;

void settings(){
  PJOGL.setIcon("icon.png");
  size(980, 525, P2D); //weird but okay
  smooth(4);
}

void setup() {
  pixelDensity(displayDensity());
  cursor(HAND);
  h = height;
  w = width;
  font = createFont("Lucida.ttf", 32);
  font2 = createFont("Mourbout.ttf", 32);
  textFont(font);
  Grid = new grid(2*gridSize, gridSize);
  blocks = new ArrayList<block>();
  triBlocks = new ArrayList<triBlock>();
  deathBlocks = new ArrayList<deathBlock>();
  triDeathBlocks = new ArrayList<triDeathBlock>();
  lasers = new ArrayList<laser>();
  triggers = new ArrayList<trigger>();
  doors = new ArrayList<door>();
  endZones = new ArrayList<endZone>();
  enemyArrays = new ArrayList<enemy>();
  radialEnemies = new ArrayList<radialEnemy>();
  coins = new ArrayList<coin>();
  buttons = new ArrayList<button>();
  soundOn=false;
  texturesOn=false;
  Gui = new gui();
  Gui.loadData();
  float mSize = Grid.Xiteration*0.6;
  float eSize = Grid.Xiteration*0.35;
  float cSize = Grid.Xiteration*0.35;
  moverSize = (int)mSize;
  enemySize = (int)eSize;
  coinSize = (int) cSize;
  title = loadImage("laseria.png");
  textures = new PImage[10];
  textures_ = new PImage[10];
  blockStrokes = new color[10];
  initializeStrokes();
  Mover = new mover(moverSize, moverSize, 500, 250);
  gameState = 0;
  Mover.startScreenSaver(4, 4);
  background(255);
  thread("initialize");
}

void initialize() {
  loop1 = new SoundFile(this, "music/loop1.mp3");
  loop2 = new SoundFile(this, "music/loop2.mp3");
  loop3 = new SoundFile(this, "music/loop3.mp3");
  loop4 = new SoundFile(this, "music/loop4.mp3");
  loop5 = new SoundFile(this, "music/loop5.mp3");
  loop6 = new SoundFile(this, "music/loop6.mp3");
  loop7 = new SoundFile(this, "music/loop7.mp3");
  loop8 = new SoundFile(this, "music/loop8.mp3");
  loop9 = new SoundFile(this, "music/loop9.mp3");
  extended = new SoundFile(this, "music/extended.mp3");
  coinSound = new SoundFile(this, "sounds/coin.mp3");
  laserSound = new SoundFile(this, "sounds/laser.mp3");
  endLevelSound = new SoundFile(this, "sounds/endlevel.wav");
  deathSound = new SoundFile(this, "sounds/death.wav");
  menuButtonSound = new SoundFile(this, "sounds/menubutton.wav");
  buttonClickSound = new SoundFile(this, "sounds/buttonclick.wav");
  enemyDeathSound = new SoundFile(this, "sounds/enemydeath.wav");
  saveSound = new SoundFile(this, "sounds/savesound.wav");
  textures[0] = loadImage("textures/1.png");
  textures_[0] = loadImage("textures/1.png");
  textures[1] = loadImage("textures/2.jpg");
  textures_[1] = loadImage("textures/2.jpg");
  textures[2] = loadImage("textures/3.jpg");
  textures_[2] = loadImage("textures/3.jpg");
  textures[3] = loadImage("textures/4.jpg");
  textures_[3] = loadImage("textures/4.jpg");
  textures[4] = loadImage("textures/5.jpg");
  textures_[4] = loadImage("textures/5.jpg");
  textures[5] = loadImage("textures/6.jpg");
  textures_[5] = loadImage("textures/6.jpg");
  textures[6] = loadImage("textures/7.jpg");
  textures_[6] = loadImage("textures/7.jpg");
  textures[7] = loadImage("textures/8.jpg");
  textures_[7] = loadImage("textures/8.jpg");
  textures[8] = loadImage("textures/9.jpg");
  textures_[8] = loadImage("textures/9.jpg");
  textures[9] = loadImage("textures/10.jpg");
  textures_[9] = loadImage("textures/10.jpg");
  broFist = loadImage("brofist.png");
  initialized = true;
  gameState=0;
  if (soundOn) extended.loop();
}

void initializeStrokes() {

  blockStrokes[0] = color(75, 75, 150);
  blockStrokes[1] = color(0, 40, 70);
  blockStrokes[2] = color(200, 100, 180);
  blockStrokes[3] = color(100, 250, 250);
  blockStrokes[4] = color(200, 30, 200);
  blockStrokes[5] = color(10, 130, 160);
  blockStrokes[6] = color(130, 20, 100);
  blockStrokes[7] = color(20, 50, 70);
  blockStrokes[8] = color(75, 75, 150);
  blockStrokes[9] = color(160, 20, 50);
}

void death() {
  if (soundOn) deathSound.play();
  Mover.dead = true;
  Mover.fadeTime = fadeT;
  moverFade();
}

void moverFade() {
  if (Mover.fadeTime==0) { 
    Gui.deathCount+=1;
    reset();
  } else {
    if (gameState==2)Mover.fadeTime-=1;
  }
}

void reset() {
  if (Gui.saveCount==2) Gui.timer=0;
  Mover.dead = false;
  Gui.flashTime=saveFlashTime;
  clearLevel();
  populate(levelNum-1);

  if (saved) {
    enemyArrays = new ArrayList(SaveData.enemyArraysS);
    radialEnemies = new ArrayList(SaveData.radialEnemiesS);
    Mover.pos.x = SaveData.moverPosS.x;
    Mover.pos.y = SaveData.moverPosS.y;
    for (int i=0; i<triBlocks.size(); i++) {
      triBlock t = triBlocks.get(i);
      t.pos = new PVector(SaveData.triBlockPos[i].x, SaveData.triBlockPos[i].y);
      t.rotation = new Integer(SaveData.triBlockRot[i]);
    }
    for (int i=0; i<enemyArrays.size(); i++) {
      enemyArrays.get(i).gaps.clear();
      for (int j=0; j<SaveData.enemyGapsS[i].size(); j++) {
        enemyArrays.get(i).gaps.add(SaveData.enemyGapsS[i].get(j));
      }
    }
    for (int i=0; i<radialEnemies.size(); i++) {
      radialEnemies.get(i).gaps.clear();
      for (int j=0; j<SaveData.radEnemyGapsS[i].size(); j++) {
        radialEnemies.get(i).gaps.append(SaveData.radEnemyGapsS[i].get(j));
      }
    }
    coins.clear();
    for (int i=0; i<SaveData.coinPosS.size(); i++) {
      coins.add(new coin(SaveData.coinPosS.get(i).x, SaveData.coinPosS.get(i).y));
    }
    for (int i=0; i<lasers.size(); i++) {
      lasers.get(i).rotation = SaveData.laserRotationS[i];
      lasers.get(i).fire = SaveData.laserStates[i];
    }
    for (int i=0; i<buttons.size(); i++) {
      if (SaveData.buttonsS[i]) buttons.get(i).triggered = true;
    }
    for (int i=0; i<triggers.size(); i++) {
      if (SaveData.triggersS[i]) triggers.get(i).triggered = true;
    }

    //Enemy Data
    for (int i=0; i<enemyArrays.size(); i++) {
      enemyArrays.get(i).goReverse = SaveData.enemyReverseS[i];
      for (int j=0; j<enemyArrays.get(i).time.length; j++) {
        enemyArrays.get(i).time[j] = SaveData.enemyTimeS[i].get(j);
      }
      for (int j=0; j<enemyArrays.get(i).curPathNum.length; j++) {
        enemyArrays.get(i).curPathNum[j] = SaveData.enemyPathNumS[i].get(j);
      }
      for (int j=0; j<enemyArrays.get(i).curPath.length; j++) {
        enemyArrays.get(i).curPath[j] = enemyArrays.get(i).paths.get(SaveData.enemyPathNumS[i].get(j));
      }
      for (int j=0; j<enemyArrays.get(i).curStartLoc.length; j++) {
        enemyArrays.get(i).curStartLoc[j] = SaveData.enemyStartLocS[i].get(j);
      }
      for (int j=0; j<enemyArrays.get(i).curTarget.length; j++) {
        enemyArrays.get(i).curTarget[j] = SaveData.enemyTargetS[i].get(j);
      }
      for (int j=0; j<enemyArrays.get(i).fadeTimes.length; j++) {
        enemyArrays.get(i).fadeTimes[j] = SaveData.enemyFadeTimesS[i].get(j);
      }
      for (int j=0; j<enemyArrays.get(i).dying.length; j++) {
        enemyArrays.get(i).dying[j] = SaveData.enemyDyingS[i].get(j);
      }
    }

    //Radial Enemy Data
    for (int i=0; i<radialEnemies.size(); i++) {
      radialEnemies.get(i).goReverse = SaveData.radEnemyReverseS[i];
      radialEnemies.get(i).curRotation = SaveData.radEnemyRotS[i];

      for (int j=0; j<radialEnemies.get(i).fadeTimes.length; j++) {
        radialEnemies.get(i).fadeTimes[j] = SaveData.radEnemyFadeTimesS[i].get(j);
      }
      for (int j=0; j<radialEnemies.get(i).dying.length; j++) {
        radialEnemies.get(i).dying[j] = SaveData.radEnemyDyingS[i].get(j);
      }
    }
  }

  checkEdges();
}

void populate(int level) {
  if (soundOn) loop1.stop();
  if (soundOn) loop2.stop();
  if (soundOn) loop3.stop();
  if (soundOn) loop4.stop();
  if (soundOn) loop5.stop();
  if (soundOn) loop6.stop();
  if (soundOn) loop7.stop();
  if (soundOn) loop8.stop();
  if (soundOn) loop9.stop();
  if (soundOn) extended.stop();
  if (level>=0 && level<=2 && soundOn)loop1.loop();
  if (level>=3 && level<=5 && soundOn)loop2.loop();
  if (level>=6 && level<=8 && soundOn)loop3.loop();
  if (level>=9 && level<=11 && soundOn)loop4.loop();
  if (level>=12 && level<=14 && soundOn)loop5.loop();
  if (level>=15 && level<=17 && soundOn)loop6.loop();
  if (level>=18 && level<=20 && soundOn)loop7.loop();
  if (level>=21 && level<=23 && soundOn)loop8.loop();
  if (level>=24 && level<=26 && soundOn)loop9.loop();
  if (level==27 && soundOn)extended.loop();
  objectivesComplete = false;
  LB.buildLevel(level);
  Mover.pos.x = LB.startingPosition.x;
  Mover.pos.y = LB.startingPosition.y;
  checkEdges();
  gameState=2;
  levelNum=level+1;

  PGraphics maskImage;
  maskImage = createGraphics(980, 525);
  maskImage.beginDraw();
  maskImage.rect(0, 0, 0, 0);
  for (int i=0; i<triBlocks.size(); i++) {
    if (!triBlocks.get(i).movable) {
      if (texturesOn) {
        triBlock t = triBlocks.get(i);
        maskImage.fill(255, 255);
        maskImage.triangle(t.corner1.x, t.corner1.y, t.corner2.x, t.corner2.y, t.corner3.x, t.corner3.y);
        for (int j=0; j<3; j++) {
          maskImage.strokeWeight(1);
          maskImage.stroke(255, 255);
          maskImage.line(t.edges[j].v1.x, t.edges[j].v1.y, t.edges[j].v2.x, t.edges[j].v2.y);
        }
      }
    }
  }
  maskImage.endDraw();

  if (level>=0 && level<=2) textures_[0].mask( maskImage );
  if (level>=3 && level<=5) textures_[1].mask( maskImage );
  if (level>=6 && level<=8) textures_[2].mask( maskImage );
  if (level>=9 && level<=11) textures_[3].mask( maskImage );
  if (level>=12 && level<=14) textures_[4].mask( maskImage );
  if (level>=15 && level<=17) textures_[5].mask( maskImage );
  if (level>=18 && level<=20) textures_[6].mask( maskImage );
  if (level>=21 && level<=23) textures_[7].mask( maskImage );
  if (level>=24 && level<=26) textures_[8].mask( maskImage );
  if (level==27) textures_[9].mask( maskImage );
}

void showMousePos() {
  String showPosX = String.format("%.1f", mouseX/Gui.itt);
  String showPosY = String.format("%.1f", (mouseY-Gui.itt)/Gui.itt);
  println(showPosX, showPosY);
}

void draw() {
  if(height!=525) surface.setSize(980,525); 
  
  if (!initialized) {

    Gui.loadingAnimation();
  } else {
    if (enemyDeathTimer>0)enemyDeathTimer-=1;
    if (coinTimer>0)coinTimer-=1;
    t+=1;
    if (gameState==2)completeObjectives();
    stopMover();
    if (Mover.dead == true) {
      Mover.goUp = false;
      Mover.goDown = false;
      Mover.goLeft = false;
      Mover.goRight = false;
      Mover.vel = new PVector(0, 0);
      Mover.acc = new PVector(0, 0);
      Mover.pos = Mover.pos;
      moverFade();
    }
    if (gameState==2) {
      if (cursorOn==true) {
        noCursor();
        cursorOn=false;
      }

      //showMousePos();
    } else { 
      if (cursorOn==false) {
        cursor(HAND);
        cursorOn=true;
      }
    }
    background(255);
    if ((gameState==2 || gameState==3) && levelNum==28) Gui.showFist();
    Grid.showDots();
    for (int i=0; i<endZones.size(); i++) {
      endZones.get(i).show();
    }
    for (int i=0; i<deathBlocks.size(); i++) {
      deathBlocks.get(i).show();
    }
    for (int i=0; i<triDeathBlocks.size(); i++) {
      triDeathBlocks.get(i).show();
    }
    for (int i=0; i<blocks.size(); i++) {
      blocks.get(i).show();
    }

    PGraphics maskImage;
    maskImage = createGraphics(980, 525);
    maskImage.beginDraw();
    maskImage.rect(0, 0, 0, 0);
    for (int i=0; i<triBlocks.size(); i++) {
      if (!triBlocks.get(i).movable) {
        if (!texturesOn) {
          triBlocks.get(i).show();
          triBlocks.get(i).update();
        } else {
          if (levelNum-1>=0 && levelNum-1<=2) image(textures_[0], 0, 0, 980, 525);
          if (levelNum-1>=3 && levelNum-1<=5) image(textures_[1], 0, 0, 980, 525);
          if (levelNum-1>=6 && levelNum-1<=8) image(textures_[2], 0, 0, 980, 525);
          if (levelNum-1>=9 && levelNum-1<=11) image(textures_[3], 0, 0, 980, 525);
          if (levelNum-1>=12 && levelNum-1<=14) image(textures_[4], 0, 0, 980, 525);
          if (levelNum-1>=15 && levelNum-1<=17) image(textures_[5], 0, 0, 980, 525);
          if (levelNum-1>=18 && levelNum-1<=20) image(textures_[6], 0, 0, 980, 525);
          if (levelNum-1>=21 && levelNum-1<=23) image(textures_[7], 0, 0, 980, 525);
          if (levelNum-1>=24 && levelNum-1<=26) image(textures_[8], 0, 0, 980, 525);
          if (levelNum-1==27) image(textures_[9], 0, 0, 980, 525);
        }
      }
    }



    for (int i=0; i<deathBlocks.size(); i++) {
      deathBlocks.get(i).showStroke();
    }
    for (int i=0; i<triDeathBlocks.size(); i++) {
      triDeathBlocks.get(i).showStroke();
    }
    for (int i=0; i<blocks.size(); i++) {
      blocks.get(i).showStroke();
    }
    for (int i=0; i<triBlocks.size(); i++) {
      triBlocks.get(i).showStroke();
    }
    for (int i=0; i<blocks.size(); i++) {
      blocks.get(i).showMirrors();
    }
    for (int i=0; i<triBlocks.size(); i++) {
      triBlocks.get(i).showMirrors();
    }

    Mover.vLimitX = Mover.fullvLimit;
    Mover.vLimitY = Mover.fullvLimit;
    Mover.corners();
    Mover.edges();
    Mover.movement();
    if (!Mover.screenSaver) Mover.friction();

    for (int i=0; i<triBlocks.size(); i++) {
      triBlocks.get(i).touchingMover = false;
    }

    detectEdges();
    detectCircles();


    for (int i=0; i<coins.size(); i++) {
      coins.get(i).show();
    }

    for (int i=0; i<doors.size(); i++) {
      doors.get(i).show();
    }
    for (int i=0; i<triggers.size(); i++) {
      triggers.get(i).show();
    }
    for (int i=0; i<buttons.size(); i++) {
      buttons.get(i).show();
    }

    if (gameState==2 && levelNum==1) Gui.showTutLevelText();

    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i).movable) {
        triBlocks.get(i).show();
        triBlocks.get(i).update();
      }
    }
    for (int i=0; i<lasers.size(); i++) {
      lasers.get(i).show();
    }

    Mover.update();
    Mover.show();

    for (int i=0; i<enemyArrays.size(); i++) {
      if (gameState==2)enemyArrays.get(i).update();
      enemyArrays.get(i).show();
      enemyArrays.get(i).arrayNum = i;
    }
    for (int i=0; i<radialEnemies.size(); i++) {
      if (gameState==2)radialEnemies.get(i).update();
      radialEnemies.get(i).show();
      if (showEnemyCenter==true) radialEnemies.get(i).showCenter = true;
    }
    Gui.update();
  }
}

void keyPressed() { 
  if (gameState==2) {
    if (!Mover.dead) {
      if (keyCode == UP || key=='w' || key=='W') {
        Mover.goUp = true;
        Mover.goDown = false;
      }
      if (keyCode == DOWN || key=='s' || key=='S') {
        Mover.goDown = true;
        Mover.goUp = false;
      }
      if (keyCode == LEFT || key=='a' || key=='A') {
        Mover.goLeft = true;
        Mover.goRight = false;
      }
      if (keyCode == RIGHT || key=='d' || key=='D') {
        Mover.goRight = true;
        Mover.goLeft = false;
      }

      if (key == 'r' || key == 'R') {
        for (int i=0; i<lasers.size(); i++) {
          laser l = lasers.get(i);
          PVector lCent = new PVector(l.pos.x, l.pos.y);
          if (circleCircleInt(Mover.circPos.x, Mover.circPos.y, Mover.circR, lCent.x, lCent.y, l.r)) {
            if (!crossingDoor(l.pos.x, l.pos.y))l.rotation();
          }
        }
        for (int i=0; i<triBlocks.size(); i++) {
          triBlock t = triBlocks.get(i);
          PVector t1 = t.corner1;
          PVector t2 = t.corner2;
          PVector t3 = t.corner3;
          PVector center = new PVector(t.pos.x+(t.size.x/2), t.pos.y+(t.size.y/2));
          PVector mid = midPoint(center, t.corner1);
          if (t.movable && (triPointInt(t1.x, t1.y, t2.x, t2.y, t3.x, t3.y, Mover.circPos.x, Mover.circPos.y) || t.touchingMover
            || lineCircleInt(t.edges[0], Mover.circPos, selectRadius) || lineCircleInt(t.edges[1], Mover.circPos, selectRadius) || lineCircleInt(t.edges[2], Mover.circPos, selectRadius))) {
            if (!crossingDoor(mid.x, mid.y)) {
              t.goRotate();
              t.corners();
              t.edges();
              t.horVertEdges();
            }
          }
        }
      }
      if (key == ' ') {
        for (int i=0; i<lasers.size(); i++) {
          laser l = lasers.get(i);
          PVector lCent = new PVector(l.pos.x, l.pos.y);
          if (circleCircleInt(Mover.circPos.x, Mover.circPos.y, Mover.circR, lCent.x, lCent.y, l.r)) {
            if (!crossingDoor(l.pos.x, l.pos.y)) {
              l.fire = !l.fire;
              if (l.fire && soundOn)laserSound.play();
            }
          }
        }
      }
      if (key == 'x' || key == 'X') {
        if (Gui.saveCount>0) {
          if (soundOn) saveSound.play();
          saved = true;
          SaveData.saveState();
          Gui.saveCount-=1;
          Gui.flashTime=saveFlashTime;
        }
      }
    }  
    if (key==ESC || key=='p' || key=='P') {
      if (soundOn) menuButtonSound.play();
      key = 0;
      if (soundOn) menuButtonSound.play();
      gameState=3;
      Mover.goUp = false;
      Mover.goDown = false;
      Mover.goLeft = false;
      Mover.goRight = false;
    }
  } else {
    if (gameState==3) {
      if (key == ESC || key=='p' || key=='P') {
        if (soundOn) menuButtonSound.play();
        gameState=2;
      }
    }
    if (key == ESC) key=0;
  }
}

void keyReleased() {
  if (keyCode == UP || key=='w' || key=='W') Mover.goUp = false;
  if (keyCode == DOWN || key=='s' || key=='S') Mover.goDown = false;
  if (keyCode == LEFT || key=='a' || key=='A') Mover.goLeft = false;
  if (keyCode == RIGHT || key=='d' || key=='D') Mover.goRight = false;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    Gui.mPress();
  }
}

boolean crossingDoor(float x, float y) {
  edge e1;
  edge e2;
  e1 = new edge(x, y, Mover.center.x, Mover.center.y);
  for (int i=0; i<doors.size(); i++) {
    door d = doors.get(i);
    e2 = new edge(d.v1.x, d.v1.y, d.v2.x, d.v2.y);
    if (intersection(e1, e2)) return true;
  }
  return false;
}

void stopMover() {
  if (stopMoverTime>StopMoverLim) {
    Mover.goUp = false;
    Mover.goDown = false;
    Mover.goLeft = false;
    Mover.goRight = false;
  }
}

//----------------------------------function bank----------------------------------//

void awardStars() {
  if (levelNum>=1 && levelNum<=3 && soundOn)loop1.stop();
  if (levelNum>=4 && levelNum<=6 && soundOn)loop2.stop();
  if (levelNum>=7 && levelNum<=9 && soundOn)loop3.stop();
  if (levelNum>=10 && levelNum<=12 && soundOn)loop4.stop();
  if (levelNum>=13 && levelNum<=15 && soundOn)loop5.stop();
  if (levelNum>=16 && levelNum<=18 && soundOn)loop6.stop();
  if (levelNum>=19 && levelNum<=21 && soundOn)loop7.stop();
  if (levelNum>=22 && levelNum<=24 && soundOn)loop8.stop();
  if (levelNum>=25 && levelNum<=27 && soundOn)loop9.stop();
  if (levelNum==28 && soundOn)extended.stop();
  Gui.timer = Math.round(Gui.timer * 10.0) / 10.0;

  Gui.curRating = 1;
  if (Gui.saveCount==2) {
    Gui.curRating = 2;
    if (Gui.timer<Gui.threeStarTimes[levelNum-1]) {
      Gui.curRating = 3;
    }
  }

  Gui.curTime = Gui.timer;

  if (Gui.curRating > Gui.starRatings[levelNum-1]) Gui.starRatings[levelNum-1] = Gui.curRating;
  if (Gui.curTime > Gui.bestTimes[levelNum-1]) Gui.bestTimes[levelNum-1] = Gui.curTime;
  Gui.saveData();
}

void clearLevel() {
  blocks.clear();
  triBlocks.clear();
  deathBlocks.clear();
  triDeathBlocks.clear();
  lasers.clear();
  triggers.clear();
  doors.clear();
  endZones.clear();
  enemyArrays.clear();
  radialEnemies.clear();
  coins.clear();
  buttons.clear();
}

void startLevel() {
  gameState=2;
  saved = false;
  Mover.screenSaver=false;
  stopMoverTime=0;
  Gui.saveCount=2;
  Gui.timer=0;
  Gui.deathCount=0;
  Gui.curRating=0;
}

void startMainMenu() {
  extended.loop();
  Gui.saveCount=0;
  Mover.pos = new PVector(500, 250);
  Mover.startScreenSaver(4, 4);
  gameState=0;
  Gui.timer=0;
  Gui.deathCount=0;
  Gui.curRating=0;
}

void completeObjectives() { //check if objectives are complete
  if (coins.size()==0) {

    for (int i=0; i<enemyArrays.size(); i++) {
      enemy eA = enemyArrays.get(i);
      for (int j=0; j<eA.enemies.length; j++) {
        if (eA.frequencies[j]>0 && !eA.gaps.contains(j)) {
          objectivesComplete = false;
          return;
        }
      }
    }
    for (int i=0; i<radialEnemies.size(); i++) {
      radialEnemy rE = radialEnemies.get(i);
      for (int j=0; j<rE.enemyPositions.length; j++) {
        if (rE.frequencies[j]>0 && !rE.gaps.hasValue(j)) {
          objectivesComplete = false;
          return;
        }
      }
    }
    if (objectivesComplete==false) {
      objectivesComplete = true;
      Gui.OCMessageStart();
    }
  } else objectivesComplete = false;
}

void checkEdges() { //mark open edges
  for (int i=0; i<blocks.size(); i++) { //test blocks
    for (int j=0; j<blocks.size(); j++) { //test blocks against blocks
      if (i!=j) {
        if (blocks.get(i).edges[0].v1.x==blocks.get(j).edges[2].v2.x && blocks.get(i).edges[0].v1.y==blocks.get(j).edges[2].v2.y
          && blocks.get(i).edges[0].v2.x==blocks.get(j).edges[2].v1.x && blocks.get(i).edges[0].v2.y==blocks.get(j).edges[2].v1.y) {
          blocks.get(i).edges[0].open = false; 
          blocks.get(j).edges[2].open = false;
        }
        if (blocks.get(i).edges[1].v1.x==blocks.get(j).edges[3].v2.x && blocks.get(i).edges[1].v1.y==blocks.get(j).edges[3].v2.y
          && blocks.get(i).edges[1].v2.x==blocks.get(j).edges[3].v1.x && blocks.get(i).edges[1].v2.y==blocks.get(j).edges[3].v1.y) {
          blocks.get(i).edges[1].open = false; 
          blocks.get(j).edges[3].open = false;
        }
      }
    }

    for (int j=0; j<triBlocks.size(); j++) { //test blocks against triblocks
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[0].v1.x==triBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[0].v1.y==triBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[0].v2.x==triBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[0].v2.y==triBlocks.get(j).edges[k].v1.y) {
          blocks.get(i).edges[0].open = false;
          triBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[1].v1.x==triBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[1].v1.y==triBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[1].v2.x==triBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[1].v2.y==triBlocks.get(j).edges[k].v1.y) {
          blocks.get(i).edges[1].open = false;
          triBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[2].v1.x==triBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[2].v1.y==triBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[2].v2.x==triBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[2].v2.y==triBlocks.get(j).edges[k].v1.y) {
          blocks.get(i).edges[2].open = false;
          triBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[3].v1.x==triBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[3].v1.y==triBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[3].v2.x==triBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[3].v2.y==triBlocks.get(j).edges[k].v1.y) {
          blocks.get(i).edges[3].open = false;
          triBlocks.get(j).edges[k].open = false;
        }
      }
    }

    for (int j=0; j<deathBlocks.size(); j++) { //test blocks against deathblocks
      if (blocks.get(i).edges[0].v1.x==deathBlocks.get(j).edges[2].v2.x && blocks.get(i).edges[0].v1.y==deathBlocks.get(j).edges[2].v2.y
        && blocks.get(i).edges[0].v2.x==deathBlocks.get(j).edges[2].v1.x && blocks.get(i).edges[0].v2.y==deathBlocks.get(j).edges[2].v1.y) { 
        deathBlocks.get(j).edges[2].open = false;
      }
      if (blocks.get(i).edges[1].v1.x==deathBlocks.get(j).edges[3].v2.x && blocks.get(i).edges[1].v1.y==deathBlocks.get(j).edges[3].v2.y
        && blocks.get(i).edges[1].v2.x==deathBlocks.get(j).edges[3].v1.x && blocks.get(i).edges[1].v2.y==deathBlocks.get(j).edges[3].v1.y) {
        deathBlocks.get(j).edges[3].open = false;
      }
      if (blocks.get(i).edges[2].v1.x==deathBlocks.get(j).edges[0].v2.x && blocks.get(i).edges[2].v1.y==deathBlocks.get(j).edges[0].v2.y
        && blocks.get(i).edges[2].v2.x==deathBlocks.get(j).edges[0].v1.x && blocks.get(i).edges[2].v2.y==deathBlocks.get(j).edges[0].v1.y) { 
        deathBlocks.get(j).edges[0].open = false;
      }
      if (blocks.get(i).edges[3].v1.x==deathBlocks.get(j).edges[1].v2.x && blocks.get(i).edges[3].v1.y==deathBlocks.get(j).edges[1].v2.y
        && blocks.get(i).edges[3].v2.x==deathBlocks.get(j).edges[1].v1.x && blocks.get(i).edges[3].v2.y==deathBlocks.get(j).edges[1].v1.y) {
        deathBlocks.get(j).edges[1].open = false;
      }
    }
    for (int j=0; j<triDeathBlocks.size(); j++) { //test blocks against trideathblocks
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[0].v1.x==triDeathBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[0].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[0].v2.x==triDeathBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[0].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[1].v1.x==triDeathBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[1].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[1].v2.x==triDeathBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[1].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[2].v1.x==triDeathBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[2].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[2].v2.x==triDeathBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[2].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (blocks.get(i).edges[3].v1.x==triDeathBlocks.get(j).edges[k].v2.x && blocks.get(i).edges[3].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && blocks.get(i).edges[3].v2.x==triDeathBlocks.get(j).edges[k].v1.x && blocks.get(i).edges[3].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
    }
  }

  for (int i=0; i<triBlocks.size(); i++) { //test triblocks against triblocks
    for (int j=0; j<triBlocks.size(); j++) {
      for (int k=0; k<3; k+=2) {
        for (int l=0; l<3; l+=2) {
          if (triBlocks.get(i).edges[k].v1.x==triBlocks.get(j).edges[l].v2.x && triBlocks.get(i).edges[k].v1.y==triBlocks.get(j).edges[l].v2.y
            && triBlocks.get(i).edges[k].v2.x==triBlocks.get(j).edges[l].v1.x && triBlocks.get(i).edges[k].v2.y==triBlocks.get(j).edges[l].v1.y) {
            triBlocks.get(i).edges[k].open = false;
            triBlocks.get(j).edges[l].open = false;
          }
        }
      }
      if (triBlocks.get(i).edges[1].v1.x==triBlocks.get(j).edges[1].v2.x && triBlocks.get(i).edges[1].v1.y==triBlocks.get(j).edges[1].v2.y
        && triBlocks.get(i).edges[1].v2.x==triBlocks.get(j).edges[1].v1.x && triBlocks.get(i).edges[1].v2.y==triBlocks.get(j).edges[1].v1.y) {
        triBlocks.get(i).edges[1].open = false;
        triBlocks.get(j).edges[1].open = false;
      }
    }

    for (int j=0; j<deathBlocks.size(); j++) { //test triblocks against deathblocks
      for (int k=0; k<3; k+=2) {
        for (int l=0; l<4; l++) {
          if (triBlocks.get(i).edges[k].v1.x==deathBlocks.get(j).edges[l].v2.x && triBlocks.get(i).edges[k].v1.y==deathBlocks.get(j).edges[l].v2.y
            && triBlocks.get(i).edges[k].v2.x==deathBlocks.get(j).edges[l].v1.x && triBlocks.get(i).edges[k].v2.y==deathBlocks.get(j).edges[l].v1.y) {
            deathBlocks.get(j).edges[l].open = false;
          }
        }
      }
    }

    for (int j=0; j<triDeathBlocks.size(); j++) { //test triBlocks against trideathblocks
      for (int k=0; k<3; k+=2) {
        for (int l=0; l<3; l+=2) {
          if (triBlocks.get(i).edges[k].v1.x==triDeathBlocks.get(j).edges[l].v2.x && triBlocks.get(i).edges[k].v1.y==triDeathBlocks.get(j).edges[l].v2.y
            && triBlocks.get(i).edges[k].v2.x==triDeathBlocks.get(j).edges[l].v1.x && triBlocks.get(i).edges[k].v2.y==triDeathBlocks.get(j).edges[l].v1.y) {
            triDeathBlocks.get(j).edges[l].open = false;
          }
        }
      }
      if (triBlocks.get(i).edges[1].v1.x==triDeathBlocks.get(j).edges[1].v2.x && triBlocks.get(i).edges[1].v1.y==triDeathBlocks.get(j).edges[1].v2.y
        && triBlocks.get(i).edges[1].v2.x==triDeathBlocks.get(j).edges[1].v1.x && triBlocks.get(i).edges[1].v2.y==triDeathBlocks.get(j).edges[1].v1.y) {
        triDeathBlocks.get(j).edges[1].open = false;
      }
    }
  }

  for (int i=0; i<deathBlocks.size(); i++) { //test deathblocks against deathblocks
    for (int j=0; j<deathBlocks.size(); j++) {
      if (i!=j) {
        if (deathBlocks.get(i).edges[0].v1.x==deathBlocks.get(j).edges[2].v2.x && deathBlocks.get(i).edges[0].v1.y==deathBlocks.get(j).edges[2].v2.y
          && deathBlocks.get(i).edges[0].v2.x==deathBlocks.get(j).edges[2].v1.x && deathBlocks.get(i).edges[0].v2.y==deathBlocks.get(j).edges[2].v1.y) {
          deathBlocks.get(i).edges[0].open = false; 
          deathBlocks.get(j).edges[2].open = false;
        }
        if (deathBlocks.get(i).edges[1].v1.x==deathBlocks.get(j).edges[3].v2.x && deathBlocks.get(i).edges[1].v1.y==deathBlocks.get(j).edges[3].v2.y
          && deathBlocks.get(i).edges[1].v2.x==deathBlocks.get(j).edges[3].v1.x && deathBlocks.get(i).edges[1].v2.y==deathBlocks.get(j).edges[3].v1.y) {
          deathBlocks.get(i).edges[1].open = false; 
          deathBlocks.get(j).edges[3].open = false;
        }
      }
    }

    for (int j=0; j<triDeathBlocks.size(); j++) { //test deathblocks against trideathblocks
      for (int k=0; k<3; k+=2) {
        if (deathBlocks.get(i).edges[0].v1.x==triDeathBlocks.get(j).edges[k].v2.x && deathBlocks.get(i).edges[0].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && deathBlocks.get(i).edges[0].v2.x==triDeathBlocks.get(j).edges[k].v1.x && deathBlocks.get(i).edges[0].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          deathBlocks.get(i).edges[0].open = false;
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (deathBlocks.get(i).edges[1].v1.x==triDeathBlocks.get(j).edges[k].v2.x && deathBlocks.get(i).edges[1].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && deathBlocks.get(i).edges[1].v2.x==triDeathBlocks.get(j).edges[k].v1.x && deathBlocks.get(i).edges[1].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          deathBlocks.get(i).edges[1].open = false;
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (deathBlocks.get(i).edges[2].v1.x==triDeathBlocks.get(j).edges[k].v2.x && deathBlocks.get(i).edges[2].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && deathBlocks.get(i).edges[2].v2.x==triDeathBlocks.get(j).edges[k].v1.x && deathBlocks.get(i).edges[2].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          deathBlocks.get(i).edges[2].open = false;
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
      for (int k=0; k<3; k+=2) {
        if (deathBlocks.get(i).edges[3].v1.x==triDeathBlocks.get(j).edges[k].v2.x && deathBlocks.get(i).edges[3].v1.y==triDeathBlocks.get(j).edges[k].v2.y
          && deathBlocks.get(i).edges[3].v2.x==triDeathBlocks.get(j).edges[k].v1.x && deathBlocks.get(i).edges[3].v2.y==triDeathBlocks.get(j).edges[k].v1.y) {
          deathBlocks.get(i).edges[3].open = false;
          triDeathBlocks.get(j).edges[k].open = false;
        }
      }
    }
  }

  for (int i=0; i<triDeathBlocks.size(); i++) { //trideathblocks against trideathblocks
    for (int j=0; j<triDeathBlocks.size(); j++) {
      for (int k=0; k<3; k+=2) {
        for (int l=0; l<3; l+=2) {
          if (triDeathBlocks.get(i).edges[k].v1.x==triDeathBlocks.get(j).edges[l].v2.x && triDeathBlocks.get(i).edges[k].v1.y==triDeathBlocks.get(j).edges[l].v2.y
            && triDeathBlocks.get(i).edges[k].v2.x==triDeathBlocks.get(j).edges[l].v1.x && triDeathBlocks.get(i).edges[k].v2.y==triDeathBlocks.get(j).edges[l].v1.y) {
            triDeathBlocks.get(i).edges[k].open = false;
            triDeathBlocks.get(j).edges[l].open = false;
          }
        }
      }
      if (triDeathBlocks.get(i).edges[1].v1.x==triDeathBlocks.get(j).edges[1].v2.x && triDeathBlocks.get(i).edges[1].v1.y==triDeathBlocks.get(j).edges[1].v2.y
        && triDeathBlocks.get(i).edges[1].v2.x==triDeathBlocks.get(j).edges[1].v1.x && triDeathBlocks.get(i).edges[1].v2.y==triDeathBlocks.get(j).edges[1].v1.y) {
        triDeathBlocks.get(i).edges[1].open = false;
        triDeathBlocks.get(j).edges[1].open = false;
      }
    }
  }
}

//-----------------INTERSECTIONS-----------------//

//formulas

boolean XOR(boolean x, boolean y) {
  return ( ( x || y ) && ! ( x && y ) );
}

float pointPointDist(PVector p1, PVector p2) {
  float dist = sqrt((p2.x-p1.x)*(p2.x-p1.x)+(p2.y-p1.y)*(p2.y-p1.y));
  return dist;
}

PVector midPoint(PVector p1, PVector p2) {
  float xP;
  float yP;
  xP = (p1.x+p2.x)*0.5;
  yP = (p1.y+p2.y)*0.5;
  return new PVector(xP, yP);
}

PVector intersectionPoint(edge e1, edge e2) {
  float x;
  float y;
  PVector p1 = e1.v1;
  PVector p2 = e1.v2;
  PVector p3 = e2.v1;
  PVector p4 = e2.v2;

  x= ((((p1.x*p2.y)-(p1.y*p2.x)) * (p3.x-p4.x)) - ((p1.x-p2.x)*((p3.x*p4.y)-(p3.y*p4.x))))  /  (((p1.x-p2.x)*(p3.y-p4.y)) - ((p1.y-p2.y)*(p3.x-p4.x)));
  y= ((((p1.x*p2.y)-(p1.y*p2.x)) * (p3.y-p4.y)) - ((p1.y-p2.y)*((p3.x*p4.y)-(p3.y*p4.x))))  /  (((p1.x-p2.x)*(p3.y-p4.y)) - ((p1.y-p2.y)*(p3.x-p4.x)));

  return new PVector(x, y);
}



boolean intersection(edge e1, edge e2) { //test for intersections
  float x1 = e1.v1.x; 
  float x2 = e1.v2.x;
  float x3 = e2.v1.x; 
  float x4 = e2.v2.x;
  float y1 = e1.v1.y; 
  float y2 = e1.v2.y;
  float y3 = e2.v1.y; 
  float y4 = e2.v2.y;
  float aN =((x4-x3)*(y1-y3))-((y4-y3)*(x1-x3));
  float bN = ((x2-x1)*(y1-y3))-((y2-y1)*(x1-x3));
  float d = ((y4-y3)*(x2-x1))-((x4-x3)*(y2-y1));
  if (d==0) {
    return false;
  }
  if (aN/d<0 || aN/d>1  ||  bN/d<0 || bN/d>1) return false;
  else return true;
}

boolean triPointInt(float x1, float y1, float x2, float y2, float x3, float y3, float px, float py) {

  // get the area of the triangle
  float areaOrig = abs( (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1) );

  // get the area of 3 triangles made between the point
  // and the corners of the triangle
  float area1 =    abs( (x1-px)*(y2-py) - (x2-px)*(y1-py) );
  float area2 =    abs( (x2-px)*(y3-py) - (x3-px)*(y2-py) );
  float area3 =    abs( (x3-px)*(y1-py) - (x1-px)*(y3-py) );
  if (area1 + area2 + area3 == areaOrig) {
    return true;
  }
  return false;
}

// POINT/RECTANGLE
boolean rectPointInt(float rx, float ry, float rw, float rh, float px, float py) {

  // is the point inside the rectangle's bounds?
  if (px >= rx &&        // right of the left edge AND
    px <= rx + rw &&   // left of the right edge AND
    py >= ry &&        // below the top AND
    py <= ry + rh) {   // above the bottom
    return true;
  }
  return false;
}

PVector closestPointLineCircle(float x1, float y1, float x2, float y2, float cx, float cy) {

  edge e = new edge(x1, y1, x2, y2);
  PVector cPos = new PVector(cx, cy);

  float distX = e.v1.x - e.v2.x;
  float distY = e.v1.y - e.v2.y;
  float len = sqrt( (distX*distX) + (distY*distY) );
  float dot = ( ((cPos.x-e.v1.x)*(e.v2.x-e.v1.x)) + ((cPos.y-e.v1.y)*(e.v2.y-e.v1.y)) ) / pow(len, 2);
  PVector closestPoint = new PVector((e.v1.x + (dot * (e.v2.x-e.v1.x))), (e.v1.y + (dot * (e.v2.y-e.v1.y))));

  return closestPoint;
}

boolean lineCircleInt(edge e, PVector cPos, float r) {
  boolean inside1 = pointCircleInt(e.v1, cPos, r);
  boolean inside2 = pointCircleInt(e.v2, cPos, r);
  if (inside1 || inside2) return true;
  float distX = e.v1.x - e.v2.x;
  float distY = e.v1.y - e.v2.y;
  float len = sqrt( (distX*distX) + (distY*distY) );
  float dot = ( ((cPos.x-e.v1.x)*(e.v2.x-e.v1.x)) + ((cPos.y-e.v1.y)*(e.v2.y-e.v1.y)) ) / pow(len, 2);
  PVector closestPoint = new PVector((e.v1.x + (dot * (e.v2.x-e.v1.x))), (e.v1.y + (dot * (e.v2.y-e.v1.y))));
  boolean onSegment = linePointInt(e.v1, e.v2, closestPoint);
  if (!onSegment) return false;
  distX = closestPoint.x - cPos.x;
  distY = closestPoint.y - cPos.y;
  float distance = sqrt( (distX*distX) + (distY*distY) );
  if (distance <= r) {
    return true;
  }
  return false;
}
boolean pointCircleInt(PVector p, PVector c, float r) {
  float distX = p.x - c.x;
  float distY = p.y - c.y;
  float distance = sqrt( (distX*distX) + (distY*distY) );
  if (distance <= r) {
    return true;
  }
  return false;
}
boolean linePointInt(PVector v1, PVector v2, PVector p) {
  float d1 = dist(p.x, p.y, v1.x, v1.y);
  float d2 = dist(p.x, p.y, v2.x, v2.y);
  float lineLen = dist(v1.x, v1.y, v2.x, v2.y);
  float buffer = 0.1;    // higher # = less accurate
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
    return true;
  }
  return false;
}
float pointLineDistance(float px, float py, float x1, float y1, float x2, float y2) {

  float A = px - x1;
  float B = py - y1;
  float C = x2 - x1;
  float D = y2 - y1;

  float dot = A * C + B * D;
  float len_sq = C * C + D * D;
  float param = -1;
  if (len_sq != 0) //in case of 0 length line
    param = dot / len_sq;

  float xx, yy;

  if (param < 0) {
    xx = x1;
    yy = y1;
  } else if (param > 1) {
    xx = x2;
    yy = y2;
  } else {
    xx = x1 + param * C;
    yy = y1 + param * D;
  }

  float dx = px - xx;
  float dy = py - yy;
  return (float) Math.sqrt(dx * dx + dy * dy);
}

boolean circleCircleInt(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

  // get distance between the circle's centers
  // use the Pythagorean Theorem to compute the distance
  float distX = c1x - c2x;
  float distY = c1y - c2y;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the sum of the circle's
  // radii, the circles are touching!
  if (distance <= c1r+c2r) {
    return true;
  }
  return false;
}

boolean circleRectInt(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

  float testX = cx;
  float testY = cy;

  if (cx < rx)         testX = rx;      // test left edge
  else if (cx > rx+rw) testX = rx+rw;   // right edge
  if (cy < ry)         testY = ry;      // top edge
  else if (cy > ry+rh) testY = ry+rh;   // bottom edge

  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  if (distance <= radius) {
    return true;
  }
  return false;
}

ArrayList<PVector> CircleLineIntersectionPoints(PVector pointA, PVector pointB, PVector center, float radius) {
  float baX = pointB.x - pointA.x;
  float baY = pointB.y - pointA.y;
  float caX = center.x - pointA.x;
  float caY = center.y - pointA.y;


  ArrayList<PVector> points;
  points = new ArrayList<PVector>();

  float a = baX * baX + baY * baY;
  float bBy2 = baX * caX + baY * caY;
  float c = caX * caX + caY * caY - radius * radius;

  float pBy2 = bBy2 / a;
  float q = c / a;

  float disc = pBy2 * pBy2 - q;
  if (disc < 0) {
    return points;
  }
  // if disc == 0 ... dealt with later
  double tmpSqrt = Math.sqrt(disc);
  double abScalingFactor1 = -pBy2 + tmpSqrt;
  double abScalingFactor2 = -pBy2 - tmpSqrt;

  PVector p1 = new PVector((float)(pointA.x - baX * abScalingFactor1), (float)(pointA.y - baY * abScalingFactor1));
  if (disc == 0) { // abScalingFactor1 == abScalingFactor2
    points.add(p1);
    return points;
  }
  PVector p2 = new PVector((float)(pointA.x - baX * abScalingFactor2), (float)(pointA.y - baY * abScalingFactor2));
  points.add(p1);
  points.add(p2);

  return points;
}

//-----------------Collision detection-----------------//

void detectCircles() {

  for (int i=0; i<coins.size(); i++) { //collision with coins
    coin c = coins.get(i);
    PVector cPos = new PVector(c.pos.x, c.pos.y);
    for (int j=0; j<4; j++) {
      if (lineCircleInt(Mover.edges[j], cPos, c.radius)) {
        coins.remove(i);
        if (coinTimer<=0) {
          if (soundOn) coinSound.play();
          coinTimer=5;
        }
        return;
      }
    }
  }

  for (int i=0; i<buttons.size(); i++) { //collision with buttons
    button b = buttons.get(i);
    PVector bPos = new PVector(b.pos.x, b.pos.y);
    if (circleRectInt(bPos.x, bPos.y, b.r, Mover.pos.x, Mover.pos.y, Mover.size.x, Mover.size.y)) {
      buttons.get(i).triggered();
      buttons.get(i).canClickMover = false;
      return;
    } else buttons.get(i).canClickMover = true;
  }

  for (int i=0; i<lasers.size(); i++) { //collision with lasers
    laser l = lasers.get(i);
    PVector lPos = new PVector(l.pos.x, l.pos.y);
    if (lineCircleInt(Mover.edges[0], lPos, l.r) 
      && !pointCircleInt(Mover.corner1, lPos, l.r)
      && !pointCircleInt(Mover.corner2, lPos, l.r)) {
      Mover.pos.y= lPos.y+l.r;
    }
    if (lineCircleInt(Mover.edges[1], lPos, l.r)
      && !pointCircleInt(Mover.corner2, lPos, l.r)
      && !pointCircleInt(Mover.corner3, lPos, l.r)) {
      Mover.pos.x= lPos.x-l.r-Mover.size.x;
    }
    if (lineCircleInt(Mover.edges[2], lPos, l.r)
      && !pointCircleInt(Mover.corner3, lPos, l.r)
      && !pointCircleInt(Mover.corner4, lPos, l.r)) {
      Mover.pos.y= lPos.y-l.r-Mover.size.x;
    }
    if (lineCircleInt(Mover.edges[3], lPos, l.r)
      && !pointCircleInt(Mover.corner4, lPos, l.r)
      && !pointCircleInt(Mover.corner1, lPos, l.r)) {
      Mover.pos.x= lPos.x+l.r;
    }
    if (pointCircleInt(Mover.corner1, lPos, l.r)) {  //this is really fuckin weird but its working so whatever
      PVector v = new PVector(Mover.corner1.x-lPos.x, Mover.corner1.y-lPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(lPos.x+v.x/magV*l.r, lPos.y+v.y/magV*l.r);
      if (Mover.canGoRight()) Mover.pos.x += (p.x-l.pos.x)/2; 

      if (Mover.canGoDown()) Mover.pos.y += (p.y-l.pos.y)/2;
    }
    if (pointCircleInt(Mover.corner2, lPos, l.r)) {
      PVector v = new PVector(Mover.corner2.x-lPos.x, Mover.corner2.y-lPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(lPos.x+v.x/magV*l.r, lPos.y+v.y/magV*l.r);
      if (Mover.canGoLeft()) Mover.pos.x += (p.x -l.pos.x-Mover.size.x)/8;

      if (Mover.canGoDown()) Mover.pos.y += (p.y -l.pos.y)/2;
    }
    if (pointCircleInt(Mover.corner3, lPos, l.r)) {
      PVector v = new PVector(Mover.corner3.x-lPos.x, Mover.corner3.y-lPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(lPos.x+v.x/magV*l.r, lPos.y+v.y/magV*l.r);
      if (Mover.canGoLeft()) Mover.pos.x += (p.x -l.pos.x-Mover.size.x)/8;

      if (Mover.canGoUp()) Mover.pos.y += (p.y -l.pos.y-Mover.size.y)/8;
    }
    if (pointCircleInt(Mover.corner4, lPos, l.r)) {
      PVector v = new PVector(Mover.corner4.x-lPos.x, Mover.corner4.y-lPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(lPos.x+v.x/magV*l.r, lPos.y+v.y/magV*l.r);
      if (Mover.canGoRight()) Mover.pos.x += (p.x -l.pos.x)/2;

      if (Mover.canGoUp()) Mover.pos.y += (p.y -l.pos.y-Mover.size.y)/8;
    }
  }

  for (int i=0; i<triggers.size(); i++) { //collision with triggers
    trigger t = triggers.get(i);
    PVector tPos = new PVector(t.pos.x, t.pos.y);
    if (lineCircleInt(Mover.edges[0], tPos, t.r) 
      && !pointCircleInt(Mover.corner1, tPos, t.r)
      && !pointCircleInt(Mover.corner2, tPos, t.r)) {
      Mover.pos.y= tPos.y+t.r;
    }
    if (lineCircleInt(Mover.edges[1], tPos, t.r)
      && !pointCircleInt(Mover.corner2, tPos, t.r)
      && !pointCircleInt(Mover.corner3, tPos, t.r)) {
      Mover.pos.x= tPos.x-t.r-Mover.size.x;
    }
    if (lineCircleInt(Mover.edges[2], tPos, t.r)
      && !pointCircleInt(Mover.corner3, tPos, t.r)
      && !pointCircleInt(Mover.corner4, tPos, t.r)) {
      Mover.pos.y= tPos.y-t.r-Mover.size.x;
    }
    if (lineCircleInt(Mover.edges[3], tPos, t.r)
      && !pointCircleInt(Mover.corner4, tPos, t.r)
      && !pointCircleInt(Mover.corner1, tPos, t.r)) {
      Mover.pos.x= tPos.x+t.r;
    }
    if (pointCircleInt(Mover.corner1, tPos, t.r)) {  //this is really fuckin weird but its working so whatever
      PVector v = new PVector(Mover.corner1.x-tPos.x, Mover.corner1.y-tPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(tPos.x+v.x/magV*t.r, tPos.y+v.y/magV*t.r);
      if (Mover.canGoRight()) Mover.pos.x += (p.x-t.pos.x)/2; 

      if (Mover.canGoDown()) Mover.pos.y += (p.y-t.pos.y)/2;
    }
    if (pointCircleInt(Mover.corner2, tPos, t.r)) {
      PVector v = new PVector(Mover.corner2.x-tPos.x, Mover.corner2.y-tPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(tPos.x+v.x/magV*t.r, tPos.y+v.y/magV*t.r);
      if (Mover.canGoLeft()) Mover.pos.x += (p.x -t.pos.x-Mover.size.x)/8;

      if (Mover.canGoDown()) Mover.pos.y += (p.y -t.pos.y)/2;
    }
    if (pointCircleInt(Mover.corner3, tPos, t.r)) {
      PVector v = new PVector(Mover.corner3.x-tPos.x, Mover.corner3.y-tPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(tPos.x+v.x/magV*t.r, tPos.y+v.y/magV*t.r);
      if (Mover.canGoLeft()) Mover.pos.x += (p.x -t.pos.x-Mover.size.x)/8;

      if (Mover.canGoUp()) Mover.pos.y += (p.y -t.pos.y-Mover.size.y)/8;
    }
    if (pointCircleInt(Mover.corner4, tPos, t.r)) {
      PVector v = new PVector(Mover.corner4.x-tPos.x, Mover.corner4.y-tPos.y);
      float magV = sqrt(v.x*v.x+v.y*v.y);
      PVector p = new PVector(tPos.x+v.x/magV*t.r, tPos.y+v.y/magV*t.r);
      if (Mover.canGoRight()) Mover.pos.x += (p.x -t.pos.x)/2;

      if (Mover.canGoUp()) Mover.pos.y += (p.y -t.pos.y-Mover.size.y)/8;
    }
  }

  for (int i=0; i<enemyArrays.size(); i++) { //collision with enemies

    enemy e = enemyArrays.get(i);
    for (int j=0; j<e.enemyAmount; j++) {
      if (!e.gaps.contains(j)) {
        PVector ePos = new PVector(e.enemies[j].x, e.enemies[j].y);
        if (lineCircleInt(Mover.edges[0], ePos, e.size/2) 
          && !pointCircleInt(Mover.corner1, ePos, e.size/2)
          && !pointCircleInt(Mover.corner2, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (lineCircleInt(Mover.edges[1], ePos, e.size/2)
          && !pointCircleInt(Mover.corner2, ePos, e.size/2)
          && !pointCircleInt(Mover.corner3, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (lineCircleInt(Mover.edges[2], ePos, e.size/2)
          && !pointCircleInt(Mover.corner3, ePos, e.size/2)
          && !pointCircleInt(Mover.corner4, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (lineCircleInt(Mover.edges[3], ePos, e.size/2)
          && !pointCircleInt(Mover.corner4, ePos, e.size/2)
          && !pointCircleInt(Mover.corner1, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner1, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner2, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner3, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner4, ePos, e.size/2)) {
          if (Mover.dead == false)death();
        }
      }
    }
  }

  for (int i=0; i<radialEnemies.size(); i++) { //collision with radial enemies
    radialEnemy e = radialEnemies.get(i);
    PVector ePos = new PVector(e.center.x, e.center.y);
    for (int j=0; j<e.enemyPositions.length; j++) {
      if (!e.gaps.hasValue(j)) {
        PVector eEPos = PVector.add(ePos, e.enemyPositions[j]);
        if (lineCircleInt(Mover.edges[0], eEPos, enemySize/2) 
          && !pointCircleInt(Mover.corner1, eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner2, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (lineCircleInt(Mover.edges[1], eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner2, eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner3, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (lineCircleInt(Mover.edges[2], eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner3, eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner4, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (lineCircleInt(Mover.edges[3], eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner4, eEPos, enemySize/2)
          && !pointCircleInt(Mover.corner1, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner1, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner2, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner3, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
        if (pointCircleInt(Mover.corner4, eEPos, enemySize/2)) {
          if (Mover.dead == false)death();
        }
      }
    }
  }
}

void detectEdges() { //Test open block edges collision with mover

  for (int i=0; i<doors.size(); i++) { //collision with doors
    if (!doors.get(i).triggered) {
      edge top = Mover.edges[0];
      edge right = Mover.edges[1];
      edge bottom = Mover.edges[2];
      edge left = Mover.edges[3];
      door d = doors.get(i);
      edge door = new edge(d.v1.x, d.v1.y, d.v2.x, d.v2.y);

      if ((intersection(top, door) || intersection(bottom, door)) && (door.v1.x==door.v2.x || door.v1.y==door.v2.y) 
        && !(intersection(right, door) || intersection(left, door)) && door.v1.x == door.v2.x) {
        if (Mover.pos.x>door.v1.x-(Mover.size.x/2)) {
          //Mover.vel.x=1*abs(Mover.vel.x);
          Mover.pos.x=door.v1.x;
        } else {
          //Mover.vel.x=-1*abs(Mover.vel.x);
          Mover.pos.x=door.v1.x-Mover.size.x;
        }
      } else if ((intersection(right, door) || intersection(left, door)) && (door.v1.x==door.v2.x || door.v1.y==door.v2.y)  
        && !(intersection(top, door) || intersection(bottom, door)) && door.v1.y == door.v2.y) {
        if (Mover.pos.y>door.v1.y-(Mover.size.y/2)) {
          //Mover.vel.y=1*abs(Mover.vel.y);
          Mover.pos.y=door.v1.y;
        } else {
          //Mover.vel.y=-1*abs(Mover.vel.y);
          Mover.pos.y=door.v1.y-Mover.size.y;
        }
      } else if (intersection(left, door) && intersection(bottom, door)) {

        //float n = Mover.vel.x;
        //Mover.vel.x=1*abs(Mover.vel.y); 
        //Mover.vel.y=-1*abs(n);
        float x = Mover.pos.x; 
        float y = Mover.pos.y;
        float a = -1; 
        float b = 1; 
        float c = -1*(door.v1.y-door.v1.x-Mover.size.y);
        Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
        Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
      } else if (intersection(right, door) && intersection(bottom, door)) {

        //float n = Mover.vel.x;
        //Mover.vel.x=-1*abs(Mover.vel.y); 
        //Mover.vel.y=-1*abs(n);
        float x = Mover.pos.x; 
        float y = Mover.pos.y;
        float a = 1; 
        float b = 1; 
        float c = -1*(door.v1.y+door.v1.x-Mover.size.y*2);
        Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
        Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
      } else if (intersection(left, door) && intersection(top, door)) {

        //float n = Mover.vel.x;
        //Mover.vel.x=1*abs(Mover.vel.y); 
        //Mover.vel.y=1*abs(n);
        float x = Mover.pos.x; 
        float y = Mover.pos.y;
        float a = 1; 
        float b = 1; 
        float c = -1*(door.v1.y+door.v1.x);
        Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
        Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
      } else if (intersection(right, door) && intersection(top, door)) {

        //float n = Mover.vel.x;
        //Mover.vel.x=-1*abs(Mover.vel.y); 
        //Mover.vel.y=1*abs(n);
        float x = Mover.pos.x; 
        float y = Mover.pos.y;
        float a = -1; 
        float b = 1; 
        float c = -1*(door.v1.y-door.v1.x+Mover.size.y);
        Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
        Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
      } else if (intersection(top, door)&&!intersection(bottom, door)&&!intersection(left, door)&&!intersection(right, door)) {

        //Mover.vel.y=1*abs(Mover.vel.y);
        if (door.v1.y>door.v2.y) {
          Mover.pos.y=door.v1.y;
        } else {
          Mover.pos.y=door.v2.y;
        }
      } else if (intersection(bottom, door)&&!intersection(top, door)&&!intersection(left, door)&&!intersection(right, door)) {

        //Mover.vel.y=-1*abs(Mover.vel.y);
        if (door.v1.y>door.v2.y) {
          Mover.pos.y=door.v2.y-Mover.size.y;
        } else {
          Mover.pos.y=door.v1.y-Mover.size.y;
        }
      } else if (intersection(left, door)&&!intersection(bottom, door)&&!intersection(top, door)&&!intersection(right, door)) {

        //Mover.vel.x=1*abs(Mover.vel.x);
        Mover.pos.x=door.v2.x;
      } else if (intersection(right, door)&&!intersection(bottom, door)&&!intersection(left, door)&&!intersection(top, door)) {

        //Mover.vel.x=-1*abs(Mover.vel.x);
        Mover.pos.x=door.v1.x-Mover.size.x;
      }
    }
  }

  for (int j=0; j<blocks.size(); j++) { //collision with blocks
    edge bTop = blocks.get(j).edges[0];
    edge bRight = blocks.get(j).edges[1];
    edge bBottom = blocks.get(j).edges[2];
    edge bLeft = blocks.get(j).edges[3];

    if ((intersection(Mover.edges[1], bTop) && bTop.open && Mover.corner3.x > blocks.get(j).corner1.x+(cornerGap-4))
      || (intersection(Mover.edges[3], bTop) && bTop.open && Mover.corner4.x < blocks.get(j).corner2.x-(cornerGap-4))) {
      if (Mover.pos.y+Mover.size.y<bTop.v1.y+cornerGap) {
        Mover.pos.y=bTop.v1.y-Mover.size.y;

        //Mover.vel.y=-1*abs(Mover.vel.y);
      }
    }
    if ((intersection(Mover.edges[0], bLeft) && bLeft.open && Mover.corner2.y < blocks.get(j).corner4.y-(cornerGap-4))
      || (intersection(Mover.edges[2], bLeft) && bLeft.open && Mover.corner3.y > blocks.get(j).corner1.y+(cornerGap-4))) {
      if (Mover.pos.x+Mover.size.x<bLeft.v1.x+cornerGap) {
        Mover.pos.x=bLeft.v1.x-Mover.size.x;

        //Mover.vel.x=-1*abs(Mover.vel.x);
      }
    }
    if ((intersection(Mover.edges[1], bBottom) && bBottom.open && Mover.corner2.x > blocks.get(j).corner4.x+(cornerGap-4))
      || (intersection(Mover.edges[3], bBottom) && bBottom.open && Mover.corner1.x < blocks.get(j).corner3.x-(cornerGap-4))) {
      if (Mover.pos.y>bBottom.v1.y-cornerGap) {
        Mover.pos.y=bBottom.v1.y;

        //Mover.vel.y=1*abs(Mover.vel.y);
      }
    }
    if ((intersection(Mover.edges[0], bRight) && bRight.open && Mover.corner1.y < blocks.get(j).corner3.y-(cornerGap-4))
      || (intersection(Mover.edges[2], bRight) && bRight.open && Mover.corner4.y > blocks.get(j).corner2.y+(cornerGap-4))) {
      if (Mover.pos.x>bRight.v1.x-cornerGap) {
        Mover.pos.x=bRight.v1.x;

        //Mover.vel.x=1*abs(Mover.vel.x);
      }
    }
  }

  for (int j=0; j<deathBlocks.size(); j++) { //collision with deathblocks
    for (int k=0; k<4; k++) {
      for (int i=0; i<4; i++) {
        if (intersection(Mover.edges[k], deathBlocks.get(j).edges[i])) {
          PVector ints = intersectionPoint(Mover.edges[k], deathBlocks.get(j).edges[i]);
          boolean doorTouch=false;
          for (int l=0; l<doors.size(); l++) {
            door dor = doors.get(l);
            if (pointLineDistance(ints.x, ints.y, dor.v1.x, dor.v1.y, dor.v2.x, dor.v2.y) < 4) doorTouch=true;
          }
          if (!Mover.dead && !doorTouch)death();
        }
      }
    }
  }

  for (int j=0; j<triDeathBlocks.size(); j++) { //collision with trideathblocks

    for (int k=0; k<4; k++) {
      for (int i=0; i<3; i++) {
        if (intersection(Mover.edges[k], triDeathBlocks.get(j).edges[i])) {
          PVector ints = intersectionPoint(Mover.edges[k], triDeathBlocks.get(j).edges[i]);
          boolean doorTouch=false;
          for (int l=0; l<doors.size(); l++) {
            door dor = doors.get(l);
            if (pointLineDistance(ints.x, ints.y, dor.v1.x, dor.v1.y, dor.v2.x, dor.v2.y) < 4) doorTouch=true;
          }
          if (!Mover.dead && !doorTouch)death();
        }
      }
    }
  }


  for (int i=0; i<triBlocks.size(); i++) { //collision with triblocks 
    int rotation = triBlocks.get(i).rotation;
    edge diagonal = triBlocks.get(i).edges[1];

    if (rotation == 1) {
      edge hor = triBlocks.get(i).edges[0]; 
      edge vert = triBlocks.get(i).edges[2];
      if ((intersection(Mover.edges[1], hor) && hor.open)&& Mover.corner3.x > triBlocks.get(i).corner1.x+(cornerGap-1)
        || (intersection(Mover.edges[3], hor) && hor.open)) {
        if (Mover.pos.y+Mover.size.y<hor.v1.y+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingDown = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=-1*abs(Mover.vel.y);
          if (triBlocks.get(i).movable && triBlocks.get(i).canGoDown && !triBlocks.get(i).dying) {
            triBlocks.get(i).fluidMoveD(true);
          } else {
            if (canMoveY(hor.v1.y-Mover.size.y) || !triBlocks.get(i).movable)Mover.pos.y=hor.v1.y-Mover.size.y;
          }
        }
      }
      if ((intersection(Mover.edges[0], vert) && vert.open)
        || (intersection(Mover.edges[2], vert) && vert.open)&& Mover.corner3.y > triBlocks.get(i).corner1.y+(cornerGap-1)) {
        if (Mover.pos.x+Mover.size.x<vert.v1.x+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingRight = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=-1*abs(Mover.vel.x);
          if (triBlocks.get(i).movable && triBlocks.get(i).canGoRight && !triBlocks.get(i).dying) {
            triBlocks.get(i).fluidMoveR(true);
          } else {
            if (canMoveX(vert.v1.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=vert.v1.x-Mover.size.x;
          }
        }
      }
      if ((intersection(Mover.edges[0], diagonal) && diagonal.open)
        || (intersection(Mover.edges[3], diagonal) && diagonal.open)) {
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingUp = true;
        triBlocks.get(i).goingLeft = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoUp || triBlocks.get(i).canGoLeft)) {
          triBlocks.get(i).fluidMoveUL(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoUp || !triBlocks.get(i).canGoLeft))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=1*abs(Mover.vel.y); 
            // Mover.vel.y=1*abs(n);
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = 1; 
            float b = 1; 
            float c = -1*(triBlocks.get(i).pos.y+triBlocks.get(i).pos.x+triBlocks.get(i).size.x);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>triBlocks.get(i).pos.y+ (triBlocks.get(i).size.y/2)) {
              if (canMoveY(triBlocks.get(i).pos.y+triBlocks.get(i).size.y) || !triBlocks.get(i).movable)Mover.pos.y=triBlocks.get(i).pos.y+triBlocks.get(i).size.y;
            } else {
              if (canMoveX(triBlocks.get(i).pos.x+triBlocks.get(i).size.x) || !triBlocks.get(i).movable)Mover.pos.x=triBlocks.get(i).pos.x+triBlocks.get(i).size.x;
            }
          }
        }
      }
    }

    if (rotation == 3) {
      edge hor = triBlocks.get(i).edges[2]; 
      edge vert = triBlocks.get(i).edges[0];
      if ((intersection(Mover.edges[1], hor) && hor.open)
        || (intersection(Mover.edges[3], hor) && hor.open)&& Mover.corner4.x < triBlocks.get(i).corner1.x-(cornerGap-1)) {
        if (Mover.pos.y+Mover.size.y<hor.v1.y+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingDown = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=-1*abs(Mover.vel.y);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoDown) {
            triBlocks.get(i).fluidMoveD(true);
          } else {
            if (canMoveY(hor.v1.y-Mover.size.y) || !triBlocks.get(i).movable)Mover.pos.y=hor.v1.y-Mover.size.y;
          }
        }
      }
      if ((intersection(Mover.edges[0], vert) && vert.open)
        || (intersection(Mover.edges[2], vert) && vert.open)&& Mover.corner4.y > triBlocks.get(i).corner1.y+(cornerGap-1)) {
        if (Mover.pos.x>vert.v1.x-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingLeft = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=1*abs(Mover.vel.x);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoLeft) {
            triBlocks.get(i).fluidMoveL(true);
          } else {
            if (canMoveX(vert.v2.x) || !triBlocks.get(i).movable)Mover.pos.x=vert.v2.x;
          }
        }
      }
      if ((intersection(Mover.edges[0], diagonal) && diagonal.open)
        || (intersection(Mover.edges[1], diagonal) && diagonal.open)) {
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingUp = true;
        triBlocks.get(i).goingRight = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoUp || triBlocks.get(i).canGoRight)) {
          triBlocks.get(i).fluidMoveUR(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoUp || !triBlocks.get(i).canGoRight))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=-1*abs(Mover.vel.y); 
            //Mover.vel.y=1*abs(n);
          } else {
            //Mover.vel.x-=1; 
            //Mover.vel.y+=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = -1; 
            float b = 1; 
            float c = -1*(triBlocks.get(i).pos.y-triBlocks.get(i).pos.x+Mover.size.x);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>triBlocks.get(i).pos.y+ (triBlocks.get(i).size.y/2)) {
              if (canMoveY(triBlocks.get(i).pos.y+triBlocks.get(i).size.y) || !triBlocks.get(i).movable)Mover.pos.y=triBlocks.get(i).pos.y+triBlocks.get(i).size.y;
            } else {
              if (canMoveX(triBlocks.get(i).pos.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=triBlocks.get(i).pos.x-Mover.size.x;
            }
          }
        }
      }
    }
    if (rotation == 5) {
      edge hor = triBlocks.get(i).edges[0]; 
      edge vert = triBlocks.get(i).edges[2];
      if ((intersection(Mover.edges[1], hor) && hor.open)
        || (intersection(Mover.edges[3], hor) && hor.open)&& Mover.corner1.x < triBlocks.get(i).corner1.x-(cornerGap-1)) {
        if (Mover.pos.y>hor.v1.y-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingUp = true;
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoUp) {
            triBlocks.get(i).fluidMoveU(true);
          } else {
            if (canMoveY(hor.v1.y) || !triBlocks.get(i).movable)Mover.pos.y=hor.v1.y;
          }
        }
      }
      if ((intersection(Mover.edges[0], vert) && vert.open)&& Mover.corner1.y < triBlocks.get(i).corner1.y-(cornerGap-1)
        || (intersection(Mover.edges[2], vert) && vert.open)) {
        if (Mover.pos.x>vert.v1.x-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingLeft = true;
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoLeft) {
            triBlocks.get(i).fluidMoveL(true);
          } else {
            if (canMoveX(vert.v1.x) || !triBlocks.get(i).movable)Mover.pos.x=vert.v1.x;
          }
        }
      }
      if ((intersection(Mover.edges[1], diagonal) && diagonal.open)
        || (intersection(Mover.edges[2], diagonal) && diagonal.open)) {
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingDown= true;
        triBlocks.get(i).goingRight= true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoDown || triBlocks.get(i).canGoRight)) {
          triBlocks.get(i).fluidMoveDR(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoDown || !triBlocks.get(i).canGoRight))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=-1*abs(Mover.vel.y); 
            //Mover.vel.y=-1*abs(n);
          } else {
            //Mover.vel.x-=1; 
            //Mover.vel.y-=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = 1; 
            float b = 1; 
            float c = -1*(triBlocks.get(i).pos.y+triBlocks.get(i).pos.x+triBlocks.get(i).size.x-(Mover.size.x*2));
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.center.y>triBlocks.get(i).pos.y) {
              if (canMoveX(triBlocks.get(i).pos.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=triBlocks.get(i).pos.x-Mover.size.x;
            } else {
              if (canMoveY(triBlocks.get(i).pos.y-Mover.size.y) || !triBlocks.get(i).movable)Mover.pos.y=triBlocks.get(i).pos.y-Mover.size.y;
            }
          }
        }
      }
    }
    if (rotation == 7) {
      edge hor = triBlocks.get(i).edges[2]; 
      edge vert = triBlocks.get(i).edges[0];
      if ((intersection(Mover.edges[1], hor) && hor.open)&& Mover.corner2.x > triBlocks.get(i).corner1.x+(cornerGap-1)
        || (intersection(Mover.edges[3], hor) && hor.open)) {
        if (Mover.pos.y>hor.v1.y-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingUp= true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=1*abs(Mover.vel.y);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoUp) {
            triBlocks.get(i).fluidMoveU(true);
          } else {
            if (canMoveY(hor.v1.y) || !triBlocks.get(i).movable) Mover.pos.y=hor.v1.y;
          }
        }
      }
      if ((intersection(Mover.edges[0], vert) && vert.open)&& Mover.corner2.y < triBlocks.get(i).corner1.y-(cornerGap-1)
        || (intersection(Mover.edges[2], vert) && vert.open)) {
        if (Mover.pos.x+Mover.size.x<vert.v1.x+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingRight = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=-1*abs(Mover.vel.x);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoRight) {
            triBlocks.get(i).fluidMoveR(true);
          } else {
            if (canMoveX(vert.v1.x-Mover.size.x) || !triBlocks.get(i).movable) Mover.pos.x=vert.v1.x-Mover.size.x;
          }
        }
      }
      if ((intersection(Mover.edges[2], diagonal) && diagonal.open)
        || (intersection(Mover.edges[3], diagonal) && diagonal.open)) {
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingDown = true;
        triBlocks.get(i).goingLeft = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoDown || triBlocks.get(i).canGoLeft)) {
          triBlocks.get(i).fluidMoveDL(true);
          //triBlocks.get(i).fluidMoveU(true);
          //triBlocks.get(i).fluidMoveR(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoDown || !triBlocks.get(i).canGoLeft))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=1*abs(Mover.vel.y); 
            //Mover.vel.y=-1*abs(n);
          } else {
            //Mover.vel.x+=1; 
            //Mover.vel.y-=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = -1; 
            float b = 1; 
            float c = -1*( triBlocks.get(i).pos.y-triBlocks.get(i).pos.x-Mover.size.x);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.center.y>triBlocks.get(i).pos.y) {
              if (canMoveX(triBlocks.get(i).pos.x+triBlocks.get(i).size.x) || !triBlocks.get(i).movable)Mover.pos.x=triBlocks.get(i).pos.x+triBlocks.get(i).size.x;
            } else {
              if (canMoveY(triBlocks.get(i).pos.y-Mover.size.y) || !triBlocks.get(i).movable)Mover.pos.y=triBlocks.get(i).pos.y-Mover.size.y;
            }
          }
        }
      }
    }
    //*********** DOUBLE DIAGONAL ROTATIONS ***********
    if (rotation == 0) {
      triBlock t = triBlocks.get(i);
      float extention = (sqrt(2)/2*t.size.x)-(t.size.x/2);
      edge vert = t.edges[1]; 
      edge diag1 = t.edges[0];
      edge diag2 = t.edges[2];
      if ((intersection(Mover.edges[0], vert) && vert.open)
        || (intersection(Mover.edges[2], vert) && vert.open)) {
        if (Mover.pos.x>vert.v1.x-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingLeft = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=1*abs(Mover.vel.x);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoLeft) {
            triBlocks.get(i).fluidMoveL(true);
          } else {
            if (canMoveX(vert.v1.x) || !triBlocks.get(i).movable)Mover.pos.x=vert.v1.x;
          }
        }
      }
      if ((intersection(Mover.edges[1], diag1) && diag1.open)
        && (intersection(Mover.edges[1], diag2) && diag2.open)) {
        if (Mover.pos.x+Mover.size.x<t.corner1.x+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingRight = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=-1*abs(Mover.vel.x);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoRight) {
            triBlocks.get(i).fluidMoveR(true);
          } else {
            if (canMoveX(t.corner1.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=t.corner1.x-Mover.size.x;
          }
        }
      }
      if (((intersection(Mover.edges[1], diag1) && diag1.open)
        || (intersection(Mover.edges[2], diag1) && diag1.open))
        && !(intersection(Mover.edges[0], diag2) && diag2.open)
        && !(intersection(Mover.edges[1], diag2) && diag2.open)) { //diagonal1
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingDown= true;
        triBlocks.get(i).goingRight= true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoDown || triBlocks.get(i).canGoRight)) {
          triBlocks.get(i).fluidMoveDR(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoDown || !triBlocks.get(i).canGoRight))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=-1*abs(Mover.vel.y); 
            //Mover.vel.y=-1*abs(n);
          } else {
            //Mover.vel.x-=1; 
            //Mover.vel.y-=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = 1; 
            float b = 1; 
            float c = -1*(t.pos.y + t.pos.x - extention + (t.size.x/2) - (Mover.size.x*2));
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y) {
              if (canMoveX(t.pos.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=t.pos.x-Mover.size.x;
            } else {
              if (canMoveY(t.pos.y-triBlocks.get(i).size.y) || !triBlocks.get(i).movable)Mover.pos.y=t.pos.y-triBlocks.get(i).size.y;
            }
          }
        }
      }
      if (((intersection(Mover.edges[0], diag2) && diag2.open)
        || (intersection(Mover.edges[1], diag2) && diag2.open))
        && !(intersection(Mover.edges[1], diag1) && diag1.open)
        && !(intersection(Mover.edges[2], diag1) && diag1.open)) { //diagonal2
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingUp = true;
        triBlocks.get(i).goingRight = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoUp || triBlocks.get(i).canGoRight)) {
          triBlocks.get(i).fluidMoveUR(true); //weird
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoUp || !triBlocks.get(i).canGoRight))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=-1*abs(Mover.vel.y); 
            //Mover.vel.y=1*abs(n);
          } else {
            //Mover.vel.x-=1; 
            //Mover.vel.y+=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = -1; 
            float b = 1; 
            float c = -1*(t.pos.y - t.pos.x - extention + (t.size.x) + Mover.size.x);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y+ (t.size.y/2)) {
              if (canMoveY(t.pos.y+t.size.y) || !triBlocks.get(i).movable)Mover.pos.y=t.pos.y+t.size.y;
            } else {
              if (canMoveX(t.pos.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=t.pos.x-Mover.size.x;
            }
          }
        }
      }
    }
    if (rotation == 2) {
      triBlock t = triBlocks.get(i);
      float extention = (sqrt(2)/2*t.size.x)-(t.size.x/2);
      edge hor = t.edges[1]; 
      edge diag1 = t.edges[0];
      edge diag2 = t.edges[2];
      if ((intersection(Mover.edges[1], hor) && hor.open)
        || (intersection(Mover.edges[3], hor) && hor.open)) {
        if (Mover.pos.y>hor.v1.y-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingUp= true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=1*abs(Mover.vel.y);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoUp) {
            triBlocks.get(i).fluidMoveU(true);
          } else {
            if (canMoveY(hor.v1.y) || !triBlocks.get(i).movable)Mover.pos.y=hor.v1.y;
          }
        }
      }

      if ((intersection(Mover.edges[2], diag1) && diag1.open)
        && (intersection(Mover.edges[2], diag2) && diag2.open)) {
        if (Mover.pos.y+Mover.size.y<t.corner1.y+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingDown = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=-1*abs(Mover.vel.y);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoDown) {
            triBlocks.get(i).fluidMoveD(true);
          } else {
            if (canMoveY(t.corner1.y-Mover.size.y) || !triBlocks.get(i).movable)Mover.pos.y=t.corner1.y-Mover.size.y;
          }
        }
      }

      if (((intersection(Mover.edges[3], diag1) && diag1.open)
        || (intersection(Mover.edges[2], diag1) && diag1.open))
        && !(intersection(Mover.edges[2], diag2) && diag2.open)
        && !(intersection(Mover.edges[1], diag2) && diag2.open)) { //diagonal1
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingDown = true;
        triBlocks.get(i).goingLeft = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoDown || triBlocks.get(i).canGoLeft)) {
          triBlocks.get(i).fluidMoveDL(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoDown || !triBlocks.get(i).canGoLeft))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=1*abs(Mover.vel.y); 
            //Mover.vel.y=-1*abs(n);
          } else {
            //Mover.vel.x+=1; 
            //Mover.vel.y-=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = -1; 
            float b = 1; 
            float c = -1*(t.pos.y- t.pos.x - extention - (t.size.x/2) - Mover.size.x);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y) {
              if (canMoveX(t.pos.x+t.size.x) || !triBlocks.get(i).movable)Mover.pos.x=t.pos.x+t.size.x;
            } else {
              if (canMoveY(t.pos.y-t.size.y) || !triBlocks.get(i).movable)Mover.pos.y=t.pos.y-t.size.y;
            }
          }
        }
      }
      if (((intersection(Mover.edges[2], diag2) && diag2.open)
        || (intersection(Mover.edges[1], diag2) && diag2.open))
        && !(intersection(Mover.edges[3], diag1) && diag1.open)
        && !(intersection(Mover.edges[2], diag1) && diag1.open)) { //diagonal2
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingDown= true;
        triBlocks.get(i).goingRight= true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoDown || triBlocks.get(i).canGoRight)) {
          triBlocks.get(i).fluidMoveDR(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoDown || !triBlocks.get(i).canGoRight))) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=-1*abs(Mover.vel.y); 
            //Mover.vel.y=-1*abs(n);
          } else {
            //Mover.vel.x-=1; 
            //Mover.vel.y-=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = 1; 
            float b = 1; 
            float c = -1*(t.pos.y + t.pos.x + extention -(Mover.size.x*2));
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y) {
              if (canMoveX(t.pos.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=t.pos.x-Mover.size.x;
            } else {
              if (canMoveY(t.pos.y-t.size.y) || !triBlocks.get(i).movable)Mover.pos.y=t.pos.y-t.size.y;
            }
          }
        }
      }
    }
    if (rotation == 4) {
      triBlock t = triBlocks.get(i);
      float extention = (sqrt(2)/2*t.size.x)-(t.size.x/2);
      edge vert = t.edges[1]; 
      edge diag1 = t.edges[0];
      edge diag2 = t.edges[2];
      if ((intersection(Mover.edges[0], vert) && vert.open)
        || (intersection(Mover.edges[2], vert) && vert.open)) {
        if (Mover.pos.x+Mover.size.x<vert.v1.x+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingRight = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=-1*abs(Mover.vel.x);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoRight) {
            triBlocks.get(i).fluidMoveR(true);
          } else {
            if (canMoveX(vert.v1.x-Mover.size.x) || !triBlocks.get(i).movable)Mover.pos.x=vert.v1.x-Mover.size.x;
          }
        }
      }
      if ((intersection(Mover.edges[3], diag1) && diag1.open)
        && (intersection(Mover.edges[3], diag2) && diag2.open)) {
        if (Mover.pos.x>t.corner1.x-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingLeft = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.x=1*abs(Mover.vel.x);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoLeft) {
            triBlocks.get(i).fluidMoveL(true);
          } else {
            if (canMoveX(t.corner1.x) || !triBlocks.get(i).movable)Mover.pos.x=t.corner1.x;
          }
        }
      }
      if (((intersection(Mover.edges[3], diag1) && diag1.open)
        || (intersection(Mover.edges[0], diag1) && diag1.open))
        && !(intersection(Mover.edges[2], diag2) && diag2.open)
        && !(intersection(Mover.edges[3], diag2) && diag2.open)) { //diagonal1
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingUp = true;
        triBlocks.get(i).goingLeft = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoUp || triBlocks.get(i).canGoLeft)) {
          triBlocks.get(i).fluidMoveUL(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoUp || !triBlocks.get(i).canGoLeft)) && (Mover.vel.x<-1 || Mover.vel.y<-1)) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=1*abs(Mover.vel.y); 
            //Mover.vel.y=1*abs(n);
          } else {
            //Mover.vel.x+=1; 
            //Mover.vel.y+=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = 1; 
            float b = 1; 
            float c = -1*(t.pos.y + t.pos.x - extention + t.size.x*2);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y+ (t.size.y/2)) {
              if (canMoveY(t.pos.y+t.size.y) || !triBlocks.get(i).movable)Mover.pos.y=t.pos.y+t.size.y;
            } else {
              if (canMoveX(t.pos.x+t.size.x) || !triBlocks.get(i).movable) Mover.pos.x=t.pos.x+t.size.x;
            }
          }
        }
      }
      if (((intersection(Mover.edges[2], diag2) && diag2.open)
        || (intersection(Mover.edges[3], diag2) && diag2.open))
        && !(intersection(Mover.edges[3], diag1) && diag1.open)
        && !(intersection(Mover.edges[0], diag1) && diag1.open)) { //diagonal2
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingDown = true;
        triBlocks.get(i).goingLeft = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoDown || triBlocks.get(i).canGoLeft)) {
          triBlocks.get(i).fluidMoveDL(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoDown || !triBlocks.get(i).canGoLeft)) && (Mover.vel.x<-1 || Mover.vel.y>1)) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=1*abs(Mover.vel.y); 
            //Mover.vel.y=-1*abs(n);
          } else {
            //Mover.vel.x+=1; 
            //Mover.vel.y-=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = -1; 
            float b = 1; 
            float c = -1*(t.pos.y - t.pos.x + extention - Mover.size.x*2);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y) {
              if (canMoveX(t.pos.x+t.size.x) || !triBlocks.get(i).movable) Mover.pos.x=t.pos.x+t.size.x;
            } else {
              if (canMoveY(t.pos.y-t.size.y) || !triBlocks.get(i).movable) Mover.pos.y=t.pos.y-t.size.y;
            }
          }
        }
      }
    }
    if (rotation == 6) {
      triBlock t = triBlocks.get(i);
      float extention = (sqrt(2)/2*t.size.x)-(t.size.x/2);
      edge hor = t.edges[1]; 
      edge diag1 = t.edges[0];
      edge diag2 = t.edges[2];
      if ((intersection(Mover.edges[1], hor) && hor.open)
        || (intersection(Mover.edges[3], hor) && hor.open)) {
        if (Mover.pos.y+Mover.size.y<hor.v1.y+cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingDown = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=-1*abs(Mover.vel.y);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoDown) {
            triBlocks.get(i).fluidMoveD(true);
          } else {
            if (canMoveY(hor.v1.y-Mover.size.y) || !triBlocks.get(i).movable) Mover.pos.y=hor.v1.y-Mover.size.y;
          }
        }
      }
      if ((intersection(Mover.edges[0], diag1) && diag1.open)
        && (intersection(Mover.edges[0], diag2) && diag2.open)) {
        if (Mover.pos.y>t.corner1.y-cornerGap) {
          triBlocks.get(i).touchingMover = true;
          triBlocks.get(i).goingUp = true;
          //if (!(triBlocks.get(i).movable))Mover.vel.y=1*abs(Mover.vel.y);
          if (!triBlocks.get(i).dying && triBlocks.get(i).movable && triBlocks.get(i).canGoUp) {
            triBlocks.get(i).fluidMoveU(true);
          } else {
            if (canMoveY(t.corner1.y) || !triBlocks.get(i).movable) Mover.pos.y=t.corner1.y;
          }
        }
      }
      if (((intersection(Mover.edges[1], diag1) && diag1.open)
        || (intersection(Mover.edges[0], diag1) && diag1.open))
        && !(intersection(Mover.edges[0], diag2) && diag2.open)
        && !(intersection(Mover.edges[3], diag2) && diag2.open)) { //diagonal1
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingUp = true;
        triBlocks.get(i).goingRight = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoUp || triBlocks.get(i).canGoRight)) {
          triBlocks.get(i).fluidMoveUR(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoUp || !triBlocks.get(i).canGoRight)) && (Mover.vel.x>1 || Mover.vel.y<-1)) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=-1*abs(Mover.vel.y); 
            //Mover.vel.y=1*abs(n);
          } else {
            //Mover.vel.x-=1; 
            //Mover.vel.y+=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = -1; 
            float b = 1; 
            float c = -1*(t.pos.y - t.pos.x - extention + Mover.size.x*2);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y+ (t.size.y/2)) {
              if (canMoveY(t.pos.y+t.size.y) || !triBlocks.get(i).movable) Mover.pos.y=t.pos.y+t.size.y;
            } else {
              if (canMoveX(t.pos.x-Mover.size.x) || !triBlocks.get(i).movable) Mover.pos.x=t.pos.x-Mover.size.x;
            }
          }
        }
      }
      if (((intersection(Mover.edges[0], diag2) && diag2.open)
        || (intersection(Mover.edges[3], diag2) && diag2.open))
        && !(intersection(Mover.edges[1], diag1) && diag1.open)
        && !(intersection(Mover.edges[0], diag1) && diag1.open)) { //diagonal2
        triBlocks.get(i).touchingMover = true;
        triBlocks.get(i).goingUp = true;
        triBlocks.get(i).goingLeft = true;
        if (!triBlocks.get(i).dying && triBlocks.get(i).movable && (triBlocks.get(i).canGoUp || triBlocks.get(i).canGoLeft)) {
          triBlocks.get(i).fluidMoveUL(true);
        }
        if ((!(triBlocks.get(i).movable) || (!triBlocks.get(i).canGoUp || !triBlocks.get(i).canGoLeft)) && (Mover.vel.x<-1 || Mover.vel.y<-1)) {
          if (!(triBlocks.get(i).movable)) {
            //float n = Mover.vel.x;
            //Mover.vel.x=1*abs(Mover.vel.y); 
            //Mover.vel.y=1*abs(n);
          } else {
            //Mover.vel.x+=1; 
            //Mover.vel.y+=1;
          }
          if (!touchingOtherDiagonal(i)) {
            float x = Mover.pos.x; 
            float y = Mover.pos.y;
            float a = 1; 
            float b = 1; 
            float c = -1*(t.pos.y + t.pos.x - extention + t.size.x*2);
            if (canMoveXY((b*(b*x-a*y)-a*c)/((a*a)+(b*b)), (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b))) || !triBlocks.get(i).movable) {
              Mover.pos.x= (b*(b*x-a*y)-a*c)/((a*a)+(b*b));
              Mover.pos.y= (a*(-1*b*x+a*y)-b*c)/((a*a)+(b*b));
            }
          } else {
            if (Mover.pos.y>t.pos.y+ (t.size.y/2)) {
              if (canMoveY(t.pos.y+t.size.y) || !triBlocks.get(i).movable) Mover.pos.y=t.pos.y+t.size.y;
            } else {
              if (canMoveX(t.pos.x+t.size.x) || !triBlocks.get(i).movable) Mover.pos.x=t.pos.x+t.size.x;
            }
          }
        }
      }
    }
  }

  for (int i=0; i<triBlocks.size(); i++) { //TRIBLOCKS DETECT DEATHBLOCKS
    triBlock t = triBlocks.get(i);
    if (triBlocks.get(i).movable) {

      for (int j=0; j<deathBlocks.size(); j++) { 
        deathBlock d = deathBlocks.get(j);
        for (int k=0; k<3; k++) {
          for (int l=0; l<4; l++) {
            if (intersection(t.edges[k], d.edges[l])) {
              if (triBlocks.get(i).dying==false)triBlocks.get(i).fadeTime = fadeT;
              triBlocks.get(i).dying=true;
              return;
            }
          }
        }
      }
      for (int j=0; j<triDeathBlocks.size(); j++) { 
        triDeathBlock d = triDeathBlocks.get(j);
        for (int k=0; k<3; k++) {
          for (int l=0; l<3; l++) {
            if (intersection(t.edges[k], d.edges[l])) {
              if (triBlocks.get(i).dying==false)triBlocks.get(i).fadeTime = fadeT;
              triBlocks.get(i).dying=true;
              return;
            }
          }
        }
      }
    }
  }
}


boolean canMoveX(float x) {
  PVector newPos = new PVector(x, Mover.pos.y);
  PVector oldPos = new PVector(Mover.pos.x, Mover.pos.y);

  //blocks
  for (int i=0; i<blocks.size(); i++) {
    block b = blocks.get(i);
    if (newPos.x < b.corner2.x && newPos.x > b.corner1.x-Mover.size.x
      && newPos.y < b.corner4.y && newPos.y > b.corner1.y-Mover.size.y) {
      return false;
    }
  }

  //triblocks
  for (int i=0; i<triBlocks.size(); i++) {
    triBlock tb = triBlocks.get(i);
    if (!tb.movable) {
      PVector c1 = new PVector(newPos.x, newPos.y);
      PVector c2 = new PVector(newPos.x+Mover.size.x, newPos.y);
      PVector c3 = new PVector(newPos.x+Mover.size.x, newPos.y+Mover.size.y);
      PVector c4 = new PVector(newPos.x, newPos.y+Mover.size.y);
      edge e1 = new edge(c1.x, c1.y, c2.x, c2.y);
      edge e2 = new edge(c2.x, c2.y, c3.x, c3.y);
      edge e3 = new edge(c3.x, c3.y, c4.x, c4.y);
      edge e4 = new edge(c4.x, c4.y, c1.x, c1.y);
      for (int j=0; j<3; j++) {
        if (intersection(e1, tb.edges[j]) || intersection(e2, tb.edges[j])
          || intersection(e3, tb.edges[j]) || intersection(e4, tb.edges[j])) {
          return false;
        }
      }
    }
  }

  //doors
  for (int i=0; i<doors.size(); i++) {
    door d = doors.get(i);
    PVector d1 = new PVector(d.v1.x, d.v1.y);
    PVector d2 = new PVector(d.v2.x, d.v2.y);
    edge e1 = new edge(d1.x, d1.y, d2.x, d2.y);

    edge e2 = new edge(oldPos.x, oldPos.y, newPos.x, newPos.y);
    edge e3 = new edge(oldPos.x+Mover.size.x, oldPos.y, newPos.x+Mover.size.x, newPos.y);
    edge e4 = new edge(oldPos.x, oldPos.y+Mover.size.y, newPos.x, newPos.y+Mover.size.y);
    edge e5 = new edge(oldPos.x+Mover.size.x, oldPos.y+Mover.size.y, newPos.x+Mover.size.x, newPos.y+Mover.size.y);
    if (intersection(e1, e2)) {
      return false;
    }
    if (intersection(e1, e3)) {
      return false;
    }
    if (intersection(e1, e4)) {
      return false;
    }
    if (intersection(e1, e5)) {
      return false;
    }
  }

  return true;
}


boolean canMoveY(float y) {
  PVector newPos = new PVector(Mover.pos.x, y);
  PVector oldPos = new PVector(Mover.pos.x, Mover.pos.y);

  //blocks
  for (int i=0; i<blocks.size(); i++) {
    block b = blocks.get(i);
    if (newPos.x < b.corner2.x && newPos.x > b.corner1.x-Mover.size.x
      && newPos.y < b.corner4.y && newPos.y > b.corner1.y-Mover.size.y) {
      return false;
    }
  }

  //triblocks
  for (int i=0; i<triBlocks.size(); i++) {
    triBlock tb = triBlocks.get(i);
    if (!tb.movable) {
      PVector c1 = new PVector(newPos.x, newPos.y);
      PVector c2 = new PVector(newPos.x+Mover.size.x, newPos.y);
      PVector c3 = new PVector(newPos.x+Mover.size.x, newPos.y+Mover.size.y);
      PVector c4 = new PVector(newPos.x, newPos.y+Mover.size.y);
      edge e1 = new edge(c1.x, c1.y, c2.x, c2.y);
      edge e2 = new edge(c2.x, c2.y, c3.x, c3.y);
      edge e3 = new edge(c3.x, c3.y, c4.x, c4.y);
      edge e4 = new edge(c4.x, c4.y, c1.x, c1.y);
      for (int j=0; j<3; j++) {
        if (intersection(e1, tb.edges[j]) || intersection(e2, tb.edges[j])
          || intersection(e3, tb.edges[j]) || intersection(e4, tb.edges[j])) {
          return false;
        }
      }
    }
  }

  //doors
  for (int i=0; i<doors.size(); i++) {
    door d = doors.get(i);
    PVector d1 = new PVector(d.v1.x, d.v1.y);
    PVector d2 = new PVector(d.v2.x, d.v2.y);
    edge e1 = new edge(d1.x, d1.y, d2.x, d2.y);

    edge e2 = new edge(oldPos.x, oldPos.y, newPos.x, newPos.y);
    edge e3 = new edge(oldPos.x+Mover.size.x, oldPos.y, newPos.x+Mover.size.x, newPos.y);
    edge e4 = new edge(oldPos.x, oldPos.y+Mover.size.y, newPos.x, newPos.y+Mover.size.y);
    edge e5 = new edge(oldPos.x+Mover.size.x, oldPos.y+Mover.size.y, newPos.x+Mover.size.x, newPos.y+Mover.size.y);
    if (intersection(e1, e2)) {
      return false;
    }
    if (intersection(e1, e3)) {
      return false;
    }
    if (intersection(e1, e4)) {
      return false;
    }
    if (intersection(e1, e5)) {
      return false;
    }
  }

  return true;
}


boolean canMoveXY(float x, float y) {
  PVector newPos = new PVector(x, y);
  PVector oldPos = new PVector(Mover.pos.x, Mover.pos.y);

  //blocks
  for (int i=0; i<blocks.size(); i++) {
    block b = blocks.get(i);
    if (newPos.x < b.corner2.x && newPos.x > b.corner1.x-Mover.size.x
      && newPos.y < b.corner4.y && newPos.y > b.corner1.y-Mover.size.y) {
      return false;
    }
  }

  //triblocks
  for (int i=0; i<triBlocks.size(); i++) {
    triBlock tb = triBlocks.get(i);
    if (!tb.movable) {
      PVector c1 = new PVector(oldPos.x, oldPos.y);
      PVector c2 = new PVector(oldPos.x+Mover.size.x, oldPos.y);
      PVector c3 = new PVector(oldPos.x+Mover.size.x, oldPos.y+Mover.size.y);
      PVector c4 = new PVector(oldPos.x, oldPos.y+Mover.size.y);

      PVector nc1 = new PVector(newPos.x, newPos.y);
      PVector nc2 = new PVector(newPos.x+Mover.size.x, newPos.y);
      PVector nc3 = new PVector(newPos.x+Mover.size.x, newPos.y+Mover.size.y);
      PVector nc4 = new PVector(newPos.x, newPos.y+Mover.size.y);
      edge e1 = new edge(nc1.x, nc1.y, c1.x, c1.y);
      edge e2 = new edge(nc2.x, nc2.y, c2.x, c2.y);
      edge e3 = new edge(nc3.x, nc3.y, c3.x, c3.y);
      edge e4 = new edge(nc4.x, nc4.y, c4.x, c4.y);
      for (int j=0; j<3; j++) {
        if (intersection(e1, tb.edges[j]) || intersection(e2, tb.edges[j])
          || intersection(e3, tb.edges[j]) || intersection(e4, tb.edges[j])) {
          return false;
        }
      }
    }
  }

  //doors
  for (int i=0; i<doors.size(); i++) {
    door d = doors.get(i);
    PVector d1 = new PVector(d.v1.x, d.v1.y);
    PVector d2 = new PVector(d.v2.x, d.v2.y);
    edge e1 = new edge(d1.x, d1.y, d2.x, d2.y);

    edge e2 = new edge(oldPos.x, oldPos.y, newPos.x, newPos.y);
    edge e3 = new edge(oldPos.x+Mover.size.x, oldPos.y, newPos.x+Mover.size.x, newPos.y);
    edge e4 = new edge(oldPos.x, oldPos.y+Mover.size.y, newPos.x, newPos.y+Mover.size.y);
    edge e5 = new edge(oldPos.x+Mover.size.x, oldPos.y+Mover.size.y, newPos.x+Mover.size.x, newPos.y+Mover.size.y);
    if (intersection(e1, e2)) {
      return false;
    }
    if (intersection(e1, e3)) {
      return false;
    }
    if (intersection(e1, e4)) {
      return false;
    }
    if (intersection(e1, e5)) {
      return false;
    }
  }

  return true;
}


boolean touchingOtherDiagonal(int t) { //detects if mover is touching other diagonal or a flat wall
  triBlock tri = triBlocks.get(t);
  for (int i=0; i<triBlocks.size(); i++) {
    triBlock tri2 = triBlocks.get(i);
    if (i!=t) {
      for (int k=0; k<4; k++) {
        if ((intersection(triBlocks.get(i).diagonal, Mover.edges[k]))
          && (tri2.corner2.x==tri.corner3.x && tri2.corner2.y==tri.corner3.y
          || tri2.corner3.x==tri.corner2.x && tri2.corner3.y==tri.corner2.y)) {
          if (tri.rotation==tri2.rotation) return false;
          else return true;
        }
      }
    } else {
      for (int k=0; k<4; k++) {
        if ((intersection(triBlocks.get(i).edges[0], Mover.edges[k]))
          || (intersection(triBlocks.get(i).edges[2], Mover.edges[k]))) {
          return true;
        }
      }
    }
  }
  for (int i=0; i<blocks.size(); i++) {
    for (int j=0; j<4; j++) {
      for (int k=0; k<4; k++) {
        if (intersection(blocks.get(i).edges[j], Mover.edges[k])) {
          block blo = blocks.get(i);
          if (tri.rotation==1) {
            if ((blo.corner4.x==tri.corner2.x && blo.corner4.y==tri.corner2.y)
              || (blo.corner2.x==tri.corner3.x && blo.corner2.y==tri.corner3.y))return false;
            return true;
          }
          if (tri.rotation==3) {
            if ((blo.corner3.x==tri.corner3.x && blo.corner3.y==tri.corner3.y)
              || (blo.corner1.x==tri.corner2.x && blo.corner1.y==tri.corner2.y))return false;
            return true;
          }
          if (tri.rotation==5) {
            if ((blo.corner4.x==tri.corner3.x && blo.corner4.y==tri.corner3.y)
              || (blo.corner2.x==tri.corner2.x && blo.corner2.y==tri.corner2.y))return false;
            return true;
          }
          if (tri.rotation==7) {
            if ((blo.corner3.x==tri.corner2.x && blo.corner3.y==tri.corner2.y)
              || (blo.corner1.x==tri.corner3.x && blo.corner1.y==tri.corner3.y))return false;
            return true;
          }
        }
      }
    }
  }
  return false;
}
