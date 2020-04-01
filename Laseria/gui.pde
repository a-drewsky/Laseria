class gui {
  PVector mainBoxSize = new PVector(105, 35);
  PVector LSBoxSize = new PVector(70, 105);
  PVector levelBoxSize;
  float textSize = 16;
  float itt = 35;

  PVector playLoc = new PVector(6, 8);
  PVector levelSelectLoc = new PVector(19, 8);
  PVector howToPlayLoc = new PVector(6, 12);
  PVector quitGameLoc = new PVector(20, 12);
  PVector textOffset = new PVector(1.5, 0.65);
  PVector soundOnLoc = new PVector(2,8);
  PVector texturesOnLoc = new PVector(2,11);

  PVector LSClearDataLoc = new PVector(1, 2);
  PVector LSBackLoc = new PVector(24, 2);
  PVector starInfoLoc = new PVector(25, 6);
  PVector starInfoBackLoc = new PVector(24, 4);
  PVector LSNextLoc = new PVector(25, 11);
  PVector LSPage2Back = new PVector(1, 11);

  PVector pauseBoxSize = new PVector(140, 35);

  PVector resumeLoc = new PVector(12, 5);
  PVector resetLoc = new PVector(12, 7);
  PVector pauseExitLoc = new PVector(12, 9);

  PVector endBoxSize = new PVector(140, 35);

  PVector nextLoc = new PVector(12, 8);
  PVector retryLoc = new PVector(12, 10);
  PVector endExitLoc = new PVector(12, 12);

  PVector titleLoc = new PVector(9, 2);
  PVector titleSize = new PVector(10.25, 3);

  ArrayList <PVector> LSBoxLocs;
  float saveCount = 0;
  float flashTime = 0;
  float flashMult = 8;

  float timer;
  int deathCount;

  int curRating;
  float curTime;
  int[] starRatings;
  float[] threeStarTimes;
  float[] bestTimes;

  float tutAnimationTimer;
  PVector tutBackLoc = new PVector(20, 12);


  float OCMessageTimer=0;
  float OCMult = 10;
  float OCOffset = 95;
  float OCSpacing = 10;
  PVector OCBase;

  float clickTimer = 0;
  float clickTime = 10;

  int LSPageNum = 0;

  color blue = color(100, 100, 200);
  color red = color(200, 50, 50);
  color green = color(50, 200, 50);

  gui() {
    LSBoxLocs = new ArrayList<PVector>();
    initializeLSBoxes();
    starRatings = new int[LB.numLevels];
    bestTimes = new float[LB.numLevels];
    threeStarTimes = new float[LB.numLevels];
    initializeThreeStarTimes();
    OCBase = new PVector((w/2)-OCOffset-itt(1), 20);
  }

  void initializeThreeStarTimes() {
    threeStarTimes[0] = 40;
    threeStarTimes[1] = 50;
    threeStarTimes[2] = 40;
    threeStarTimes[3] = 30;
    threeStarTimes[4] = 20;
    threeStarTimes[5] = 30;
    threeStarTimes[6] = 25;
    threeStarTimes[7] = 30;
    threeStarTimes[8] = 20;
    threeStarTimes[9] = 70;
    threeStarTimes[10] = 20;
    threeStarTimes[11] = 50;
    threeStarTimes[12] = 30;
    threeStarTimes[13] = 80;
    threeStarTimes[14] = 60;
    threeStarTimes[15] = 60;
    threeStarTimes[16] = 40;
    threeStarTimes[17] = 40;
    threeStarTimes[18] = 50;
    threeStarTimes[19] = 60;
    threeStarTimes[20] = 90;
    threeStarTimes[21] = 40;
    threeStarTimes[22] = 60;
    threeStarTimes[23] = 60;
    threeStarTimes[24] = 80;
    threeStarTimes[25] = 50;
    threeStarTimes[26] = 60;
    threeStarTimes[27] = 80;
  }

  void loadingAnimation() {
    background(255);
    loadingTime++;
    loadingRotation += PI/32;

    if (loadingTime%128==0 ||loadingTime%128==1||loadingTime%128==2) {
      if (loadingSize<50) loadingSize=50;
      else if (loadingSize<75) loadingSize=75;
      else if (loadingSize<100) loadingSize=100;
    } else {
      loadingSize-=0.6;
    }

    pushMatrix();
    translate(width/2, height/2);
    rotate(loadingRotation);
    rectMode(CENTER);
    strokeWeight(2);
    stroke(150, 75, 38);
    fill(200, 100, 50);
    rect(0, 0, loadingSize, loadingSize, loadingSize/2.5);
    rectMode(CORNER);
    popMatrix();
  }

  void saveData() {
    String[] starString = new String[starRatings.length];
    for (int i=0; i<starString.length; i++) {
      starString[i] = String.valueOf(starRatings[i]);
    }
    saveStrings("data/starData.txt", starString);

    String[] timeString = new String[bestTimes.length];
    for (int i=0; i<starString.length; i++) {
      timeString[i] = String.valueOf(bestTimes[i]);
    }
    saveStrings("data/timeData.txt", timeString);
    
    String[] settings = new String[2];
    if(soundOn) settings[0]="1";
    else settings[0]="0";
    if(texturesOn) settings[1]="1";
    else settings[1]="0";
    saveStrings("data/settings.txt", settings);
  }

  void loadData() {
    File f = dataFile("starData.txt");
    if (f.isFile()) {
      String[] starString = loadStrings("data/starData.txt");
      for (int i=0; i<starString.length; i++) {
        starRatings[i] = Integer.valueOf(starString[i]);
      }
    } else resetStarData();

    File t = dataFile("timeData.txt");
    if (t.isFile()) {
      String[] timeString = loadStrings("data/timeData.txt");
      for (int i=0; i<timeString.length; i++) {
        bestTimes[i] = Float.valueOf(timeString[i]);
      }
    } else resetTimeData();
    
    File s = dataFile("settings.txt");
    if (s.isFile()) {
      int[] settingNums = new int[2];
      String[] settings = loadStrings("data/settings.txt");
      for (int i=0; i<settings.length; i++) {
      settingNums[i] = Integer.valueOf(settings[i]);
    }
        if(settingNums[0]==0) soundOn=false;
        else soundOn=true;
        if(settingNums[1]==0) texturesOn=false;
        else texturesOn=true;
    } else resetSettings();
  }

  void resetSettings(){
    String[]nullSettings = new String[2];
    for (int i=0; i<nullSettings.length; i++) {
      nullSettings[i] = "1";
    }
    saveStrings("data/settings.txt", nullSettings);
    loadData();
  }

  void resetTimeData() {
    String[]nullStringTimes = new String[bestTimes.length];
    for (int i=0; i<nullStringTimes.length; i++) {
      nullStringTimes[i] = "0";
    }
    saveStrings("data/timeData.txt", nullStringTimes);
    loadData();
  }

  void resetStarData() {
    String[] nullString = new String[starRatings.length];
    for (int i=0; i<nullString.length; i++) {
      nullString[i] = "0";
    }
    saveStrings("data/starData.txt", nullString);
    loadData();
  }

  void initializeLSBoxes() {
    for (int i=0; i<LB.numLevels; i++) {
      if (4+i*3>=66) LSBoxLocs.add(new PVector(4+(i-21)*3, 10));
      else if (4+i*3>=44) LSBoxLocs.add(new PVector(4+(i-14)*3, 6));
      else if (4+i*3>22 && 4+i*3<44) LSBoxLocs.add(new PVector(4+(i-7)*3, 10));
      else LSBoxLocs.add(new PVector(4+i*3, 6));
    }
  }

  void update() {
    if (clickTimer>0) clickTimer-=1;
    mainMenu();
    drawSaves();
    if (gameState==3)showPauseMenu();
    if (flashTime>0) flash();
    if (gameState==4)showEndGameMenu();
    if (gameState==2) showTimerAndDeaths();
    if (OCMessageTimer>0) objectivesCompleteMessage();
    if (gameState==6) showStarInfo();
  }

  void mainMenu() {
    if (gameState==0) showMainBoxes();
    if (gameState==1) showLSBoxes();
    if (gameState==5) showTutorial();
    if (gameState==0||gameState==1 || gameState==5 || gameState==6)Mover.screenSaver();
  }

  void showFist(){
    image(broFist,itt(10),itt(4),250,250);
  }

  void showStarInfo() {

    noStroke();
    fill(100, 100);
    rect(itt(2), 35, itt(10), height);
    if (mouseX>itt(starInfoBackLoc.x) && mouseY>itt(starInfoBackLoc.y)
      && mouseX<itt(starInfoBackLoc.x)+itt(2) && mouseY<itt(starInfoBackLoc.y)+itt(1)) fill(150);
    else fill(200);
    rect(itt(starInfoBackLoc.x), itt(starInfoBackLoc.y), itt(2), itt(1));

    fill(0);
    text("Back", itt(starInfoBackLoc.x)+itt(0.5), itt(starInfoBackLoc.y) + itt(0.7));
    textSize(textSize);
    textAlign(LEFT);

    fill(0);
    text("1 star: Beat level", itt(14), itt(3.95));
    text("2 stars: Beat level without saving", itt(14), itt(5.95));
    text("3 stars: Beat time", itt(14), itt(7.95));
    text("Level", itt(3), itt(0.85));
    text("Best Time", itt(6), itt(0.85));
    text("3 Star Time", itt(9), itt(0.85));

    if (LSPageNum==0) {
      for (int i=0; i<14; i++) {
        if (i!=0)text((i), itt(3), itt(0.85)+itt(i+1)); 
        else text(("Tut"), itt(3), itt(0.85)+itt(i+1)); 
        text(String.format("%.1f", bestTimes[i]), itt(6), itt(0.85)+itt(i+1)); 
        text(String.format("%.1f", threeStarTimes[i]), itt(9), itt(0.85)+itt(i+1));
      }
    } else {
      for (int i=14; i<LB.numLevels; i++) {
        text((i), itt(3), itt(0.85)+itt((i-14)+1)); 
        text(String.format("%.1f", bestTimes[i]), itt(6), itt(0.85)+itt((i-14)+1)); 
        text(String.format("%.1f", threeStarTimes[i]), itt(9), itt(0.85)+itt((i-14)+1));
      }
    }
  }

  void showPauseMenu() {

    noStroke();
    fill(0, 200);
    rect(0, 35, width, height);

    textSize(textSize*2);
    textAlign(CENTER);

    if (mouseX > itt(resumeLoc.x) && mouseX < itt(resumeLoc.x)+pauseBoxSize.x
      && mouseY > itt(resumeLoc.y) && mouseY < itt(resumeLoc.y)+pauseBoxSize.y) fill(255, 255, 0);
    else fill(255);
    text("RESUME", itt(14), itt(5.85));

    if (mouseX > itt(resetLoc.x) && mouseX < itt(resetLoc.x)+pauseBoxSize.x
      && mouseY > itt(resetLoc.y) && mouseY < itt(resetLoc.y)+pauseBoxSize.y) fill(255, 255, 0);
    else fill(255);
    text("RESET", itt(14), itt(7.85));

    if (mouseX > itt(pauseExitLoc.x) && mouseX < itt(pauseExitLoc.x)+pauseBoxSize.x
      && mouseY > itt(pauseExitLoc.y) && mouseY < itt(pauseExitLoc.y)+pauseBoxSize.y) fill(255, 255, 0);
    else fill(255);
    text("EXIT", itt(14), itt(9.85));
  }

  void showEndGameMenu() {

    noStroke();
    fill(0, 200);
    rect(0, 35, width, height);

    fill(255);
    textSize(textSize*2);
    textAlign(CENTER);

    text("TIME: " + timer, itt(10.5), itt(4.85));
    text("DEATHS: " + deathCount, itt(17.5), itt(4.85));

    for (int i=0; i<3; i++) {
      if (curRating>i) {
        fill(250, 200, 0);
      } else {
        fill(200);
      }
      drawStar(itt(11+(i*3)), itt(6.5), 15, 40, 5);
    }
    if (levelNum < LB.numLevels) {
      if (mouseX > itt(nextLoc.x) && mouseX < itt(nextLoc.x)+endBoxSize.x
        && mouseY > itt(nextLoc.y) && mouseY < itt(nextLoc.y)+endBoxSize.y) fill(255, 255, 0);
      else fill(255);
      text("NEXT", itt(14), itt(8.85));
    }
    if (mouseX > itt(retryLoc.x) && mouseX < itt(retryLoc.x)+endBoxSize.x
      && mouseY > itt(retryLoc.y) && mouseY < itt(retryLoc.y)+endBoxSize.y) fill(255, 255, 0);
    else fill(255);
    text("RETRY", itt(14), itt(10.85));
    if (mouseX > itt(endExitLoc.x) && mouseX < itt(endExitLoc.x)+endBoxSize.x
      && mouseY > itt(endExitLoc.y) && mouseY < itt(endExitLoc.y)+endBoxSize.y) fill(255, 255, 0);
    else fill(255);
    text("EXIT", itt(14), itt(12.85));
  }

  float itt(float n) {
    return n*35;
  }

  void showMainBoxes() {
    image(title, itt(titleLoc.x), itt(titleLoc.y), itt(titleSize.x), itt(titleSize.y));
    noStroke();
    
     if (mouseX>itt(soundOnLoc.x) && mouseY>itt(soundOnLoc.y)
      && mouseX<itt(soundOnLoc.x)+itt(2) && mouseY<itt(soundOnLoc.y)+itt(2)) fill(150);
    else fill(200);
    rect(itt(soundOnLoc.x), itt(soundOnLoc.y), itt(2), itt(2));
    
    if (mouseX>itt(texturesOnLoc.x) && mouseY>itt(texturesOnLoc.y)
      && mouseX<itt(texturesOnLoc.x)+itt(2) && mouseY<itt(texturesOnLoc.y)+itt(2)) fill(150);
    else fill(200);
    rect(itt(texturesOnLoc.x), itt(texturesOnLoc.y), itt(2), itt(2));
    
    if (mouseX>itt(playLoc.x) && mouseY>itt(playLoc.y)
      && mouseX<itt(playLoc.x)+mainBoxSize.x && mouseY<itt(playLoc.y)+mainBoxSize.y) fill(150);
    else fill(200);
    rect(itt(playLoc.x), itt(playLoc.y), mainBoxSize.x, mainBoxSize.y);
    if (mouseX>itt(levelSelectLoc.x) && mouseY>itt(levelSelectLoc.y)
      && mouseX<itt(levelSelectLoc.x)+mainBoxSize.x && mouseY<itt(levelSelectLoc.y)+mainBoxSize.y) fill(150);
    else fill(200);
    rect(itt(levelSelectLoc.x), itt(levelSelectLoc.y), mainBoxSize.x, mainBoxSize.y);
    if (mouseX>itt(howToPlayLoc.x) && mouseY>itt(howToPlayLoc.y)
      && mouseX<itt(howToPlayLoc.x)+mainBoxSize.x && mouseY<itt(howToPlayLoc.y)+mainBoxSize.y) fill(150);
    else fill(200);
    rect(itt(howToPlayLoc.x), itt(howToPlayLoc.y), mainBoxSize.x, mainBoxSize.y);
    if (mouseX>itt(quitGameLoc.x) && mouseY>itt(quitGameLoc.y)
      && mouseX<itt(quitGameLoc.x)+itt(2) && mouseY<itt(quitGameLoc.y)+itt(1)) fill(200, 100, 100);
    else fill(200, 160, 160);
    rect(itt(quitGameLoc.x), itt(quitGameLoc.y), itt(2), itt(1));

    tutorialCard(23, 8, 4, 2);
    
    tutorialCard(23, 11, 4, 2);

    fill(0);
    textAlign(CENTER);
    textFont(font2);
    textSize(textSize+1.1);
    text("Creator:\r\nAndy Dembofsky", itt(25)+textOffset.x, itt(8.8)+textOffset.y);
    text("Music:\r\nSafeR", itt(25)+textOffset.x, itt(11.8)+textOffset.y);
    textFont(font);
    textSize(textSize);
    text("Play", itt(playLoc.x+textOffset.x), itt(playLoc.y+textOffset.y));
    text("Level Select", itt(levelSelectLoc.x+textOffset.x), itt(levelSelectLoc.y+textOffset.y));
    text("How to Play", itt(howToPlayLoc.x+textOffset.x), itt(howToPlayLoc.y+textOffset.y));
    text("Quit", itt(quitGameLoc.x-0.5+textOffset.x), itt(quitGameLoc.y+textOffset.y));
    text("Sound", itt(soundOnLoc.x-0.5+textOffset.x), itt(soundOnLoc.y+textOffset.y));
    text("Textures", itt(texturesOnLoc.x-0.5+textOffset.x), itt(texturesOnLoc.y+textOffset.y));
    if(soundOn==true) text("On", itt(soundOnLoc.x-0.5+textOffset.x), itt(soundOnLoc.y+1+textOffset.y));
    else text("Off", itt(soundOnLoc.x-0.5+textOffset.x), itt(soundOnLoc.y+1+textOffset.y));
    if(texturesOn==true) text("On", itt(texturesOnLoc.x-0.5+textOffset.x), itt(texturesOnLoc.y+1+textOffset.y));
    else text("Off", itt(texturesOnLoc.x-0.5+textOffset.x), itt(texturesOnLoc.y+1+textOffset.y));
  }

  void showLSBoxes() {
    image(title, itt(titleLoc.x), itt(titleLoc.y), itt(titleSize.x), itt(titleSize.y));
    noStroke();

    if (LSPageNum==0) {
      if (mouseX>itt(LSNextLoc.x) && mouseY>itt(LSNextLoc.y)
        && mouseX<itt(LSNextLoc.x)+itt(2) && mouseY<itt(LSNextLoc.y)+itt(1)) fill(150);
      else fill(200);
      rect(itt(LSNextLoc.x), itt(LSNextLoc.y), itt(2), itt(1));

      if (mouseX>itt(starInfoLoc.x) && mouseY>itt(starInfoLoc.y)
        && mouseX<itt(starInfoLoc.x)+itt(2) && mouseY<itt(starInfoLoc.y)+itt(2)) fill(150);
      else fill(200);
      rect(itt(starInfoLoc.x), itt(starInfoLoc.y), itt(2), itt(2));

      if (mouseX>itt(LSClearDataLoc.x) && mouseY>itt(LSClearDataLoc.y)
        && mouseX<itt(LSClearDataLoc.x)+mainBoxSize.x && mouseY<itt(LSClearDataLoc.y)+mainBoxSize.y) fill(200, 100, 100);
      else fill(200);
      rect(itt(LSClearDataLoc.x), itt(LSClearDataLoc.y), mainBoxSize.x, mainBoxSize.y);
      if (mouseX>itt(LSBackLoc.x) && mouseY>itt(LSBackLoc.y)
        && mouseX<itt(LSBackLoc.x)+mainBoxSize.x && mouseY<itt(LSBackLoc.y)+mainBoxSize.y) fill(150);
      else fill(200);
      rect(itt(LSBackLoc.x), itt(LSBackLoc.y), mainBoxSize.x, mainBoxSize.y);

      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      text("Star\r\nInfo", itt(starInfoLoc.x+textOffset.x/1.5), itt(starInfoLoc.y+textOffset.y));
      text("Back", itt(LSBackLoc.x+textOffset.x), itt(LSBackLoc.y+textOffset.y));
      text("Next", itt(LSNextLoc.x+textOffset.x/1.5), itt(LSNextLoc.y+textOffset.y));
      fill(200, 0, 0);
      if (mouseX>itt(LSClearDataLoc.x) && mouseY>itt(LSClearDataLoc.y)
        && mouseX<itt(LSClearDataLoc.x)+mainBoxSize.x && mouseY<itt(LSClearDataLoc.y)+mainBoxSize.y) fill(0);
      else fill(200, 0, 0);
      text("Clear Data", itt(LSClearDataLoc.x+textOffset.x), itt(LSClearDataLoc.y+textOffset.y));

      fill(200);
      noStroke();
      for (int i=0; i<14; i++) {
        PVector LSB = LSBoxLocs.get(i);
        if (mouseX>itt(LSB.x) && mouseY>itt(LSB.y)
          && mouseX<itt(LSB.x)+LSBoxSize.x && mouseY<itt(LSB.y)+LSBoxSize.y) fill(150);
        else fill(200);
        rect(itt(LSB.x), itt(LSB.y), LSBoxSize.x, LSBoxSize.y);
      }
      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      for (int i=0; i<14; i++) {
        if (i==0) {
          text("Tutorial ", itt(LSBoxLocs.get(0).x+textOffset.x/1.5), itt(LSBoxLocs.get(0).y+textOffset.y));
        } else {
          PVector LSB = LSBoxLocs.get(i);
          text("Level " + (i), itt(LSB.x+textOffset.x/1.5), itt(LSB.y+textOffset.y));
        }
      }
      for (int i=0; i<14; i++) {
        PVector LSB = LSBoxLocs.get(i);
        showMiniLevel(i, itt(LSB.x), itt(LSB.y)+35);
      }

      for (int i=0; i<14; i++) {
        PVector LSB = LSBoxLocs.get(i);
        for (int j=0; j<3; j++) {
          if (starRatings[i]>j) {
            fill(250, 200, 0);
          } else {
            fill(100);
          }
          drawStar(itt(LSB.x)+11+j*((itt*2)/3), itt(LSB.y+2.5), 4, 12, 5); //weird but works
        }
      }
    } else {

      if (mouseX>itt(LSPage2Back.x) && mouseY>itt(LSPage2Back.y)
        && mouseX<itt(LSPage2Back.x)+itt(2) && mouseY<itt(LSPage2Back.y)+itt(1)) fill(150);
      else fill(200);
      rect(itt(LSPage2Back.x), itt(LSPage2Back.y), itt(2), itt(1));
      if (mouseX>itt(starInfoLoc.x) && mouseY>itt(starInfoLoc.y)
        && mouseX<itt(starInfoLoc.x)+itt(2) && mouseY<itt(starInfoLoc.y)+itt(2)) fill(150);
      else fill(200);
      rect(itt(starInfoLoc.x), itt(starInfoLoc.y), itt(2), itt(2));

      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      text("Back", itt(LSPage2Back.x+textOffset.x/1.5), itt(LSPage2Back.y+textOffset.y));
      text("Star\r\nInfo", itt(starInfoLoc.x+textOffset.x/1.5), itt(starInfoLoc.y+textOffset.y));

      fill(200);
      noStroke();
      for (int i=14; i<LSBoxLocs.size(); i++) {
        PVector LSB = LSBoxLocs.get(i);
        if (mouseX>itt(LSB.x) && mouseY>itt(LSB.y)
          && mouseX<itt(LSB.x)+LSBoxSize.x && mouseY<itt(LSB.y)+LSBoxSize.y) fill(150);
        else fill(200);
        rect(itt(LSB.x), itt(LSB.y), LSBoxSize.x, LSBoxSize.y);
      }
      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      for (int i=14; i<LSBoxLocs.size(); i++) {
        PVector LSB = LSBoxLocs.get(i);
        text("Level " + (i), itt(LSB.x+textOffset.x/1.5), itt(LSB.y+textOffset.y));
      }
      for (int i=14; i<LSBoxLocs.size(); i++) {
        PVector LSB = LSBoxLocs.get(i);
        showMiniLevel(i, itt(LSB.x), itt(LSB.y)+35);
      }

      for (int i=14; i<LSBoxLocs.size(); i++) {
        PVector LSB = LSBoxLocs.get(i);
        for (int j=0; j<3; j++) {
          if (starRatings[i]>j) {
            fill(250, 200, 0);
          } else {
            fill(100);
          }
          drawStar(itt(LSB.x)+11+j*((itt*2)/3), itt(LSB.y+2.5), 4, 12, 5); //weird but works
        }
      }
    }
  }

  void showTutLevelText() {
    textSize(textSize/1.4);
    textAlign(CENTER);
    //Push button
    if (Mover.center.x>itt(1) && Mover.center.x<itt(6) && Mover.center.y>itt(2) && Mover.pos.y<itt(5)) {
      tutorialCard(1.5, 3, 4, 0.5);
      fill(0);
      text("STAND ON THE BUTTON", itt(3.5), itt(3.4));
    }
    //fire laser
    if (Mover.center.x>itt(6) && Mover.center.x<itt(11) && Mover.center.y>itt(2) && Mover.pos.y<itt(6)) {
      tutorialCard(6.25, 2.75, 3.5, 1.75);
      fill(0);
      text("TOUCH THE LASER\r\nAND PRESS \"SPACE\"\r\nTO TURN IT ON/OFF", itt(8), itt(3.2));
    }
    //last door
    if (Mover.center.x>itt(1) && Mover.center.x<itt(10) && Mover.center.y>itt(11) && Mover.pos.y<itt(14)) {
      tutorialCard(1.5, 11.1, 8, 1.1);
      fill(0);
      text("BUTTONS AND TRIGGERS WITH A BLACK OUTLINE\r\nWILL TOGGLE OFF", itt(5.5), itt(11.5));
    }
    if (Mover.center.x>itt(1) && Mover.center.x<itt(4) && Mover.center.y>itt(7) && Mover.pos.y<itt(11)) {
      tutorialCard(1, 8, 3, 1);
      fill(0);
      text("MOVE THE MIRROR\r\nON THE BUTTON", itt(2.5), itt(8.4));
    }
    //before lava
    if (Mover.center.x>itt(10) && Mover.center.x<itt(16) && Mover.center.y>itt(11) && Mover.pos.y<itt(13)) {
      tutorialCard(10.1, 11.4, 5.8, 1);
      fill(0);
      text("REMEMBER TO SAVE BY PRESSING \"X\"\r\nYOU HAVE 2 SAVES PER LEVEL", itt(13), itt(11.8));
    }
    //return here
    if (Mover.center.x>itt(13) && Mover.center.x<itt(16) && Mover.center.y>itt(2) && Mover.pos.y<itt(5) && !objectivesComplete) {
       tutorialCard(15.1, 2.4, 6, 2);
      fill(0);
      text("RETURN TO THE GREEN AREA AFTER\r\n COLLECTING ALL COINS\r\nAND DEFEATING\r\n ALL SPECIAL ENEMIES", itt(18), itt(2.8));
    }
    //complete objectives
    if (Mover.center.x>itt(18) && Mover.center.x<itt(27) && Mover.center.y>itt(7) && Mover.pos.y<itt(10) && !objectivesComplete) {
      tutorialCard(19.8, 7.4, 5.2, 2.2);
      fill(0);
      text("PRESS \"R\"\r\n TO ROTATE MIRRORS AND LASERS\r\nUSE THIS TO DEFEAT\r\n THE SPECIAL ENEMIES", itt(22.5), itt(7.8));
    }
  }

  void showTutorial() {
    tutAnimationTimer+=1/frameRate;

    noStroke();

    if (mouseX>itt(tutBackLoc.x) && mouseY>itt(tutBackLoc.y)
      && mouseX<itt(tutBackLoc.x)+mainBoxSize.x && mouseY<itt(tutBackLoc.y)+mainBoxSize.y) fill(150);
    else fill(200);
    rect(itt(tutBackLoc.x), itt(tutBackLoc.y), mainBoxSize.x, mainBoxSize.y);

    fill(0);
    textSize(textSize);
    textAlign(CENTER);
    text("Back", itt(tutBackLoc.x+textOffset.x), itt(tutBackLoc.y+textOffset.y));

    textAlign(CENTER);
    //movement
    tutorialCard(2, 3, 3, 3);
    textSize(textSize);
    text("MOVEMENT", itt(3.5), itt(3.6));
    textAlign(LEFT);
    textSize(textSize/1.5);
    text("Use arrow keys\r\nOr WASD keys\r\nto move", itt(2.5), itt(4.4));

    textAlign(CENTER);
    //controls
    tutorialCard(2, 7, 5, 6);
    textSize(textSize);
    text("CONTROLS", itt(4.5), itt(7.6));
    textAlign(LEFT);
    textSize(textSize/1.5);
    text("ESC: Pauses the game", itt(2.5), itt(8.6));
    text("X: Uses a save\r\n You have 2 saves per level", itt(2.5), itt(9.35));
    text("R: Rotate lasers\r\n Rotate mirrors", itt(2.5), itt(10.6));
    text("SPACE: Fire lasers", itt(2.5), itt(11.85));

    textAlign(CENTER);
    //How to win
    tutorialCard(9, 3, 6, 4);
    textSize(textSize);
    text("HOW TO WIN", itt(12), itt(3.6));
    textAlign(LEFT);
    textSize(textSize/1.5);
    text("Collect all coins", itt(9.5), itt(4.6));
    text("Eliminate all special enemies", itt(9.5), itt(5.35));
    text("Then reach an exit", itt(9.5), itt(6.1));

    textAlign(CENTER);
    //Special Enemies
    tutorialCard(9, 8, 6, 4);
    textSize(textSize);
    text("SPECIAL ENEMIES", itt(12), itt(8.6));
    textAlign(LEFT);
    textSize(textSize/1.5);
    text("Special Enemies come in 4 colors", itt(9.5), itt(9.6));
    text("They can only be eliminated by\r\na laser of the same color", itt(9.5), itt(10.85));

    textAlign(CENTER);
    //Doors
    tutorialCard(17, 3, 6, 8);
    textSize(textSize);
    text("OPENING DOORS", itt(20), itt(3.6));
    textAlign(LEFT);
    textSize(textSize/1.5);
    text("Open doors by activating\r\nAll triggers\r\nAnd or\r\nAll buttons\r\nOf the same color as the door", itt(17.5), itt(4.6));
    text("Triggers are activated by\r\nLasers of the same color", itt(17.5), itt(7.6));
    text("Buttons can be activated by\r\nMoving over them", itt(17.5), itt(8.8));
    text("Buttons and trigger with a black\r\nOutline will toggle off", itt(17.5), itt(10));

    //trigger icon
    strokeWeight(3);
    stroke(col1);
    if ((int)tutAnimationTimer % 2==0) fill(75, 150, 75);
    else fill(250, 50, 50);
    ellipseMode(CENTER);
    ellipse(itt(19.5), itt(5), 7, 7);

    //button icon
    ellipseMode(CENTER);
    noStroke();
    fill(150);
    ellipse(itt(19.5), itt(6), 11, 8);
    if ((int)tutAnimationTimer % 2==0) {
      fill(col1);
      ellipse(itt(19.5), itt(6), 5.5, 4);
    } else {
      fill(240);
      rect(itt(19.5)-3, itt(6)-2, 3, 2);
      ellipse(itt(19.5), itt(6), 5, 4);

      fill(col1);
      ellipse(itt(19.5), itt(6)-2, 5.5, 4);
    }
    //special enemy icons
    strokeWeight(2);
    stroke(enStroke);
    ellipseMode(CENTER);
    fill(col1);
    ellipse(itt(10), itt(10.1), coinSize/1.5, coinSize/1.5);
    fill(col2);
    ellipse(itt(10.5), itt(10.1), coinSize/1.5, coinSize/1.5);
    fill(col3);
    ellipse(itt(11), itt(10.1), coinSize/1.5, coinSize/1.5);
    fill(col4);
    ellipse(itt(11.5), itt(10.1), coinSize/1.5, coinSize/1.5);

    //coin icon
    ellipseMode(CENTER);
    noStroke();
    fill(170, 170, 0);
    ellipse(itt(12.6)+1, itt(4.5), (coinSize/1.5)*0.8, coinSize/1.5);
    fill(220, 220, 0);
    ellipse(itt(12.6), itt(4.5), (coinSize/1.5)*0.8, coinSize/1.5);

    fill(170, 170, 0);
    ellipse(itt(12.2)+1, itt(4.5), (coinSize/1.5)*0.8, coinSize/1.5);
    fill(220, 220, 0);
    ellipse(itt(12.2), itt(4.5), (coinSize/1.5)*0.8, coinSize/1.5);

    //laser icon 1
    noStroke();
    fill(col3);
    pushMatrix();
    translate(itt(5.5), itt(10.5));
    rotate(((2*PI)/8)*((int)tutAnimationTimer % 8));
    ellipseMode(CENTER);
    arc(0, 0, 7.5, 7.5, -1*QUARTER_PI, PI+QUARTER_PI, CHORD);
    triangle(-1*(2.25), -1*(4.5), (2.25), -1*(4.5), 0, -1*(9));
    popMatrix();

    //laser icon 2
    noStroke();
    fill(col4);
    pushMatrix();
    translate(itt(3.5), itt(12.5));
    rotate(PI/2);
    ellipseMode(CENTER);
    arc(0, 0, 7.5, 7.5, -1*QUARTER_PI, PI+QUARTER_PI, CHORD);
    triangle(-1*(2.25), -1*(4.5), (2.25), -1*(4.5), 0, -1*(9));
    popMatrix();

    //beam
    if ((int)tutAnimationTimer % 2==0) {
      stroke(0);
      strokeWeight(2);
      line(itt(3.875), itt(12.5), itt(4.5), itt(12.5));
    }
    //mirror icon
    mirrorIcon((int)tutAnimationTimer % 8, itt(5.5), itt(11));
  }

  void tutorialCard(float x, float y, float w, float h) {
    noStroke();
    fill(200, 180, 150);
    rect(itt(x), itt(y), itt(w), itt(h), 17.5);
    fill(0);
  }

  void mirrorIcon(int r, float x, float y) {
    int rotation = r;
    PVector corner1 = new PVector();
    PVector corner2 = new PVector();
    PVector corner3 = new PVector();
    PVector pos = new PVector(x, y);
    PVector size = new PVector(8.75, 8.75);
    if (rotation == 0) {
      PVector center = new PVector(pos.x+(size.x/2), pos.y+(size.y/2));
      float halfHyp = sqrt(2)/2*size.x;
      corner1 = new PVector(center.x-halfHyp, center.y);
      corner2 = new PVector(center.x, center.y-halfHyp);
      corner3 = new PVector(center.x, center.y+halfHyp);
    }
    if (rotation == 1) {
      corner1 = new PVector(pos.x, pos.y);
      corner2 = new PVector(pos.x + size.x, pos.y);
      corner3 = new PVector(pos.x, pos.y + size.y);
    }
    if (rotation == 2) {
      PVector center = new PVector(pos.x+(size.x/2), pos.y+(size.y/2));
      float halfHyp = sqrt(2)/2*size.x;
      corner1 = new PVector(center.x, center.y-halfHyp);
      corner2 = new PVector(center.x+halfHyp, center.y);
      corner3 = new PVector(center.x-halfHyp, center.y);
    }
    if (rotation == 3) { //2
      corner1 = new PVector(pos.x + size.x, pos.y);
      corner2 = new PVector(pos.x + size.x, pos.y + size.y);
      corner3 = new PVector(pos.x, pos.y);
    }
    if (rotation == 4) {
      PVector center = new PVector(pos.x+(size.x/2), pos.y+(size.y/2));
      float halfHyp = sqrt(2)/2*size.x;
      corner1 = new PVector(center.x+halfHyp, center.y);
      corner2 = new PVector(center.x, center.y+halfHyp);
      corner3 = new PVector(center.x, center.y-halfHyp);
    }
    if (rotation == 5) { //3
      corner1 = new PVector(pos.x + size.x, pos.y + size.y);
      corner2 = new PVector(pos.x, pos.y + size.y);
      corner3 = new PVector(pos.x + size.x, pos.y);
    }
    if (rotation == 6) {
      PVector center = new PVector(pos.x+(size.x/2), pos.y+(size.y/2));
      float halfHyp = sqrt(2)/2*size.x;
      corner1 = new PVector(center.x, center.y+halfHyp);
      corner2 = new PVector(center.x-halfHyp, center.y);
      corner3 = new PVector(center.x+halfHyp, center.y);
    }
    if (rotation == 7) { //4
      corner1 = new PVector(pos.x, pos.y + size.y);
      corner2 = new PVector(pos.x, pos.y);
      corner3 = new PVector(pos.x + size.x, pos.y + size.y);
    }


    fill(100, 200, 100);
    stroke(50);
    strokeWeight(2);
    strokeJoin(ROUND);
    triangle(corner1.x, corner1.y, corner2.x, corner2.y, corner3.x, corner3.y);
    stroke(200);
    strokeWeight(3);
    strokeJoin(ROUND);
    line(corner2.x, corner2.y, corner3.x, corner3.y);
  }

  void mPress() {

    if (gameState==6) {
      if (mouseX > itt(starInfoBackLoc.x) && mouseX < itt(starInfoBackLoc.x)+itt(2)
        && mouseY > itt(starInfoBackLoc.y) && mouseY < itt(starInfoBackLoc.y)+itt(1) && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        gameState=1;
      }
    }

    if (gameState==5) {
      if (mouseX > itt(tutBackLoc.x) && mouseX < itt(tutBackLoc.x)+mainBoxSize.x
        && mouseY > itt(tutBackLoc.y) && mouseY < itt(tutBackLoc.y)+mainBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;  
        if(soundOn) menuButtonSound.play();
        tutAnimationTimer=0;
        gameState=0;
      }
    }

    if (gameState==4) {
      if (mouseX > itt(nextLoc.x) && mouseX < itt(nextLoc.x)+endBoxSize.x
        && mouseY > itt(nextLoc.y) && mouseY < itt(nextLoc.y)+endBoxSize.y
        && levelNum < LB.numLevels && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        clearLevel();
        startLevel();
        populate(levelNum);
      }
      if (mouseX > itt(retryLoc.x) && mouseX < itt(retryLoc.x)+endBoxSize.x
        && mouseY > itt(retryLoc.y) && mouseY < itt(retryLoc.y)+endBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        startLevel();
        reset();
      }
      if (mouseX > itt(endExitLoc.x) && mouseX < itt(endExitLoc.x)+endBoxSize.x
        && mouseY > itt(endExitLoc.y) && mouseY < itt(endExitLoc.y)+endBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        clearLevel();
        startMainMenu();
      }
    }

    if (gameState==3) {
      if (mouseX > itt(resumeLoc.x) && mouseX < itt(resumeLoc.x)+pauseBoxSize.x
        && mouseY > itt(resumeLoc.y) && mouseY < itt(resumeLoc.y)+pauseBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        gameState=2;
      }
      if (mouseX > itt(resetLoc.x) && mouseX < itt(resetLoc.x)+pauseBoxSize.x
        && mouseY > itt(resetLoc.y) && mouseY < itt(resetLoc.y)+pauseBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) loop1.stop();
        if(soundOn) loop2.stop();
        if(soundOn) loop3.stop();
        if(soundOn) loop4.stop();
        if(soundOn) loop5.stop();
        if(soundOn) loop6.stop();
        if(soundOn) loop7.stop();
        if(soundOn) loop8.stop();
        if(soundOn) loop9.stop();
        if(soundOn) extended.stop();
        if(soundOn) menuButtonSound.play();
        startLevel();
        reset();
      }
      if (mouseX > itt(pauseExitLoc.x) && mouseX < itt(pauseExitLoc.x)+pauseBoxSize.x
        && mouseY > itt(pauseExitLoc.y) && mouseY < itt(pauseExitLoc.y)+pauseBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) loop1.stop();
        if(soundOn) loop2.stop();
        if(soundOn) loop3.stop();
        if(soundOn) loop4.stop();
        if(soundOn) loop5.stop();
        if(soundOn) loop6.stop();
        if(soundOn) loop7.stop();
        if(soundOn) loop8.stop();
        if(soundOn) loop9.stop();
        if(soundOn) extended.stop();
        if(soundOn) menuButtonSound.play();
        clearLevel();
        startMainMenu();
      }
    }

    if (gameState==1) {
      if (LSPageNum==0) {
        if (mouseX > itt(LSNextLoc.x) && mouseX < itt(LSNextLoc.x)+itt(2)
          && mouseY > itt(LSNextLoc.y) && mouseY < itt(LSNextLoc.y)+itt(1) && clickTimer<=0) {
          clickTimer=clickTime;
          if(soundOn) menuButtonSound.play();
          LSPageNum=1;
        }
        if (mouseX > itt(starInfoLoc.x) && mouseX < itt(starInfoLoc.x)+itt(2)
          && mouseY > itt(starInfoLoc.y) && mouseY < itt(starInfoLoc.y)+itt(2) && clickTimer<=0) {
          clickTimer=clickTime;
          if(soundOn) menuButtonSound.play();
          gameState=6;
        }
        if (mouseX > itt(LSBackLoc.x) && mouseX < itt(LSBackLoc.x)+mainBoxSize.x
          && mouseY > itt(LSBackLoc.y) && mouseY < itt(LSBackLoc.y)+mainBoxSize.y && clickTimer<=0) {
          clickTimer=clickTime;
          if(soundOn) menuButtonSound.play();
          gameState=0;
        }
        if (mouseX > itt(LSClearDataLoc.x) && mouseX < itt(LSClearDataLoc.x)+mainBoxSize.x
          && mouseY > itt(LSClearDataLoc.y) && mouseY < itt(LSClearDataLoc.y)+mainBoxSize.y && clickTimer<=0) {
          clickTimer=clickTime;
          if(soundOn) menuButtonSound.play();
          resetStarData();
        }
        for (int i=0; i<14; i++) {
          PVector LSB = LSBoxLocs.get(i);
          if (mouseX > itt(LSB.x) && mouseX < itt(LSB.x)+LSBoxSize.x
            && mouseY > itt(LSB.y) && mouseY < itt(LSB.y)+LSBoxSize.y && clickTimer<=0) {
            clickTimer=clickTime;
            if(soundOn) menuButtonSound.play();
            startLevel();
            populate(i);
          }
        }
      } else {

        if (mouseX > itt(LSPage2Back.x) && mouseX < itt(LSPage2Back.x)+itt(2)
          && mouseY > itt(LSPage2Back.y) && mouseY < itt(LSPage2Back.y)+itt(1) && clickTimer<=0) {
          clickTimer=clickTime;
          if(soundOn) menuButtonSound.play();
          LSPageNum=0;
        }
        if (mouseX > itt(starInfoLoc.x) && mouseX < itt(starInfoLoc.x)+itt(2)
          && mouseY > itt(starInfoLoc.y) && mouseY < itt(starInfoLoc.y)+itt(2) && clickTimer<=0) {
          clickTimer=clickTime;
          if(soundOn) menuButtonSound.play();
          gameState=6;
        }
        for (int i=14; i<LSBoxLocs.size(); i++) {
          PVector LSB = LSBoxLocs.get(i);
          if (mouseX > itt(LSB.x) && mouseX < itt(LSB.x)+LSBoxSize.x
            && mouseY > itt(LSB.y) && mouseY < itt(LSB.y)+LSBoxSize.y && clickTimer<=0) {
            clickTimer=clickTime;
            if(soundOn) menuButtonSound.play();
            startLevel();
            populate(i);
            LSPageNum=0;
          }
        }
      }
    } 
    if (gameState==0) {
      if (mouseX > itt(playLoc.x) && mouseX < itt(playLoc.x)+mainBoxSize.x
        && mouseY > itt(playLoc.y) && mouseY < itt(playLoc.y)+mainBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        startLevel();
        int playlvl=0;
        for (int i=starRatings.length-1; i>=0; i--) {
          if (starRatings[i]==0) playlvl= i;
        }
        populate(playlvl);
      }
      if (mouseX > itt(levelSelectLoc.x) && mouseX < itt(levelSelectLoc.x)+mainBoxSize.x
        && mouseY > itt(levelSelectLoc.y) && mouseY < itt(levelSelectLoc.y)+mainBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        gameState = 1;
      }

      if (mouseX > itt(howToPlayLoc.x) && mouseX < itt(howToPlayLoc.x)+mainBoxSize.x
        && mouseY > itt(howToPlayLoc.y) && mouseY < itt(howToPlayLoc.y)+mainBoxSize.y && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        gameState = 5;
        tutAnimationTimer=0;
      }
      if (mouseX > itt(quitGameLoc.x) && mouseX < itt(quitGameLoc.x)+itt(2)
        && mouseY > itt(quitGameLoc.y) && mouseY < itt(quitGameLoc.y)+itt(1) && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        exit();
      }
      if (mouseX > itt(soundOnLoc.x) && mouseX < itt(soundOnLoc.x)+itt(2)
        && mouseY > itt(soundOnLoc.y) && mouseY < itt(soundOnLoc.y)+itt(2) && clickTimer<=0) {
        clickTimer=clickTime;
        soundOn=!soundOn;
        if(soundOn){
          menuButtonSound.play();
          extended.loop();
        }else extended.stop();
        saveData();
      }
      if (mouseX > itt(texturesOnLoc.x) && mouseX < itt(texturesOnLoc.x)+itt(2)
        && mouseY > itt(texturesOnLoc.y) && mouseY < itt(texturesOnLoc.y)+itt(2) && clickTimer<=0) {
        clickTimer=clickTime;
        if(soundOn) menuButtonSound.play();
        texturesOn=!texturesOn;
        saveData();
      }
    }
  }

  void OCMessageStart() {
    OCMessageTimer=5*PI;
  }

  void ONCMessage() {
    textFont(font2);
    fill(100, 0, 0);
    textSize(textSize);
    textAlign(CORNER);
    text("OBJECTIVES NOT COMPLETE", OCBase.x, OCBase.y);
    textFont(font);
  }

  void objectivesCompleteMessage() {
    textFont(font2);
    if (OCMessageTimer>0 && !Mover.dead) {
      fill(50);
      textSize(textSize);
      textAlign(CORNER);
      OCMessageTimer-=PI/frameRate;
      if(levelNum!=28){
      text("O", OCBase.x+OCSpacing*0, OCBase.y+sin(OCMessageTimer+0)/2*OCMult);
      text("B", OCBase.x+OCSpacing*1.1, OCBase.y+sin(OCMessageTimer+1)/2*OCMult);
      text("J", OCBase.x+OCSpacing*2.25, OCBase.y+sin(OCMessageTimer+2)/2*OCMult);
      text("E", OCBase.x+OCSpacing*3, OCBase.y+sin(OCMessageTimer+3)/2*OCMult);
      text("C", OCBase.x+OCSpacing*4, OCBase.y+sin(OCMessageTimer+4)/2*OCMult);
      text("T", OCBase.x+OCSpacing*5.15, OCBase.y+sin(OCMessageTimer+5)/2*OCMult);
      text("I", OCBase.x+OCSpacing*6.25, OCBase.y+sin(OCMessageTimer+6)/2*OCMult);
      text("V", OCBase.x+OCSpacing*7, OCBase.y+sin(OCMessageTimer+7)/2*OCMult);
      text("E", OCBase.x+OCSpacing*8, OCBase.y+sin(OCMessageTimer+8)/2*OCMult);
      text("S", OCBase.x+OCSpacing*9, OCBase.y+sin(OCMessageTimer+9)/2*OCMult);
      text(" ", OCBase.x+OCSpacing*10, OCBase.y+sin(OCMessageTimer+10)/2*OCMult);
      text("C", OCBase.x+OCSpacing*10.8, OCBase.y+sin(OCMessageTimer+11)/2*OCMult);
      text("O", OCBase.x+OCSpacing*11.9, OCBase.y+sin(OCMessageTimer+12)/2*OCMult);
      text("M", OCBase.x+OCSpacing*13.2, OCBase.y+sin(OCMessageTimer+13)/2*OCMult);
      text("P", OCBase.x+OCSpacing*14.4, OCBase.y+sin(OCMessageTimer+14)/2*OCMult);
      text("L", OCBase.x+OCSpacing*15.3, OCBase.y+sin(OCMessageTimer+15)/2*OCMult);
      text("E", OCBase.x+OCSpacing*16.3, OCBase.y+sin(OCMessageTimer+16)/2*OCMult);
      text("T", OCBase.x+OCSpacing*17.3, OCBase.y+sin(OCMessageTimer+17)/2*OCMult);
      text("E", OCBase.x+OCSpacing*18.3, OCBase.y+sin(OCMessageTimer+18)/2*OCMult);
      }else{
      text("T", OCBase.x+OCSpacing*0, OCBase.y+sin(OCMessageTimer+0)/2*OCMult);
      text("H", OCBase.x+OCSpacing*1.1, OCBase.y+sin(OCMessageTimer+1)/2*OCMult);
      text("A", OCBase.x+OCSpacing*2.25, OCBase.y+sin(OCMessageTimer+2)/2*OCMult);
      text("N", OCBase.x+OCSpacing*3, OCBase.y+sin(OCMessageTimer+3)/2*OCMult);
      text("K", OCBase.x+OCSpacing*4, OCBase.y+sin(OCMessageTimer+4)/2*OCMult);
      text(" ", OCBase.x+OCSpacing*5.15, OCBase.y+sin(OCMessageTimer+5)/2*OCMult);
      text("Y", OCBase.x+OCSpacing*6.25, OCBase.y+sin(OCMessageTimer+6)/2*OCMult);
      text("O", OCBase.x+OCSpacing*7, OCBase.y+sin(OCMessageTimer+7)/2*OCMult);
      text("U", OCBase.x+OCSpacing*8, OCBase.y+sin(OCMessageTimer+8)/2*OCMult);
      text(" ", OCBase.x+OCSpacing*9, OCBase.y+sin(OCMessageTimer+9)/2*OCMult);
      text("P", OCBase.x+OCSpacing*10, OCBase.y+sin(OCMessageTimer+10)/2*OCMult);
      text("E", OCBase.x+OCSpacing*10.8, OCBase.y+sin(OCMessageTimer+11)/2*OCMult);
      text("W", OCBase.x+OCSpacing*11.9, OCBase.y+sin(OCMessageTimer+12)/2*OCMult);
      text("D", OCBase.x+OCSpacing*13.2, OCBase.y+sin(OCMessageTimer+13)/2*OCMult);
      text("I", OCBase.x+OCSpacing*14.4, OCBase.y+sin(OCMessageTimer+14)/2*OCMult);
      text("E", OCBase.x+OCSpacing*15.3, OCBase.y+sin(OCMessageTimer+15)/2*OCMult);
      text("P", OCBase.x+OCSpacing*16.3, OCBase.y+sin(OCMessageTimer+16)/2*OCMult);
      text("I", OCBase.x+OCSpacing*17.3, OCBase.y+sin(OCMessageTimer+17)/2*OCMult);
      text("E", OCBase.x+OCSpacing*18.3, OCBase.y+sin(OCMessageTimer+18)/2*OCMult);  
      }
    } else {
      OCMessageTimer = 0;
    }
    textFont(font);
  }

  void showTimerAndDeaths() {
    fill(50);
    textSize(textSize*1.5);
    textAlign(CORNER);
    text("TIME: " + String.format("%.1f", timer), itt(17.5), itt(0.85));
    timer+=1/frameRate;

    text("DEATHS: " + deathCount, itt(22.5), itt(0.85));
    if (levelNum==0) text("Tutorial", itt(5), itt(0.85));
    else text("Level "+(levelNum-1), itt(5), itt(0.85));
  }

  void drawSaves() {
    for (int i=0; i<saveCount; i++) drawSaveIcon(i+2, 0.5);
  }

  void drawSaveIcon(float x, float y) {
    PVector center = new PVector(x*Grid.Xiteration, y*Grid.Yiteration);
    rectMode(CENTER);
    noStroke();
    fill(50);
    rect(center.x, center.y, 25, 25, 5);

    stroke(255);
    strokeWeight(1.5);
    rect(center.x, center.y+3.75, 12.5, 8.75, 2.5);

    noStroke();
    fill(255);
    rect(center.x, center.y-10, 15, 6.25);

    fill(50);
    rect(center.x+3.75, center.y-10, 2.5, 5);

    rectMode(CORNER);
  }

  void flash() {

    noStroke();
    fill(255, flashTime*flashMult);
    rect(0, 0, width, height);
    flashTime-=1;
  }

  void drawStar(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0-HALF_PI; a < TWO_PI-HALF_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }


  void showMiniLevel(int lev, float x, float y) {
    x+=6;
    noStroke();

    if (lev==0) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);  
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=1; i<13; i++) { //vertical edges
        rect(x+0*2, y+i*2, 2, 2); 
        rect(x+27*2, y+i*2, 2, 2);
      }
      for (int i=1; i<6; i++) rect(x+i*2, y+4*2, 2, 2); 
      for (int i=1; i<6; i++) rect(x+i*2, y+5*2, 2, 2);  
      rect(x+6*2, y+5*2, 2, 2);
      rect(x+6*2, y+5*2, 2, 2);
      rect(x+4*2, y+6*2, 2, 2);
      for (int i=4; i<8; i++) rect(x+i*2, y+7*2, 2, 2);
      for (int i=4; i<8; i++) rect(x+i*2, y+8*2, 2, 2);
      for (int i=4; i<8; i++) rect(x+i*2, y+9*2, 2, 2);
      for (int i=1; i<10; i++) rect(x+11*2, y+i*2, 2, 2);
      for (int i=1; i<5; i++) rect(x+12*2, y+i*2, 2, 2);
      for (int i=7; i<10; i++) rect(x+10*2, y+i*2, 2, 2);
      rect(x+10*2, y+6*2, 2, 2);
      for (int i=10; i<18; i++) rect(x+i*2, y+12*2, 2, 2);
      for (int i=4; i<12; i++) rect(x+17*2, y+i*2, 2, 2);
      for (int i=10; i<12; i++) rect(x+16*2, y+i*2, 2, 2);
      rect(x+16*2, y+4*2, 2, 2);
      for (int i=1; i<13; i++) if (i<6||i>8) rect(x+21*2, y+i*2, 2, 2);
      for (int i=1; i<13; i++) if (i<6||i>8) rect(x+22*2, y+i*2, 2, 2);
      for (int i=1; i<13; i++) if (i<6||i>8) rect(x+23*2, y+i*2, 2, 2);
      fill(red);
      for (int i=5; i<10; i++) for (int j=12; j<17; j++) if (j!=14) rect(x+j*2, y+i*2, 2, 2);
      rect(x+10*2, y+4*2, 2, 2); 
      rect(x+10*2, y+5*2, 2, 2); 
      fill(green);
      rect(x+13*2, y+1*2, 6, 6);
    }

    if (lev==1) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+1*2, 2, 2); 
        rect(x+i*2, y+2*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2); 
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<6; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=6; i<13; i++) {
        rect(x+i*2, y+5*2, 2, 2);
      }
      for (int i=16; i<20; i++) {
        rect(x+i*2, y+3*2, 2, 2);
        rect(x+i*2, y+4*2, 2, 2);
      }
      rect(x+15*2, y+3*2, 2, 2);

      fill(green);
      for (int i=20; i<22; i++) {
        rect(x+i*2, y+3*2, 2, 2);
        rect(x+i*2, y+4*2, 2, 2);
      }
    }

    if (lev==2) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2); 
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<9; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=13; i<17; i++) {
        rect(x+i*2, y+2*2, 2, 2); 
        rect(x+i*2, y+3*2, 2, 2);
        rect(x+i*2, y+4*2, 2, 2);
        rect(x+i*2, y+5*2, 2, 2);
      } 
      rect(x+13*2, y+8*2, 2, 2); 
      rect(x+14*2, y+8*2, 2, 2); 
      rect(x+15*2, y+8*2, 2, 2); 
      rect(x+16*2, y+8*2, 2, 2);
      rect(x+16*2, y+7*2, 2, 2);
      rect(x+16*2, y+6*2, 2, 2);
      fill(green);
      rect(x+17*2, y+2*2, 4, 4);
    }
    if (lev==3) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=1; i<13; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+19*2, y+i*2, 2, 2);
      }
      for (int i=1; i<13; i++) {
        if (i!=4 && i!=6 && i!=8) {
          rect(x+8*2, y+i*2, 2, 2);
          rect(x+9*2, y+i*2, 2, 2);
        }
      }
      for (int i=13; i<16; i++) {
        if (i!=4 && i!=6 && i!=8) {
          rect(x+i*2, y+2*2, 2, 2);
          rect(x+i*2, y+3*2, 2, 2);
          rect(x+i*2, y+5*2, 2, 2); 
          rect(x+i*2, y+7*2, 2, 2);
          rect(x+i*2, y+9*2, 2, 2);
        }
      }
      for (int i=13; i<19; i++) {
        rect(x+i*2, y+12*2, 2, 2);
      }
      rect(x+15*2, y+4*2, 2, 2); 
      rect(x+15*2, y+6*2, 2, 2);
      rect(x+15*2, y+8*2, 2, 2);
      rect(x+13*2, y+10*2, 2, 2);
      rect(x+13*2, y+11*2, 2, 2); 
      fill(green);
      rect(x+14*2, y+10*2, 4, 4);
    }
    if (lev==4) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+10*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<11; i++) { //vertical edges
        for (int j=0; j<9; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+9*2, y+i*2, 2, 2);
      }
      rect(x+10*2, y+2*2, 2, 2);
      rect(x+11*2, y+2*2, 2, 2);
      rect(x+12*2, y+2*2, 2, 2);
      rect(x+16*2, y+2*2, 2, 2);
      rect(x+17*2, y+2*2, 2, 2);
      rect(x+18*2, y+2*2, 2, 2);
      rect(x+10*2, y+3*2, 2, 2);
      rect(x+11*2, y+3*2, 2, 2);
      rect(x+12*2, y+3*2, 2, 2);
      rect(x+16*2, y+3*2, 2, 2);
      rect(x+17*2, y+3*2, 2, 2);
      rect(x+17*2, y+4*2, 2, 2);
      rect(x+18*2, y+3*2, 2, 2);
      rect(x+18*2, y+4*2, 2, 2);
      rect(x+10*2, y+6*2, 2, 2);
      rect(x+11*2, y+6*2, 2, 2);
      rect(x+10*2, y+9*2, 2, 2);
      rect(x+11*2, y+9*2, 2, 2);
      rect(x+12*2, y+9*2, 2, 2);
      rect(x+16*2, y+9*2, 2, 2);
      rect(x+17*2, y+9*2, 2, 2);
      rect(x+18*2, y+9*2, 2, 2);
      fill(green);
      rect(x+10*2, y+4*2, 4, 4);
    }
    if (lev==5) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+8*2, y+i*2, 2, 2);
      }
      for (int i=9; i<15; i++) { 
        rect(x+i*2, y+9*2, 2, 2);
        rect(x+i*2, y+10*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
      }
      rect(x+15*2, y+9*2, 2, 2);
      rect(x+16*2, y+9*2, 2, 2);
      for (int i=12; i<17; i++) { 
        rect(x+i*2, y+6*2, 2, 2);
        rect(x+i*2, y+7*2, 2, 2);
        rect(x+i*2, y+8*2, 2, 2);
      }
      fill(red);
      rect(x+17*2, y+6*2, 2, 2);
      rect(x+17*2, y+7*2, 2, 2);
      fill(green);
      rect(x+15*2, y+10*2, 4, 4);
    }
    if (lev==6) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2); 
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+19*2, y+i*2, 2, 2);
      }

      for (int i=9; i<12; i++) {
        rect(x+8*2, y+i*2, 2, 2);
        rect(x+18*2, y+i*2, 2, 2);
      }
      for (int i=2; i<5; i++) {
        rect(x+8*2, y+i*2, 2, 2);
        rect(x+9*2, y+i*2, 2, 2);
        rect(x+10*2, y+i*2, 2, 2); 
        rect(x+16*2, y+i*2, 2, 2);
        rect(x+17*2, y+i*2, 2, 2);
        rect(x+18*2, y+i*2, 2, 2);
      }
      rect(x+9*2, y+9*2, 2, 2);
      rect(x+10*2, y+9*2, 2, 2);
      rect(x+16*2, y+9*2, 2, 2);
      rect(x+17*2, y+9*2, 2, 2);
      rect(x+9*2, y+10*2, 2, 2);
      rect(x+16*2, y+10*2, 2, 2);
      rect(x+17*2, y+10*2, 2, 2);
      rect(x+16*2, y+11*2, 2, 2); 
      rect(x+17*2, y+11*2, 2, 2); 
      rect(x+10*2, y+10*2, 2, 2);
      rect(x+9*2, y+11*2, 2, 2);
      rect(x+10*2, y+11*2, 2, 2);
      rect(x+8*2, y+5*2, 2, 2);
      rect(x+9*2, y+5*2, 2, 2);
      rect(x+10*2, y+5*2, 2, 2);
      rect(x+10*2, y+6*2, 2, 2);
      rect(x+10*2, y+7*2, 2, 2);
      rect(x+9*2, y+7*2, 2, 2);
      rect(x+16*2, y+5*2, 2, 2);
      rect(x+16*2, y+6*2, 2, 2);
      rect(x+16*2, y+7*2, 2, 2);
      rect(x+17*2, y+7*2, 2, 2);
      fill(green);
      rect(x+17*2, y+5*2, 4, 4);
    }
    if (lev==7) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+1*2, 2, 2); 
        if (i!=8 && i!=9) rect(x+i*2, y+11*2, 2, 2);  
        if (i!=8 && i!=9) rect(x+i*2, y+12*2, 2, 2); 
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<11; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+19*2, y+i*2, 2, 2);
      }
      fill(green);
      rect(x+8*2, y+11*2, 4, 4);
    }
    if (lev==8) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+1*2, 2, 2); 
        rect(x+i*2, y+11*2, 2, 2);  
        rect(x+i*2, y+12*2, 2, 2); 
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      rect(x+8*2, y+2*2, 2, 2); 
      rect(x+8*2, y+3*2, 2, 2); 
      for (int i=11; i<20; i++) {
        rect(x+i*2, y+2*2, 2, 2); 
        rect(x+i*2, y+3*2, 2, 2);
      }
      for (int i=11; i<18; i++) {
        if (i!=14)rect(x+i*2, y+6*2, 2, 2); 
        if (i!=14)rect(x+i*2, y+7*2, 2, 2);
      }
      rect(x+17*2, y+4*2, 2, 2); 
      rect(x+17*2, y+5*2, 2, 2); 
      rect(x+10*2, y+6*2, 2, 2); 
      rect(x+10*2, y+7*2, 2, 2); 
      rect(x+8*2, y+4*2, 2, 2); 
      fill(green);
      rect(x+18*2, y+4*2, 4, 4);
    }
    if (lev==9) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<13; i++) { //vertical edges
        for (int j=0; j<10; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+10*2, y+i*2, 2, 2);
      }
      for (int i=13; i<16; i++) {
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+1*2, 2, 2);
      }
      rect(x+14*2, y+2*2, 2, 2); 
      rect(x+11*2, y+11*2, 2, 2); 
      rect(x+11*2, y+12*2, 2, 2); 
      rect(x+12*2, y+12*2, 2, 2); 
      rect(x+17*2, y+11*2, 2, 2); 
      rect(x+17*2, y+12*2, 2, 2); 
      rect(x+16*2, y+12*2, 2, 2); 
      rect(x+13*2, y+2*2, 2, 2); 
      rect(x+15*2, y+2*2, 2, 2); 
      rect(x+12*2, y+11*2, 2, 2); 
      rect(x+16*2, y+11*2, 2, 2); 
      rect(x+11*2, y+6*2, 2, 2); 
      rect(x+11*2, y+7*2, 2, 2); 
      rect(x+17*2, y+6*2, 2, 2); 
      rect(x+17*2, y+7*2, 2, 2); 
      fill(red);
      rect(x+14*2, y+7*2, 2, 2); 
      rect(x+14*2, y+8*2, 2, 2); 
      rect(x+14*2, y+9*2, 2, 2); 
      rect(x+13*2, y+9*2, 2, 2); 
      rect(x+15*2, y+9*2, 2, 2); 
      rect(x+13*2, y+8*2, 2, 2); 
      rect(x+15*2, y+8*2, 2, 2); 
      fill(green);
      rect(x+13*2, y+12*2, 6, 2);
    }
    if (lev==10) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+1*2, 2, 2); 
        rect(x+i*2, y+2*2, 2, 2);  
        rect(x+i*2, y+10*2, 2, 2); 
        rect(x+i*2, y+11*2, 2, 2); 
        rect(x+i*2, y+12*2, 2, 2);  
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=3; i<10; i++) { //vertical edges
        for (int j=0; j<7; j++) {
          rect(x+j*2, y+i*2, 2, 2);  
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=3; i<10; i++) { 
        if (i!=6)rect(x+9*2, y+i*2, 2, 2);
      }
      rect(x+7*2, y+3*2, 2, 2);   
      rect(x+8*2, y+3*2, 2, 2);   
      rect(x+7*2, y+4*2, 2, 2);   
      rect(x+8*2, y+4*2, 2, 2);  
      rect(x+7*2, y+8*2, 2, 2);   
      rect(x+8*2, y+8*2, 2, 2);  
      rect(x+7*2, y+9*2, 2, 2);  
      rect(x+8*2, y+9*2, 2, 2);  
      fill(green);
      rect(x+7*2, y+5*2, 4, 6);
    }

    if (lev==11) {

      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<13; i++) { //vertical edges
        for (int j=0; j<7; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+20*2, y+i*2, 2, 2);
      }
      for (int i=0; i<13; i++) {
        if (i!=9 && i!=10) {
          rect(x+7*2, y+i*2, 2, 2);
          rect(x+8*2, y+i*2, 2, 2);
          rect(x+18*2, y+i*2, 2, 2);
          rect(x+19*2, y+i*2, 2, 2);
        }
      }
      for (int i=9; i<18; i++) {
        if (i<11 || i>15) {
          rect(x+i*2, y+0*2, 2, 2);
          rect(x+i*2, y+1*2, 2, 2);
          rect(x+i*2, y+11*2, 2, 2);
          rect(x+i*2, y+12*2, 2, 2);
        }
      }
      rect(x+15*2, y+0*2, 2, 2);
      rect(x+15*2, y+1*2, 2, 2);
      rect(x+11*2, y+0*2, 2, 2);
      rect(x+11*2, y+1*2, 2, 2);
      rect(x+11*2, y+11*2, 2, 2);
      rect(x+11*2, y+12*2, 2, 2);
      rect(x+15*2, y+11*2, 2, 2);
      rect(x+15*2, y+12*2, 2, 2);


      fill(green);
      for (int i=12; i<15; i++) {
        rect(x+i*2, y+11*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
      }

      fill(red);
      for (int i=11; i<16; i++) { 
        for (int j=4; j<9; j++) {
          rect(x+i*2, y+j*2, 2, 2);
        }
      }
    }

    if (lev==12) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        if (i!=15 && i!=16 && i!=17)rect(x+i*2, y+0*2, 2, 2);
      }
      for (int i=0; i<14; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      rect(x+15*2, y+0*2, 2, 2);
      rect(x+16*2, y+0*2, 2, 2);
      rect(x+17*2, y+0*2, 2, 2);
      for (int i=5; i<14; i++) { 
        rect(x+8*2, y+i*2, 2, 2);
        rect(x+9*2, y+i*2, 2, 2);
        rect(x+18*2, y+i*2, 2, 2);
        rect(x+19*2, y+i*2, 2, 2);
      }
      for (int i=3; i<12; i++) { 
        rect(x+10*2, y+i*2, 2, 2);
        rect(x+11*2, y+i*2, 2, 2);
        rect(x+17*2, y+i*2, 2, 2);
        rect(x+16*2, y+i*2, 2, 2);
      }
      for (int i=3; i<12; i++) { 
        rect(x+12*2, y+i*2, 2, 2);
        rect(x+15*2, y+i*2, 2, 2);
      }
      fill(green);
      rect(x+13*2, y+1*2, 4, 4);
    }
    if (lev==13) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2); 
        rect(x+i*2, y+12*2, 2, 2); 
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<13; i++) { //vertical edges
        for (int j=0; j<7; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=4; i<10; i++) rect(x+10*2, y+i*2, 2, 2); 
      for (int i=6; i<10; i++) { 
        rect(x+16*2, y+i*2, 2, 2); 
        rect(x+17*2, y+i*2, 2, 2);
      }
      rect(x+17*2, y+4*2, 2, 2); 
      rect(x+17*2, y+5*2, 2, 2); 
      rect(x+15*2, y+6*2, 2, 2); 
      rect(x+14*2, y+6*2, 2, 2); 
      rect(x+14*2, y+5*2, 2, 2); 
      rect(x+14*2, y+4*2, 2, 2); 
      rect(x+11*2, y+9*2, 2, 2); 
      rect(x+11*2, y+8*2, 2, 2); 
      rect(x+12*2, y+9*2, 2, 2); 
      fill(red);
      for (int i=4; i<12; i++) { 
        if (i!=8) {
          rect(x+7*2, y+i*2, 2, 2);
          rect(x+8*2, y+i*2, 2, 2);
          rect(x+9*2, y+i*2, 2, 2);
        }
      }
      rect(x+7*2, y+8*2, 2, 2);
      rect(x+9*2, y+8*2, 2, 2);
      fill(green);
      rect(x+15*2, y+4*2, 4, 4);
    }
    if (lev==14) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<4; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+4*2, y+i*2, 2, 2);
      }
      for (int i=10; i<24; i++) {
        if (i!=10)rect(x+i*2, y+2*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
      }
      for (int i=3; i<7; i++) {
        rect(x+17*2, y+i*2, 2, 2);
        rect(x+18*2, y+i*2, 2, 2);
      }
      for (int i=3; i<11; i++) {
        if (i!=5 && i!=6 && i!=8 && i!=9) rect(x+22*2, y+i*2, 2, 2);
        if (i!=5 && i!=6 && i!=8 && i!=9) rect(x+23*2, y+i*2, 2, 2);
      }
      rect(x+5*2, y+11*2, 2, 2);
      rect(x+6*2, y+11*2, 2, 2);
      rect(x+10*2, y+10*2, 2, 2);
      rect(x+11*2, y+10*2, 2, 2);
      rect(x+10*2, y+2*2, 2, 2);
      rect(x+17*2, y+7*2, 2, 2);
      rect(x+18*2, y+7*2, 2, 2);
      fill(red);
      rect(x+7*2, y+9*2, 2, 2);
      rect(x+8*2, y+9*2, 2, 2);
      rect(x+9*2, y+9*2, 2, 2);
      rect(x+10*2, y+9*2, 2, 2);
      rect(x+10*2, y+8*2, 2, 2);
      rect(x+10*2, y+7*2, 2, 2);
      rect(x+10*2, y+6*2, 2, 2);
      rect(x+5*2, y+6*2, 2, 2);
      rect(x+6*2, y+6*2, 2, 2);
      rect(x+7*2, y+6*2, 2, 2);
      rect(x+10*2, y+10*2, 2, 2);
      rect(x+10*2, y+5*2, 2, 2);
      fill(green);
      rect(x+22*2, y+5*2, 4, 4);
    }
    if (lev==15) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        if (i!=10&&i!=11)rect(x+i*2, y+0*2, 2, 2);
        if (i!=10&&i!=11)rect(x+i*2, y+1*2, 2, 2);
        if (i!=10&&i!=11)rect(x+i*2, y+11*2, 2, 2);
        if (i!=10&&i!=11)rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<14; i++) { //vertical edges
        for (int j=0; j<10; j++) {
          rect(x+j*2, y+i*2, 2, 2); 
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=13; i<18; i++) {
        rect(x+i*2, y+2*2, 2, 2); 
        if (i>13)rect(x+i*2, y+3*2, 2, 2); 
        if (i>14)rect(x+i*2, y+4*2, 2, 2);
      }
      rect(x+14*2, y+9*2, 2, 2); 
      rect(x+15*2, y+9*2, 2, 2); 
      rect(x+15*2, y+10*2, 2, 2); 
      rect(x+12*2, y+2*2, 2, 2); 
      rect(x+13*2, y+3*2, 2, 2); 
      rect(x+14*2, y+4*2, 2, 2); 
      rect(x+17*2, y+5*2, 2, 2); 
      rect(x+14*2, y+8*2, 2, 2); 
      rect(x+15*2, y+8*2, 2, 2); 
      fill(green);
      rect(x+10*2, y+11*2, 4, 4);
    }
    if (lev==16) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<13; i++) { //vertical edges
        for (int j=0; j<6; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+21*2, y+i*2, 2, 2);
      }

      for (int i=11; i<16; i++) {
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
      }
      for (int i=2; i<11; i++) {
        rect(x+20*2, y+i*2, 2, 2);
      }
      for (int i=2; i<11; i++) {
        rect(x+6*2, y+i*2, 2, 2);
      }
      rect(x+20*2, y+11*2, 2, 2);
      rect(x+20*2, y+1*2, 2, 2);
      rect(x+16*2, y+11*2, 2, 2);
      rect(x+6*2, y+1*2, 2, 2);
      rect(x+6*2, y+11*2, 2, 2);
      rect(x+12*2, y+2*2, 2, 2);
      rect(x+13*2, y+2*2, 2, 2);
      rect(x+14*2, y+2*2, 2, 2);
      rect(x+12*2, y+10*2, 2, 2);
      rect(x+13*2, y+10*2, 2, 2);
      rect(x+14*2, y+10*2, 2, 2);
      rect(x+13*2, y+3*2, 2, 2);
      rect(x+13*2, y+9*2, 2, 2);
      rect(x+17*2, y+5*2, 2, 2);
      rect(x+17*2, y+6*2, 2, 2);
      rect(x+17*2, y+7*2, 2, 2);
      rect(x+9*2, y+5*2, 2, 2);
      rect(x+9*2, y+6*2, 2, 2);
      rect(x+9*2, y+7*2, 2, 2);
      rect(x+16*2, y+6*2, 2, 2);
      rect(x+10*2, y+6*2, 2, 2);
      rect(x+16*2, y+5*2, 2, 2);
      rect(x+17*2, y+4*2, 2, 2);
      rect(x+16*2, y+7*2, 2, 2);
      rect(x+17*2, y+8*2, 2, 2);
      rect(x+9*2, y+4*2, 2, 2);
      rect(x+10*2, y+5*2, 2, 2);
      rect(x+9*2, y+8*2, 2, 2);
      rect(x+10*2, y+7*2, 2, 2);
      rect(x+16*2, y+1*2, 2, 2);
      rect(x+15*2, y+2*2, 2, 2);
      rect(x+14*2, y+3*2, 2, 2);
      rect(x+10*2, y+1*2, 2, 2);
      rect(x+11*2, y+2*2, 2, 2);
      rect(x+12*2, y+3*2, 2, 2);
      rect(x+10*2, y+11*2, 2, 2);
      rect(x+11*2, y+10*2, 2, 2);
      rect(x+12*2, y+9*2, 2, 2);
      rect(x+16*2, y+11*2, 2, 2);
      rect(x+15*2, y+10*2, 2, 2);
      rect(x+14*2, y+9*2, 2, 2);
      rect(x+19*2, y+1*2, 2, 2);
      rect(x+19*2, y+11*2, 2, 2);
      rect(x+7*2, y+11*2, 2, 2);
      rect(x+7*2, y+1*2, 2, 2);
      fill(red);
      rect(x+13*2, y+8*2, 2, 2);
      rect(x+13*2, y+4*2, 2, 2);
      rect(x+15*2, y+6*2, 2, 2);
      rect(x+11*2, y+6*2, 2, 2);
      fill(green);
      rect(x+12*2, y+5*2, 6, 6);
    }
    if (lev==17) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        if (i!=17 && i!=18)rect(x+i*2, y+0*2, 2, 2);
      }
      for (int i=0; i<14; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+8*2, y+i*2, 2, 2);
      }
      for (int i=12; i<16; i++) {
        rect(x+i*2, y+1*2, 2, 2);
      }
      for (int i=16; i<20; i++) {
        rect(x+i*2, y+10*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      rect(x+16*2, y+9*2, 2, 2);
      rect(x+19*2, y+9*2, 2, 2);
      for (int i=9; i<13; i++) {
        rect(x+i*2, y+9*2, 2, 2);
      }
      rect(x+12*2, y+8*2, 2, 2);
      rect(x+12*2, y+10*2, 2, 2);
      rect(x+16*2, y+8*2, 2, 2);
      rect(x+17*2, y+9*2, 2, 2);
      rect(x+19*2, y+8*2, 2, 2);
      rect(x+18*2, y+9*2, 2, 2);
      rect(x+16*2, y+1*2, 2, 2);
      rect(x+17*2, y+0*2, 2, 2);
      rect(x+19*2, y+1*2, 2, 2);
      rect(x+18*2, y+0*2, 2, 2);
      fill(green);
      rect(x+9*2, y+1*2, 6, 2);
    }
    if (lev==18) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<8; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }

      for (int i=11; i<17; i++) { 
        rect(x+i*2, y+2*2, 2, 2);
        rect(x+i*2, y+3*2, 2, 2);
      }
      for (int i=8; i<12; i++) { 
        rect(x+8*2, y+i*2, 2, 2);
        rect(x+9*2, y+i*2, 2, 2);
        rect(x+10*2, y+i*2, 2, 2);
      }
      rect(x+17*2, y+8*2, 2, 2); 
      rect(x+18*2, y+8*2, 2, 2);
      rect(x+19*2, y+8*2, 2, 2);
      fill(red);
      rect(x+16*2, y+8*2, 2, 2);
      rect(x+15*2, y+7*2, 2, 2);
      rect(x+16*2, y+7*2, 2, 2);
      rect(x+11*2, y+8*2, 2, 2);
      rect(x+12*2, y+7*2, 2, 2);
      rect(x+11*2, y+7*2, 2, 2);
      fill(green);
      rect(x+13*2, y+4*2, 4, 4);
    }
    if (lev==19) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<6; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+6*2, y+i*2, 2, 2);
      }
      for (int i=4; i<10; i++) {
        rect(x+20*2, y+i*2, 2, 2);
        rect(x+21*2, y+i*2, 2, 2);
      }
      for (int i=7; i<12; i++) {
        rect(x+16*2, y+i*2, 2, 2);
      }
      for (int i=12; i<16; i++) {
        rect(x+i*2, y+6*2, 2, 2);
        rect(x+i*2, y+7*2, 2, 2);
        rect(x+i*2, y+8*2, 2, 2);
      }
      rect(x+11*2, y+6*2, 2, 2);
      rect(x+11*2, y+7*2, 2, 2);
      rect(x+16*2, y+6*2, 2, 2);
      rect(x+12*2, y+9*2, 2, 2);
      rect(x+13*2, y+9*2, 2, 2);
      rect(x+10*2, y+6*2, 2, 2);
      rect(x+10*2, y+7*2, 2, 2);
      fill(green);
      rect(x+20*2, y+2*2, 4, 4);
    }
    if (lev==20) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<13; i++) { //vertical edges
        for (int j=0; j<7; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=0; i<11; i++) {
        rect(x+20*2, y+i*2, 2, 2);
        rect(x+7*2, y+i*2, 2, 2);
        if (i<2||i>7) rect(x+19*2, y+i*2, 2, 2);
        if (i<2||i>7) rect(x+8*2, y+i*2, 2, 2);
        if (i<1||i>8) rect(x+18*2, y+i*2, 2, 2);
        if (i<1||i>8) rect(x+9*2, y+i*2, 2, 2);
      } 
      for (int i=3; i<7; i++) {
        rect(x+10*2, y+i*2, 2, 2);
        rect(x+11*2, y+i*2, 2, 2);
        rect(x+12*2, y+i*2, 2, 2);
        rect(x+15*2, y+i*2, 2, 2);
        rect(x+16*2, y+i*2, 2, 2);
        rect(x+17*2, y+i*2, 2, 2);
      } 
      for (int i=10; i<13; i++) {
        rect(x+13*2, y+i*2, 2, 2);
        rect(x+14*2, y+i*2, 2, 2);
      } 
      rect(x+17*2, y+10*2, 2, 2);
      rect(x+10*2, y+10*2, 2, 2);
      rect(x+10*2, y+0*2, 2, 2);
      rect(x+9*2, y+1*2, 2, 2);
      rect(x+8*2, y+2*2, 2, 2);
      rect(x+17*2, y+0*2, 2, 2);
      rect(x+18*2, y+1*2, 2, 2);
      rect(x+19*2, y+2*2, 2, 2);
      rect(x+19*2, y+7*2, 2, 2);
      rect(x+18*2, y+8*2, 2, 2);
      rect(x+17*2, y+9*2, 2, 2);
      rect(x+8*2, y+7*2, 2, 2);
      rect(x+9*2, y+8*2, 2, 2);
      rect(x+10*2, y+9*2, 2, 2);
      rect(x+13*2, y+9*2, 2, 2);
      rect(x+14*2, y+9*2, 2, 2);
      fill(red);
      for (int i=3; i<7; i++) {
        rect(x+8*2, y+i*2, 2, 2);
        rect(x+9*2, y+i*2, 2, 2);
        rect(x+18*2, y+i*2, 2, 2);
        rect(x+19*2, y+i*2, 2, 2);
      } 
      fill(green);
      rect(x+13*2, y+7*2, 4, 4);
    }
    if (lev==21) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+2*2, 2, 2);
        rect(x+i*2, y+10*2, 2, 2);
        rect(x+i*2, y+11*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=3; i<10; i++) { //vertical edges
        for (int j=0; j<7; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=5; i<8; i++) { 
        rect(x+7*2, y+i*2, 2, 2);
        rect(x+8*2, y+i*2, 2, 2);
      }
      rect(x+13*2, y+3*2, 2, 2);
      rect(x+14*2, y+3*2, 2, 2);
      rect(x+13*2, y+4*2, 2, 2);
      rect(x+14*2, y+4*2, 2, 2);
      rect(x+13*2, y+9*2, 2, 2);
      rect(x+14*2, y+9*2, 2, 2);
      fill(red);
      for (int i=18; i<21; i++) { 
        rect(x+i*2, y+5*2, 2, 2);
        rect(x+i*2, y+8*2, 2, 2);
        rect(x+i*2, y+9*2, 2, 2);
      }
      for (int i=5; i<8; i++) { 
        rect(x+10*2, y+i*2, 2, 2);
      }
      rect(x+11*2, y+6*2, 2, 2);
      rect(x+11*2, y+5*2, 2, 2);
      rect(x+11*2, y+7*2, 2, 2);
      fill(green);
      rect(x+7*2, y+8*2, 4, 4);
    }
    if (lev==22) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
      }
      for (int i=1; i<14; i++) { //vertical edges
        for (int j=0; j<3; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+4*2, y+i*2, 2, 2); 
        rect(x+3*2, y+i*2, 2, 2);
        if (i!=9 && i!=10 && i!=11) rect(x+24*2, y+i*2, 2, 2);
      }

      for (int i=1; i<10; i++) { 
        rect(x+5*2, y+i*2, 2, 2);
        rect(x+6*2, y+i*2, 2, 2);
        rect(x+7*2, y+i*2, 2, 2);
      }
      for (int i=8; i<13; i++) { 
        rect(x+i*2, y+8*2, 2, 2);
        rect(x+i*2, y+9*2, 2, 2);
      }
      for (int i=5; i<17; i++) rect(x+i*2, y+13*2, 2, 2);
      for (int i=13; i<17; i++) rect(x+i*2, y+12*2, 2, 2);
      for (int i=5; i<12; i++) rect(x+16*2, y+i*2, 2, 2);
      for (int i=8; i<12; i++) rect(x+i*2, y+1*2, 2, 2);
      rect(x+5*2, y+12*2, 2, 2);
      rect(x+6*2, y+12*2, 2, 2);
      rect(x+16*2, y+3*2, 2, 2);
      rect(x+16*2, y+4*2, 2, 2);
      rect(x+17*2, y+4*2, 2, 2);
      rect(x+12*2, y+1*2, 2, 2);
      rect(x+17*2, y+3*2, 2, 2);
      fill(red);
      rect(x+22*2, y+13*2, 2, 2);
      rect(x+22*2, y+12*2, 2, 2);
      rect(x+22*2, y+11*2, 2, 2);
      rect(x+19*2, y+11*2, 2, 2);
      rect(x+19*2, y+10*2, 2, 2);
      rect(x+22*2, y+7*2, 2, 2);
      rect(x+23*2, y+7*2, 2, 2);
      rect(x+19*2, y+9*2, 2, 2);
      rect(x+20*2, y+8*2, 2, 2);
      rect(x+21*2, y+7*2, 2, 2);
      rect(x+20*2, y+9*2, 2, 2);
      rect(x+21*2, y+8*2, 2, 2);
      rect(x+22*2, y+10*2, 2, 2);
      fill(green);
      rect(x+5*2, y+10*2, 4, 4);
    }
    if (lev==23) {
      fill(blue);
      for (int i=5; i<23; i++) { //horizontal edges
        if (i<=11 || i>15) rect(x+i*2, y+11*2, 2, 2);
        if (i<=11 || i>15) rect(x+i*2, y+12*2, 2, 2);
        if (i<=11 || i>15) rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=0; i<14; i++) { //vertical edges
        for (int j=0; j<5; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=8; i<20; i++) { 
        if (i<=11 || i>15) rect(x+i*2, y+4*2, 2, 2);
        if (i<=11 || i>15) rect(x+i*2, y+5*2, 2, 2);
        if (i<=11 || i>15) rect(x+i*2, y+6*2, 2, 2);
        if (i<=11 || i>15) rect(x+i*2, y+7*2, 2, 2);
      }
      rect(x+12*2, y+0*2, 2, 2);
      rect(x+12*2, y+1*2, 2, 2);
      rect(x+12*2, y+2*2, 2, 2);
      rect(x+12*2, y+3*2, 2, 2);
      rect(x+15*2, y+0*2, 2, 2);
      rect(x+15*2, y+1*2, 2, 2);
      rect(x+15*2, y+2*2, 2, 2);
      rect(x+15*2, y+3*2, 2, 2);
      rect(x+12*2, y+13*2, 2, 2);
      rect(x+15*2, y+13*2, 2, 2);
      rect(x+13*2, y+0*2, 2, 2);
      rect(x+14*2, y+0*2, 2, 2);
      rect(x+5*2, y+0*2, 2, 2);
      rect(x+6*2, y+0*2, 2, 2);
      rect(x+5*2, y+1*2, 2, 2);
      rect(x+21*2, y+0*2, 2, 2);
      rect(x+22*2, y+0*2, 2, 2);
      rect(x+22*2, y+1*2, 2, 2);
      rect(x+12*2, y+12*2, 2, 2);
      rect(x+15*2, y+12*2, 2, 2);
      rect(x+13*2, y+9*2, 2, 2);
      rect(x+14*2, y+9*2, 2, 2);
      rect(x+13*2, y+10*2, 2, 2);
      rect(x+14*2, y+10*2, 2, 2);
      rect(x+11*2, y+3*2, 2, 2);
      rect(x+12*2, y+4*2, 2, 2);
      rect(x+15*2, y+4*2, 2, 2);
      rect(x+16*2, y+3*2, 2, 2);
      rect(x+11*2, y+0*2, 2, 2);
      rect(x+16*2, y+0*2, 2, 2);
      rect(x+5*2, y+2*2, 2, 2);
      rect(x+6*2, y+1*2, 2, 2);
      rect(x+7*2, y+0*2, 2, 2);
      rect(x+22*2, y+2*2, 2, 2);
      rect(x+21*2, y+1*2, 2, 2);
      rect(x+20*2, y+0*2, 2, 2);
      fill(red);
      for (int i=8; i<20; i++) {
        if (i<12 || i>15) rect(x+i*2, y+8*2, 2, 2);
        if (i<12 || i>15) rect(x+i*2, y+9*2, 2, 2);
      }
      rect(x+5*2, y+7*2, 2, 2);
      rect(x+7*2, y+4*2, 2, 2);
      rect(x+22*2, y+7*2, 2, 2);
      rect(x+20*2, y+4*2, 2, 2);
      fill(green);
      rect(x+13*2, y+3*2, 4, 2);
    }
    if (lev==24) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=1; i<13; i++) { //vertical edges
        for (int j=0; j<4; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+4*2, y+i*2, 2, 2);
      }
      for (int i=9; i<24; i++) {
        rect(x+i*2, y+1*2, 2, 2);
      }
      for (int i=2; i<10; i++) {
        rect(x+20*2, y+i*2, 2, 2);
      }
      rect(x+9*2, y+2*2, 2, 2);
      rect(x+9*2, y+3*2, 2, 2);
      rect(x+9*2, y+4*2, 2, 2);
      rect(x+10*2, y+2*2, 2, 2);
      rect(x+10*2, y+3*2, 2, 2);
      rect(x+19*2, y+2*2, 2, 2);
      rect(x+19*2, y+3*2, 2, 2);
      rect(x+18*2, y+6*2, 2, 2);
      rect(x+19*2, y+6*2, 2, 2);
      rect(x+11*2, y+2*2, 2, 2);
      rect(x+18*2, y+2*2, 2, 2);
      rect(x+9*2, y+5*2, 2, 2);
      rect(x+20*2, y+10*2, 2, 2);
      rect(x+17*2, y+6*2, 2, 2);
      rect(x+5*2, y+1*2, 2, 2);
      fill(red);
      for (int i=12; i<18; i++) {
        rect(x+i*2, y+2*2, 2, 2);
        rect(x+i*2, y+3*2, 2, 2);
      }
      for (int i=12; i<16; i++) {
        rect(x+i*2, y+4*2, 2, 2);
        rect(x+i*2, y+5*2, 2, 2);
      }
      for (int i=9; i<13; i++) {
        rect(x+9*2, y+i*2, 2, 2);
      }
      rect(x+11*2, y+3*2, 2, 2);
      rect(x+18*2, y+3*2, 2, 2);
      rect(x+12*2, y+6*2, 2, 2);
      rect(x+12*2, y+7*2, 2, 2);
      rect(x+16*2, y+4*2, 2, 2);
      rect(x+14*2, y+10*2, 2, 2);
      rect(x+15*2, y+10*2, 2, 2);
      rect(x+14*2, y+11*2, 2, 2);
      rect(x+15*2, y+11*2, 2, 2);
      rect(x+14*2, y+12*2, 2, 2);
      rect(x+7*2, y+7*2, 2, 2);
      rect(x+5*2, y+10*2, 2, 2);
      rect(x+6*2, y+10*2, 2, 2);
      rect(x+11*2, y+2*2, 2, 2);
      rect(x+18*2, y+2*2, 2, 2);
      rect(x+14*2, y+6*2, 2, 2);
      rect(x+15*2, y+6*2, 2, 2);
      rect(x+14*2, y+9*2, 2, 2);
      rect(x+15*2, y+9*2, 2, 2);
      rect(x+12*2, y+8*2, 2, 2);
      rect(x+11*2, y+8*2, 2, 2);
      rect(x+9*2, y+8*2, 2, 2);
      rect(x+8*2, y+8*2, 2, 2);
      rect(x+8*2, y+7*2, 2, 2);
      fill(green);
      rect(x+5*2, y+11*2, 4, 4);
    }
    if (lev==25) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=1; i<13; i++) { //vertical edges
        for (int j=0; j<5; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
      }
      for (int i=5; i<23; i++) {
        if (i<10 || i>17) {
          rect(x+i*2, y+1*2, 2, 2);
          rect(x+i*2, y+12*2, 2, 2);
        } 
        if (i<9 || i>18) {
          rect(x+i*2, y+2*2, 2, 2);
          rect(x+i*2, y+11*2, 2, 2);
        } 
        if (i<8 || i>19) {
          rect(x+i*2, y+3*2, 2, 2);
          rect(x+i*2, y+10*2, 2, 2);
        }
      }
      for (int i=10; i<18; i++) if (i<12 || i>15) rect(x+i*2, y+8*2, 2, 2);
      for (int i=11; i<17; i++) if (i<12 || i>15) rect(x+i*2, y+9*2, 2, 2);
      for (int i=10; i<18; i++) if (i<12|| i>15) rect(x+i*2, y+5*2, 2, 2);
      for (int i=11; i<17; i++) if (i<12 || i>15) rect(x+i*2, y+4*2, 2, 2);
      rect(x+12*2, y+3*2, 2, 2);
      rect(x+15*2, y+3*2, 2, 2);
      rect(x+12*2, y+10*2, 2, 2);
      rect(x+15*2, y+10*2, 2, 2);
      rect(x+12*2, y+4*2, 2, 2);
      rect(x+12*2, y+5*2, 2, 2);
      rect(x+12*2, y+8*2, 2, 2);
      rect(x+12*2, y+9*2, 2, 2);
      rect(x+15*2, y+4*2, 2, 2);
      rect(x+15*2, y+5*2, 2, 2);
      rect(x+15*2, y+8*2, 2, 2);
      rect(x+15*2, y+9*2, 2, 2);
      rect(x+8*2, y+3*2, 2, 2);
      rect(x+9*2, y+2*2, 2, 2);
      rect(x+10*2, y+1*2, 2, 2);
      rect(x+17*2, y+1*2, 2, 2);
      rect(x+18*2, y+2*2, 2, 2);
      rect(x+19*2, y+3*2, 2, 2);
      rect(x+8*2, y+10*2, 2, 2);
      rect(x+9*2, y+11*2, 2, 2);
      rect(x+10*2, y+12*2, 2, 2);
      rect(x+17*2, y+12*2, 2, 2);
      rect(x+18*2, y+11*2, 2, 2);
      rect(x+19*2, y+10*2, 2, 2);
      rect(x+10*2, y+9*2, 2, 2);
      rect(x+11*2, y+10*2, 2, 2);
      rect(x+16*2, y+10*2, 2, 2);
      rect(x+17*2, y+9*2, 2, 2);
      rect(x+16*2, y+3*2, 2, 2);
      rect(x+17*2, y+4*2, 2, 2);
      rect(x+10*2, y+4*2, 2, 2);
      rect(x+11*2, y+3*2, 2, 2);
      fill(red);
      rect(x+8*2, y+6*2, 2, 2);
      rect(x+8*2, y+7*2, 2, 2);
      rect(x+19*2, y+6*2, 2, 2);
      rect(x+19*2, y+7*2, 2, 2);
      rect(x+8*2, y+5*2, 2, 2);
      rect(x+8*2, y+8*2, 2, 2);
      rect(x+19*2, y+5*2, 2, 2);
      rect(x+19*2, y+8*2, 2, 2);
      fill(green);
      rect(x+13*2, y+6*2, 4, 4);
    }
    if (lev==26) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        if (i!=19 && i!=20) rect(x+i*2, y+0*2, 2, 2);
      }
      for (int i=1; i<14; i++) { //vertical edges
        for (int j=0; j<5; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        if (i!=8) rect(x+5*2, y+i*2, 2, 2);
        if (i!=6) rect(x+21*2, y+i*2, 2, 2);
        rect(x+22*2, y+i*2, 2, 2);
      }
      for (int i=8; i<22; i++) {
        if (i!=11 && i!=12 && i!=13 && i!=16 && i!=17 && i!=18) {
          rect(x+i*2, y+12*2, 2, 2);
          rect(x+i*2, y+13*2, 2, 2);
          rect(x+(26-i)*2, y+1*2, 2, 2);
          rect(x+(26-i)*2, y+2*2, 2, 2);
        }
      }
      fill(red);
      for (int i=8; i<19; i+=2) {
        rect(x+i*2, y+5*2, 2, 2);
        rect(x+i*2, y+7*2, 2, 2);
        rect(x+i*2, y+9*2, 2, 2);
      }
      fill(green);
      rect(x+6*2, y+12*2, 4, 4);
    }
    if (lev==27) {
      fill(blue);
      for (int i=0; i<28; i++) { //horizontal edges
        rect(x+i*2, y+0*2, 2, 2);
        rect(x+i*2, y+1*2, 2, 2);
        rect(x+i*2, y+12*2, 2, 2);
        rect(x+i*2, y+13*2, 2, 2);
      }
      for (int i=2; i<12; i++) { //vertical edges
        for (int j=0; j<7; j++) {
          rect(x+j*2, y+i*2, 2, 2);
          rect(x+(27-j)*2, y+i*2, 2, 2);
        }
        rect(x+21*2, y+i*2, 2, 2);
      }
      for (int i=10; i<21; i++) {
        rect(x+i*2, y+2*2, 2, 2);
      }
      for (int i=17; i<21; i++) {
        rect(x+i*2, y+8*2, 2, 2);
      }
      rect(x+17*2, y+3*2, 2, 2);
      rect(x+16*2, y+3*2, 2, 2);
      rect(x+7*2, y+6*2, 2, 2);
      rect(x+8*2, y+6*2, 2, 2);
      rect(x+9*2, y+6*2, 2, 2);
      rect(x+9*2, y+7*2, 2, 2);
      rect(x+9*2, y+8*2, 2, 2);
      rect(x+10*2, y+8*2, 2, 2);
      rect(x+17*2, y+10*2, 2, 2);
      rect(x+17*2, y+11*2, 2, 2);
      rect(x+20*2, y+9*2, 2, 2);
      rect(x+20*2, y+10*2, 2, 2);
      rect(x+16*2, y+4*2, 2, 2);
      rect(x+9*2, y+2*2, 2, 2);
      rect(x+17*2, y+4*2, 2, 2);
      rect(x+11*2, y+8*2, 2, 2);
      rect(x+9*2, y+5*2, 2, 2);
      fill(green);
      rect(x+7*2, y+7*2, 4, 4);
    }
  }
}
