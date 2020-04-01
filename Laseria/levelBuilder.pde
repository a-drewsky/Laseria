class levelBuilder {

  int numLevels = 28;
  PVector[] startPos = new PVector[numLevels];
  PVector startingPosition = new PVector();


  levelBuilder() {
    startPos[0] = new PVector(1.5, 2.5);
    startPos[5] = new PVector(16, 11);
    startPos[1] = new PVector(6.5, 10.5);
    startPos[4] = new PVector(14.5, 6.5);
    startPos[2] = new PVector(9.5, 10.5);
    startPos[7] = new PVector(9, 12);
    startPos[3] = new PVector(11.5, 12.5);
    startPos[18] = new PVector(14, 5);
    startPos[6] = new PVector(14, 8);
    startPos[8] = new PVector(10, 3);
    startPos[10] = new PVector(7.5, 6.5);
    startPos[11] = new PVector(13.5, 12.5);
    startPos[13] = new PVector(16, 5);
    startPos[16] = new PVector(13.5, 6.5);
    startPos[15] = new PVector(11, 12);
    startPos[27] = new PVector(20.5, 11.5);
    startPos[23] = new PVector(14, 13);
    startPos[14] = new PVector(8.5, 11.5);
    startPos[25] = new PVector(14, 7);
    startPos[22] = new PVector(24.5, 10.5);
    startPos[26] = new PVector(7, 13);
    startPos[24] = new PVector(22.5, 3.5);
    startPos[21] = new PVector(8, 9);
    startPos[9] = new PVector(14.5, 12.5);
    startPos[19] = new PVector(21, 11);
    startPos[20] = new PVector(14, 8);
    startPos[17] = new PVector(10.5, 1.5);
    startPos[12] = new PVector(14, 2);
  }

  void buildLevel(int n) {
    startingPosition.x = startPos[n].x * Grid.Xiteration - (Mover.size.x/2);
    startingPosition.y = (startPos[n].y * Grid.Yiteration - (Mover.size.y/2))+35;
    if (n==0) tutorial(); 
    if (n==1) level2();
    if (n==2) level4();
    if (n==3) level6();
    if (n==4) level3();
    if (n==5) level1();
    if (n==6) level8();
    if (n==7) level5();
    if (n==8) level9();
    if (n==9) level23();
    if (n==10) level10();
    if (n==11) level11();
    if (n==12) level14();
    if (n==13) level12();
    if (n==14) level17();
    if (n==15) level27();
    if (n==16) level13();
    if (n==17) level26();
    if (n==18) level7();
    if (n==19) level24();
    if (n==20) level25();
    if (n==21) level22();
    if (n==22) level19();
    if (n==23) level16();
    if (n==24) level21();
    if (n==25) level18();
    if (n==26) level20();
    if (n==27) level15();
  }

  void tutorial() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));  
      blocks.add(new block(i, 13));
    }
    for (int i=1; i<13; i++) { //vertical edges
      blocks.add(new block(0, i)); 
      blocks.add(new block(27, i));
    }

    for (int i=1; i<6; i++) blocks.add(new block(i, 4)); 
    for (int i=1; i<6; i++) blocks.add(new block(i, 5)); 
    triBlocks.add(new triBlock(6, 4, 7, false));
    triBlocks.add(new triBlock(6, 5, 1, false));
    blocks.add(new block(4, 6));
    for (int i=4; i<8; i++) blocks.add(new block(i, 7));
    for (int i=4; i<8; i++) blocks.add(new block(i, 8));
    for (int i=4; i<8; i++) blocks.add(new block(i, 9));
    for (int i=1; i<10; i++) blocks.add(new block(11, i));
    for (int i=1; i<5; i++) blocks.add(new block(12, i));
    for (int i=7; i<10; i++) blocks.add(new block(10, i));
    triBlocks.add(new triBlock(10, 6, 5, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    for (int i=10; i<18; i++) blocks.add(new block(i, 12));
    for (int i=4; i<12; i++) blocks.add(new block(17, i));
    for (int i=10; i<12; i++) blocks.add(new block(16, i));
    blocks.add(new block(16, 4));
    for (int i=1; i<13; i++) if (i<6||i>8) blocks.add(new block(21, i));
    for (int i=1; i<13; i++) if (i<6||i>8) blocks.add(new block(22, i));
    for (int i=1; i<13; i++) if (i<6||i>8) blocks.add(new block(23, i));
    doors.add(new door(7, 5, 10, 5, 2));
    triggers.add(new trigger(5.5, 6.5, 2, false));
    lasers.add(new laser(10.5, 2.5, 4, 2));
    doors.add(new door(6, 1, 6, 4, 1));
    buttons.add(new button(4.5, 1.5, 1, false));
    doors.add(new door(10, 10, 10, 12, 3));
    triBlocks.add(new triBlock(4, 10, 1, true));
    buttons.add(new button(3.5, 6.5, 3, true));
    for (int i=5; i<10; i++) for (int j=12; j<17; j++) if (j!=14) deathBlocks.add(new deathBlock(j, i));
    endZones.add(new endZone(13, 1, 3, 3));
    lasers.add(new laser(19.5, 7.5, 2, 4));
    triBlocks.add(new triBlock(25, 7, 3, true));

    triDeathBlocks.add(new triDeathBlock(10, 4, 5));
    triDeathBlocks.add(new triDeathBlock(10, 5, 3));

    enemyArrays.add(new enemy(2, 1, 0, 0)); //EnArray0
    enemyArrays.get(0).paths.add(new path(1.25, 8.5, 1));
    enemyArrays.get(0).paths.add(new path(3.75, 8.5, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //EnArray1
    enemyArrays.get(1).paths.add(new path(3.75, 9.5, 1));
    enemyArrays.get(1).paths.add(new path(1.25, 9.5, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //EnArray2
    enemyArrays.get(2).paths.add(new path(12.25, 9.5, 2));
    enemyArrays.get(2).paths.add(new path(16.75, 9.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //EnArray3
    enemyArrays.get(3).paths.add(new path(12.25, 5.5, 2));
    enemyArrays.get(3).paths.add(new path(16.75, 5.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //EnArray4
    enemyArrays.get(4).paths.add(new path(16.75, 7.5, 2));
    enemyArrays.get(4).paths.add(new path(12.25, 7.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //EnArray5
    enemyArrays.get(5).paths.add(new path(18.25, 9.25, 1.5));
    enemyArrays.get(5).paths.add(new path(20.75, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=4;
    enemyArrays.add(new enemy(2, 1, 0, 8)); //EnArray6
    enemyArrays.get(6).paths.add(new path(18.25, 9.75, 1.5));
    enemyArrays.get(6).paths.add(new path(20.75, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=4;
    enemyArrays.add(new enemy(2, 1, 0, 16)); //EnArray7
    enemyArrays.get(7).paths.add(new path(18.25, 10.25, 1.5));
    enemyArrays.get(7).paths.add(new path(20.75, 10.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=4;
    enemyArrays.add(new enemy(2, 1, 0, 24)); //EnArray8
    enemyArrays.get(8).paths.add(new path(18.25, 10.75, 1.5));
    enemyArrays.get(8).paths.add(new path(20.75, 10.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=4;
    enemyArrays.add(new enemy(3, 6, 17.5, 0)); //EnArray9
    enemyArrays.get(9).paths.add(new path(25.5, 5.25, 0));
    enemyArrays.get(9).paths.add(new path(25.5, 2.75, 0));
    for (int i=0; i<6; i++) enemyArrays.get(enemyArrays.size()-1).frequencies[i]=4;
    enemyArrays.add(new enemy(3, 6, 17.5, 0)); //EnArray10
    enemyArrays.get(10).paths.add(new path(25.5, 12.25, 0));
    enemyArrays.get(10).paths.add(new path(25.5, 9.75, 0));
    for (int i=0; i<6; i++) enemyArrays.get(enemyArrays.size()-1).frequencies[i]=4;
    for (float i=18.75; i<20.75; i+=0.5) coins.add(new coin(i, 11.75));
    for (float i=18.75; i<20.75; i+=0.5) coins.add(new coin(i, 12.25));
  }

  void level1() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1)); 
      blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(8, i));
    }
    for (int i=9; i<15; i++) { 
      blocks.add(new block(i, 9)); 
      blocks.add(new block(i, 10)); 
      blocks.add(new block(i, 11));
    }
    blocks.add(new block(15, 9)); 
    blocks.add(new block(16, 9)); 
    for (int i=12; i<17; i++) { 
      blocks.add(new block(i, 6)); 
      blocks.add(new block(i, 7)); 
      blocks.add(new block(i, 8));
    }
    triDeathBlocks.add(new triDeathBlock(17, 6, 7));
    triDeathBlocks.add(new triDeathBlock(17, 7, 1));
    buttons.add(new button(17.5, 5.5, 3, true));
    triggers.add(new trigger(9.5, 4, 3, true));
    doors.add(new door(18, 7, 20, 7, 3));
    lasers.add(new laser(17.5, 10.5, 0, 3));
    triBlocks.add(new triBlock(19, 10, 7, true));
    triBlocks.add(new triBlock(17, 3.5, 3, true));

    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 2, 10, i*5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 6.25+i*0.5, 2));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.75, 6.25+i*0.5, 2));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=3;
      enemyArrays.get(enemyArrays.size()-1).frequencies[1]=3;
    }
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.75, 7.5, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.75, 7.5, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.75, 6.5, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.75, 6.5, 1));

    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 5.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 5.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 3.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 3.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 4.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 2.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 2.5, 1.5));
    endZones.add(new endZone(15, 10, 2, 2));
  }

  void level2() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 2));
      blocks.add(new block(i, 11));
      blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<6; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=6; i<13; i++) {
      blocks.add(new block(i, 5));
    }
    for (int i=16; i<20; i++) {
      blocks.add(new block(i, 3));
      blocks.add(new block(i, 4));
    }
    triBlocks.add(new triBlock(15, 3, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    lasers.add(new laser(12.5, 6.5, 2, 2));
    enemyArrays.add(new enemy(3, 7, 17.5, 0)); //enArray 0
    enemyArrays.get(0).paths.add(new path(13.25, 8.25, 0));
    enemyArrays.get(0).paths.add(new path(13.25, 5.25, 0));
    enemyArrays.add(new enemy(3, 5, 17.5, 0)); //enArray 1
    enemyArrays.get(1).paths.add(new path(13.25, 8.25, 0));
    enemyArrays.get(1).paths.add(new path(11.25, 8.25, 0));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 2
    enemyArrays.get(2).paths.add(new path(10.5, 6.5, 2));
    enemyArrays.get(2).paths.add(new path(10.5, 10.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 3
    enemyArrays.get(3).paths.add(new path(9.5, 10.5, 2));
    enemyArrays.get(3).paths.add(new path(9.5, 6.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 4
    enemyArrays.get(4).paths.add(new path(8.5, 6.5, 2));
    enemyArrays.get(4).paths.add(new path(8.5, 10.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 5
    enemyArrays.get(5).paths.add(new path(7.5, 10.5, 2));
    enemyArrays.get(5).paths.add(new path(7.5, 6.5, 2));
    enemyArrays.add(new enemy(1, 4, 15, 0)); //enArray 6
    enemyArrays.get(6).paths.add(new path(16.5, 5.5, 2));
    enemyArrays.get(6).paths.add(new path(16.5, 10.5, 2));
    enemyArrays.get(6).paths.add(new path(17.5, 10.5, 2));
    enemyArrays.get(6).paths.add(new path(17.5, 5.5, 2));
    enemyArrays.add(new enemy(1, 4, 15, 0)); //enArray 7
    enemyArrays.get(7).paths.add(new path(19.5, 10.5, 2));
    enemyArrays.get(7).paths.add(new path(19.5, 5.5, 2));
    enemyArrays.get(7).paths.add(new path(18.5, 5.5, 2));
    enemyArrays.get(7).paths.add(new path(18.5, 10.5, 2));
    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*8)); //enArray 8-13
      enemyArrays.get(i+8).paths.add(new path(6.5+i*0.5, 4.75, 1));
      enemyArrays.get(i+8).paths.add(new path(6.5+i*0.5, 3.25, 1));
      enemyArrays.get(i+8).frequencies[0] = 2;
    }
    for (int i=0; i<7; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 50-i*8)); //enArray 14-20
      enemyArrays.get(i+14).paths.add(new path(9.5+i*0.5, 4.75, 1));
      enemyArrays.get(i+14).paths.add(new path(9.5+i*0.5, 3.25, 1));
      enemyArrays.get(i+14).frequencies[0] = 2;
    }
    triBlocks.add(new triBlock(20, 8, 1, true));
    endZones.add(new endZone(20, 3, 2, 2));
    coins.add(new coin(11.5, 6.5));
    coins.add(new coin(11.5, 7.5));
    coins.add(new coin(12.5, 7.5));
  }

  void level3() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 10));
      blocks.add(new block(i, 11));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<11; i++) { //vertical edges
      for (int j=0; j<9; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(9, i));
    }
    blocks.add(new block(10, 2));
    blocks.add(new block(11, 2));
    blocks.add(new block(12, 2));
    blocks.add(new block(16, 2));
    blocks.add(new block(17, 2));
    blocks.add(new block(18, 2));
    blocks.add(new block(10, 3));
    blocks.add(new block(11, 3));
    blocks.add(new block(12, 3));
    blocks.add(new block(16, 3));
    blocks.add(new block(17, 3));
    blocks.add(new block(17, 4));
    blocks.add(new block(18, 3));
    blocks.add(new block(18, 4));
    blocks.add(new block(10, 6));
    blocks.add(new block(11, 6));
    blocks.add(new block(10, 9));
    blocks.add(new block(11, 9));
    blocks.add(new block(12, 9));
    blocks.add(new block(16, 9));
    blocks.add(new block(17, 9));
    blocks.add(new block(18, 9));
    radialEnemies.add(new radialEnemy(14.5, 6.5, 2.25, 2, 15, 1, 3, 4, 0, 0, true));
    triBlocks.add(new triBlock(15, 3, 7, true));
    lasers.add(new laser(18.5, 5.5, 4, 1));
    lasers.add(new laser(10.5, 8.5, 2, 4));
    triggers.add(new trigger(14.5, 9.5, 1, true));
    triggers.add(new trigger(13.5, 2.5, 4, true));
    doors.add(new door(12, 7, 12, 9, 1));
    doors.add(new door(12, 4, 12, 6, 4));
    coins.add(new coin(10.5, 7.5));
    coins.add(new coin(11.5, 7.5));
    coins.add(new coin(11.5, 8.5));
    endZones.add(new endZone(10, 4, 2, 2));
  }

  void level4() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1)); 
      blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<9; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, 13-i));
      }
    }

    for (int i=13; i<17; i++) {
      blocks.add(new block(i, 2)); 
      blocks.add(new block(i, 3)); 
      blocks.add(new block(i, 4)); 
      blocks.add(new block(i, 5));
    } 
    blocks.add(new block(13, 8)); 
    blocks.add(new block(14, 8)); 
    blocks.add(new block(15, 8)); 
    blocks.add(new block(16, 8)); 
    blocks.add(new block(16, 7)); 
    blocks.add(new block(16, 6));
    radialEnemies.add(new radialEnemy(11, 7, 2.25, 4, 18, 1.5, 4, 4, PI/4, (5*PI)/4, false));
    radialEnemies.get(0).gaps = new IntList(0, 1, 2, 3, 4, 5, 6, 7);
    enemyArrays.add(new enemy(3, 4, 17.5, 0)); //enArray 0
    enemyArrays.get(0).paths.add(new path(9, 7, 0));
    enemyArrays.get(0).paths.add(new path(11, 7, 0));
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 1-2
      enemyArrays.get(i+1).paths.add(new path(13.5+i*2, 11.75, 1.5));
      enemyArrays.get(i+1).paths.add(new path(13.5+i*2, 9.25, 1.5));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 3-4
      enemyArrays.get(i+3).paths.add(new path(14.5+i*2, 9.25, 1.5));
      enemyArrays.get(i+3).paths.add(new path(14.5+i*2, 11.75, 1.5));
    }
    enemyArrays.add(new enemy(1, 3, 17.5, 0)); //enArray 5
    enemyArrays.get(5).paths.add(new path(17.25, 8.75, 1));
    enemyArrays.get(5).paths.add(new path(18.75, 8.75, 1));
    enemyArrays.get(5).paths.add(new path(18.75, 7.25, 1));
    enemyArrays.get(5).paths.add(new path(17.25, 7.25, 1));
    enemyArrays.add(new enemy(1, 3, 17.5, 0)); //enArray 6
    enemyArrays.get(6).paths.add(new path(18.75, 6.75, 1));
    enemyArrays.get(6).paths.add(new path(17.25, 6.75, 1));
    enemyArrays.get(6).paths.add(new path(17.25, 5.25, 1));
    enemyArrays.get(6).paths.add(new path(18.75, 5.25, 1));
    triBlocks.add(new triBlock(17, 10, 5, true));
    triggers.add(new trigger(15, 7, 3, false));
    lasers.add(new laser(11, 3, 4, 3));
    doors.add(new door(17, 9, 19, 9, 3));
    coins.add(new coin(12, 2.5));
    coins.add(new coin(12, 3.5));
    coins.add(new coin(12.5, 2.5));
    coins.add(new coin(12.5, 3.5));
    coins.add(new coin(10, 2.5));
    coins.add(new coin(10, 3.5));
    coins.add(new coin(9.5, 2.5));
    coins.add(new coin(9.5, 3.5));
    endZones.add(new endZone(17, 2, 2, 2));
  }

  void level5() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1));
      if (i!=8 && i!=9) blocks.add(new block(i, 11)); 
      if (i!=8 && i!=9) blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<11; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(19, i));
    }

    for (int i=0; i<5; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*8)); //enArray 0-4
      enemyArrays.get(i).paths.add(new path(11+i*0.5, 10.75, 1));
      enemyArrays.get(i).paths.add(new path(11+i*0.5, 9.25, 1));
      enemyArrays.get(i).frequencies[0] = 2;
    }
    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 42-i*8)); //enArray 5-10
      enemyArrays.get(i+5).paths.add(new path(13.5+i*0.5, 10.75, 1));
      enemyArrays.get(i+5).paths.add(new path(13.5+i*0.5, 9.25, 1));
      enemyArrays.get(i+5).frequencies[0] = 2;
    }
    for (int i=0; i<5; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*8)); //enArray 11-15
      enemyArrays.get(i+11).paths.add(new path(11+i*0.5, 2.25, 1));
      enemyArrays.get(i+11).paths.add(new path(11+i*0.5, 3.75, 1));
    }
    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 42-i*8)); //enArray 16-21
      enemyArrays.get(i+16).paths.add(new path(13.5+i*0.5, 2.25, 1));
      enemyArrays.get(i+16).paths.add(new path(13.5+i*0.5, 3.75, 1));
    }

    for (int i=0; i<3; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 22-24
      enemyArrays.get(i+22).paths.add(new path(16.25, 4.5+i*2, 1.5));
      enemyArrays.get(i+22).paths.add(new path(18.75, 4.5+i*2, 1.5));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 25-26
      enemyArrays.get(i+25).paths.add(new path(18.75, 5.5+i*2, 1.5));
      enemyArrays.get(i+25).paths.add(new path(16.25, 5.5+i*2, 1.5));
    }
    for (int i=0; i<12; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*5.5)); //enArray 27-39
      enemyArrays.get(i+27).paths.add(new path(8.25, 4.25+i*0.25, 1.25));
      enemyArrays.get(i+27).paths.add(new path(10.75, 4.25+i*0.25, 1.25));
      enemyArrays.get(i+27).frequencies[0] = 4;
    }
    for (int i=0; i<7; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*5.5)); //enArray 40-48
      enemyArrays.get(i+39).paths.add(new path(10.75, 7.25+i*0.25, 1.25));
      enemyArrays.get(i+39).paths.add(new path(8.25, 7.25+i*0.25, 1.25));
      enemyArrays.get(i+39).frequencies[0] = 4;
    }
    radialEnemies.add(new radialEnemy(13.5, 6.5, 2.75, 5, 20, 1.5, 3, 4, 0, 0, true));
    triBlocks.add(new triBlock(8, 9, 7, true));
    lasers.add(new laser(18.5, 10.5, 3, 2));
    lasers.add(new laser(18.5, 2.5, 6, 4));
    endZones.add(new endZone(8, 11, 2, 2));
  }

  void level6() {
    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 13));
    }
    for (int i=1; i<13; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(19, i));
    }
    for (int i=1; i<13; i++) {
      if (i!=4 && i!=6 && i!=8) {
        blocks.add(new block(8, i)); 
        blocks.add(new block(9, i));
      }
    }
    for (int i=13; i<16; i++) {
      if (i!=4 && i!=6 && i!=8) {
        blocks.add(new block(i, 2)); 
        blocks.add(new block(i, 3));
        blocks.add(new block(i, 5)); 
        blocks.add(new block(i, 7));
        blocks.add(new block(i, 9));
      }
    }
    for (int i=13; i<19; i++) {
      blocks.add(new block(i, 12));
    }
    blocks.add(new block(15, 4)); 
    blocks.add(new block(15, 6)); 
    blocks.add(new block(15, 8));
    blocks.add(new block(13, 10)); 
    blocks.add(new block(13, 11)); 

    for (int i=0; i<4; i++) {
      enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray 0-3
      if (i%2==0) {
        enemyArrays.get(i).paths.add(new path(10.25, 3.5+i*2, 1.5));
        enemyArrays.get(i).paths.add(new path(12.75, 3.5+i*2, 1.5));
      } else {
        enemyArrays.get(i).paths.add(new path(12.75, 3.5+i*2, 1.5));
        enemyArrays.get(i).paths.add(new path(10.25, 3.5+i*2, 1.5));
      }
    }
    for (int i=0; i<3; i++) {
      radialEnemies.add(new radialEnemy(17.5, 4.5+i*3, 1.5, 3, 20, 1.5, 3, 3, 0, 0, i%2==0));
    }
    doors.add(new door(13, 2, 13, 1, 4));
    for (int i=0; i<3; i++) {
      doors.add(new door(13, 5+i*2, 13, 4+i*2, 4));
    }
    for (int i=0; i<3; i++) {
      triggers.add(new trigger(8.5, 4.5+i*2, 4, false));
    }
    for (int i=0; i<3; i++) {
      coins.add(new coin(14.5, 4.5+i*2));
    }
    lasers.add(new laser(10.5, 1.5, 4, 4));
    triBlocks.add(new triBlock(10, 10, 3, true));
    endZones.add(new endZone(14, 10, 2, 2));
  }

  void level7() { 

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }

    for (int i=11; i<17; i++) { 
      blocks.add(new block(i, 2)); 
      blocks.add(new block(i, 3));
    }
    for (int i=8; i<12; i++) { 
      blocks.add(new block(8, i)); 
      blocks.add(new block(9, i));
      blocks.add(new block(10, i));
    }
    blocks.add(new block(17, 8)); 
    blocks.add(new block(18, 8));
    blocks.add(new block(19, 8));

    triDeathBlocks.add(new triDeathBlock(16, 8, 3));
    triDeathBlocks.add(new triDeathBlock(15, 7, 3));
    triDeathBlocks.add(new triDeathBlock(16, 7, 7));
    triDeathBlocks.add(new triDeathBlock(11, 8, 1));
    triDeathBlocks.add(new triDeathBlock(12, 7, 1));
    triDeathBlocks.add(new triDeathBlock(11, 7, 5));

    lasers.add(new laser(19.5, 2.5, 4, 2));
    triggers.add(new trigger(8.5, 2.5, 2, true));
    buttons.add(new button(14, 11, 1, true));
    doors.add(new door(18, 9, 18, 12, 2));
    doors.add(new door(17, 4, 17, 8, 1));
    doors.add(new door(11, 4, 11, 8, 1));
    triBlocks.add(new triBlock(15.5, 4.5, 7, true));
    triBlocks.add(new triBlock(11.5, 4.5, 5, true));

    radialEnemies.add(new radialEnemy(12.5, 9.25, 1.25, 3, 15, 2, 3, 3, 0, 0, false));
    radialEnemies.add(new radialEnemy(15.5, 9.25, 1.25, 3, 15, 2, 3, 3, 0, 0, false));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 11.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 11.75, 1.5));

    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25, 11.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 11.75, 1.5));

    for (int i=0; i<3; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.25, 4.5+i*1.5, 1.5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.75, 4.5+i*1.5, 1.5));
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.75, 4.5+i*1.5, 1.5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(8.25, 4.5+i*1.5, 1.5));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.75, 5.25+i*1.5, 1.5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.25, 5.25+i*1.5, 1.5));
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(8.25, 5.25+i*1.5, 1.5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.75, 5.25+i*1.5, 1.5));
    }

    coins.add(new coin(18.5, 9.5));
    coins.add(new coin(19.5, 9.5));
    coins.add(new coin(18.5, 10.5));
    coins.add(new coin(19.5, 10.5));
    coins.add(new coin(18.5, 11.5));
    coins.add(new coin(19.5, 11.5));
    endZones.add(new endZone(13, 4, 2, 2));
  }

  void level8() {
    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1)); 
      blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(19, i));
    }

    for (int i=9; i<12; i++) {
      blocks.add(new block(8, i)); 
      blocks.add(new block(18, i));
    }
    for (int i=2; i<5; i++) {
      blocks.add(new block(8, i)); 
      blocks.add(new block(9, i)); 
      blocks.add(new block(10, i)); 
      blocks.add(new block(16, i)); 
      blocks.add(new block(17, i)); 
      blocks.add(new block(18, i));
    }
    blocks.add(new block(9, 9)); 
    blocks.get(blocks.size()-1).edges[0].mirror=true;
    blocks.add(new block(10, 9)); 
    blocks.get(blocks.size()-1).edges[0].mirror=true;
    blocks.add(new block(16, 9)); 
    blocks.get(blocks.size()-1).edges[0].mirror=true;
    blocks.add(new block(17, 9)); 
    blocks.get(blocks.size()-1).edges[0].mirror=true;
    blocks.add(new block(9, 10)); 
    blocks.add(new block(16, 10)); 
    blocks.add(new block(17, 10)); 
    blocks.add(new block(16, 11)); 
    blocks.add(new block(17, 11)); 
    blocks.add(new block(10, 10)); 
    blocks.add(new block(9, 11)); 
    blocks.add(new block(10, 11)); 
    blocks.add(new block(8, 5));
    blocks.add(new block(9, 5));
    blocks.add(new block(10, 5));
    blocks.add(new block(10, 6));
    blocks.add(new block(10, 7));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    blocks.add(new block(9, 7));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    blocks.add(new block(16, 5));
    blocks.add(new block(16, 6));
    blocks.add(new block(16, 7));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    blocks.add(new block(17, 7));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    triBlocks.add(new triBlock(14.25, 2.5, 7, true));
    doors.add(new door(11, 10, 16, 10, 1));
    buttons.add(new button(12, 3, 1, true));
    enemyArrays.add(new enemy(3, 10, 17.5, 0)); //enArray 0
    enemyArrays.get(0).paths.add(new path(14, 2.25, 0));
    enemyArrays.get(0).paths.add(new path(14, 7.75, 0));
    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*7.5)); //enArray 1-6
      enemyArrays.get(i+1).paths.add(new path(11.25, 4.25+i*0.5, 1));
      enemyArrays.get(i+1).paths.add(new path(13.75, 4.25+i*0.5, 1));
    }
    enemyArrays.add(new enemy(1, 5, 8.75, 0)); //enArray 7
    enemyArrays.get(7).paths.add(new path(14.5, 4.25, 2));
    enemyArrays.get(7).paths.add(new path(14.5, 6.75, 2));
    enemyArrays.get(7).paths.add(new path(15.75, 6.75, 2));
    enemyArrays.get(7).paths.add(new path(15.75, 4.25, 2));
    enemyArrays.add(new enemy(3, 2, 17.5, 0)); //enArray 8
    enemyArrays.get(8).paths.add(new path(10.25, 8.25, 0));
    enemyArrays.get(8).paths.add(new path(10.75, 8.25, 0));
    for (int i=0; i<2; i++) enemyArrays.get(8).frequencies[i] = 2;
    enemyArrays.add(new enemy(3, 2, 17.5, 0)); //enArray 9
    enemyArrays.get(9).paths.add(new path(9.25, 8.75, 0));
    enemyArrays.get(9).paths.add(new path(9.75, 8.75, 0));
    for (int i=0; i<2; i++) enemyArrays.get(9).frequencies[i] = 2;
    enemyArrays.add(new enemy(2, 4, 8.75, 0)); //enArray 10
    enemyArrays.get(10).paths.add(new path(11.25, 9.5, 2));
    enemyArrays.get(10).paths.add(new path(15.75, 9.5, 2));

    enemyArrays.add(new enemy(3, 2, 17.5, 0)); //enArray 11
    enemyArrays.get(11).paths.add(new path(16.25, 8.25, 0));
    enemyArrays.get(11).paths.add(new path(16.75, 8.25, 0));
    for (int i=0; i<2; i++) enemyArrays.get(11).frequencies[i] = 2;
    enemyArrays.add(new enemy(3, 2, 17.5, 0)); //enArray 12
    enemyArrays.get(12).paths.add(new path(17.25, 8.75, 0));
    enemyArrays.get(12).paths.add(new path(17.75, 8.75, 0));
    for (int i=0; i<2; i++) enemyArrays.get(12).frequencies[i] = 2;

    lasers.add(new laser(13.5, 11, 0, 2));
    coins.add(new coin(8.5, 6.5));
    coins.add(new coin(9.5, 6.5));
    coins.add(new coin(8.5, 7.5));
    endZones.add(new endZone(17, 5, 2, 2));
  }

  void level9() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1)); 
      blocks.add(new block(i, 11)); 
      blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    blocks.add(new block(8, 2));
    blocks.add(new block(8, 3));
    for (int i=11; i<20; i++) {
      blocks.add(new block(i, 2));
      blocks.add(new block(i, 3));
    }
    for (int i=11; i<18; i++) {
      if (i!=14)blocks.add(new block(i, 6));
      if (i!=14)blocks.add(new block(i, 7));
    }
    blocks.add(new block(17, 4));
    blocks.add(new block(17, 5));
    triBlocks.add(new triBlock(10, 6, 5, false));
    triBlocks.add(new triBlock(10, 7, 3, false));
    triBlocks.add(new triBlock(8, 4, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    lasers.add(new laser(16.5, 4.5, 6, 1));
    buttons.add(new button(8.5, 10.5, 1, true));
    doors.add(new door(8, 7, 10, 7, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray0
    enemyArrays.get(0).paths.add(new path(15.5, 4.5, 2)); 
    enemyArrays.get(0).paths.add(new path(9.5, 4.5, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray1
    enemyArrays.get(1).paths.add(new path(9.5, 5.5, 2)); 
    enemyArrays.get(1).paths.add(new path(15.5, 5.5, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray2
    enemyArrays.get(2).paths.add(new path(12.25, 4.25, 1)); 
    enemyArrays.get(2).paths.add(new path(12.25, 5.75, 1));
    enemyArrays.get(2).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray3
    enemyArrays.get(3).paths.add(new path(12.75, 4.25, 1)); 
    enemyArrays.get(3).paths.add(new path(12.75, 5.75, 1));
    enemyArrays.get(3).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray4
    enemyArrays.get(4).paths.add(new path(14.25, 4.25, 1)); 
    enemyArrays.get(4).paths.add(new path(14.25, 5.75, 1));
    enemyArrays.get(4).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray5
    enemyArrays.get(5).paths.add(new path(14.75, 4.25, 1)); 
    enemyArrays.get(5).paths.add(new path(14.75, 5.75, 1));
    enemyArrays.get(5).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray6
    enemyArrays.get(6).paths.add(new path(11.5, 8.5, 2)); 
    enemyArrays.get(6).paths.add(new path(17.5, 8.5, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray7
    enemyArrays.get(7).paths.add(new path(17.5, 10.5, 2)); 
    enemyArrays.get(7).paths.add(new path(11.5, 10.5, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray8
    enemyArrays.get(8).paths.add(new path(11.5, 8.25, 1)); 
    enemyArrays.get(8).paths.add(new path(11.5, 10.75, 1));
    enemyArrays.get(8).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray9
    enemyArrays.get(9).paths.add(new path(12, 8.25, 1)); 
    enemyArrays.get(9).paths.add(new path(12, 10.75, 1));
    enemyArrays.get(9).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray10
    enemyArrays.get(10).paths.add(new path(12.5, 8.25, 1)); 
    enemyArrays.get(10).paths.add(new path(12.5, 10.75, 1));
    enemyArrays.get(10).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray11
    enemyArrays.get(11).paths.add(new path(16.5, 8.25, 1)); 
    enemyArrays.get(11).paths.add(new path(16.5, 10.75, 1));
    enemyArrays.get(11).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray12
    enemyArrays.get(12).paths.add(new path(17, 8.25, 1)); 
    enemyArrays.get(12).paths.add(new path(17, 10.75, 1));
    enemyArrays.get(12).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray13
    enemyArrays.get(13).paths.add(new path(17.5, 8.25, 1)); 
    enemyArrays.get(13).paths.add(new path(17.5, 10.75, 1));
    enemyArrays.get(13).frequencies[0]=1;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray14
    enemyArrays.get(14).paths.add(new path(18.5, 6.25, 2)); 
    enemyArrays.get(14).paths.add(new path(18.5, 10.75, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray15
    enemyArrays.get(15).paths.add(new path(19.5, 10.75, 2)); 
    enemyArrays.get(15).paths.add(new path(19.5, 6.25, 2));
    triBlocks.add(new triBlock(14, 9, 7, true));
    coins.add(new coin(8.5, 7.5));
    coins.add(new coin(9.5, 7.5));
    endZones.add(new endZone(18, 4, 2, 2));
  }

  void level10() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0)); 
      blocks.add(new block(i, 1)); 
      blocks.add(new block(i, 2)); 
      blocks.add(new block(i, 10)); 
      blocks.add(new block(i, 11)); 
      blocks.add(new block(i, 12)); 
      blocks.add(new block(i, 13));
    }
    for (int i=3; i<10; i++) { //vertical edges
      for (int j=0; j<7; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=3; i<10; i++) { 
      if (i!=6)blocks.add(new block(9, i));
    }
    blocks.add(new block(7, 3)); 
    blocks.add(new block(8, 3)); 
    blocks.add(new block(7, 4)); 
    blocks.add(new block(8, 4));
    blocks.add(new block(7, 8)); 
    blocks.add(new block(8, 8)); 
    blocks.add(new block(7, 9)); 
    blocks.add(new block(8, 9)); 
    for (int i=0; i<5; i++) {
      enemyArrays.add(new enemy(1, 1, 0, 0)); //EnArray 0-4
      enemyArrays.get(i).paths.add(new path(10.5+i*2, 8.75, 2));
      enemyArrays.get(i).paths.add(new path(10.5+i*2, 3.25, 2));
      enemyArrays.get(i).frequencies[0]=3;
    }
    for (int i=0; i<5; i++) {
      enemyArrays.add(new enemy(1, 1, 0, 0)); //EnArray 5-9
      enemyArrays.get(i+5).paths.add(new path(11.5+i*2, 4.25, 2));
      enemyArrays.get(i+5).paths.add(new path(11.5+i*2, 9.75, 2));
      enemyArrays.get(i+5).frequencies[0]=3;
    }
    for (int i=0; i<3; i++) {
      enemyArrays.add(new enemy(1, 1, 0, 0)); //EnArray 10-12
      enemyArrays.get(i+10).paths.add(new path(10.25, 3.5+i*0.5, 1.5));
      enemyArrays.get(i+10).paths.add(new path(19.5, 3.5+i*0.5, 1.5));
    }
    for (int i=0; i<3; i++) {
      enemyArrays.add(new enemy(1, 1, 0, 0)); //EnArray 13-15
      enemyArrays.get(i+13).paths.add(new path(19.5, 8.5+i*0.5, 1.5));
      enemyArrays.get(i+13).paths.add(new path(10.25, 8.5+i*0.5, 1.5));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(1, 1, 0, 0)); //EnArray 16-17
      enemyArrays.get(i+16).paths.add(new path(20.25+i*0.5, 5.25, 2));
      enemyArrays.get(i+16).paths.add(new path(20.25+i*0.5, 7.75, 2));
    }

    lasers.add(new laser(20.5, 9.5, 6, 3));
    lasers.add(new laser(20.5, 3.5, 6, 3));
    endZones.add(new endZone(7, 5, 2, 3));
    for (int i=0; i<6; i++) {
      coins.add(new coin(14.25+i*0.5, 6.25));
      coins.add(new coin(14.25+i*0.5, 6.75));
    }
  }

  void level11() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 13));
    }
    for (int i=0; i<13; i++) { //vertical edges
      for (int j=0; j<7; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(20, i));
    }
    for (int i=0; i<13; i++) {
      if (i!=9 && i!=10) {
        blocks.add(new block(7, i));
        blocks.add(new block(8, i));
        blocks.add(new block(18, i));
        blocks.add(new block(19, i));
      }
    }
    for (int i=9; i<18; i++) {
      if (i<11 || i>15) {
        blocks.add(new block(i, 0));
        blocks.add(new block(i, 1));
        blocks.add(new block(i, 11));
        blocks.add(new block(i, 12));
      }
    }
    blocks.add(new block(15, 0));
    blocks.add(new block(15, 1));
    blocks.add(new block(11, 0));
    blocks.add(new block(11, 1));
    blocks.add(new block(11, 11));
    blocks.add(new block(11, 12));
    blocks.add(new block(15, 11));
    blocks.add(new block(15, 12));
    for (int i=11; i<16; i++) { 
      for (int j=4; j<9; j++) {
        deathBlocks.add(new deathBlock(i, j));
      }
    }
    enemyArrays.add(new enemy(1, 4, 15, 0)); //enArray 0
    enemyArrays.get(0).paths.add(new path(17.75, 9.25, 1.5));
    enemyArrays.get(0).paths.add(new path(14.25, 9.25, 1.5));
    enemyArrays.get(0).paths.add(new path(14.25, 10.75, 1.5));
    enemyArrays.get(0).paths.add(new path(17.75, 10.75, 1.5));
    enemyArrays.add(new enemy(1, 4, 15, 0)); //enArray 1
    enemyArrays.get(1).paths.add(new path(9.25, 10.75, 1.5));
    enemyArrays.get(1).paths.add(new path(12.75, 10.75, 1.5));
    enemyArrays.get(1).paths.add(new path(12.75, 9.25, 1.5));
    enemyArrays.get(1).paths.add(new path(9.25, 9.25, 1.5));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 2
    enemyArrays.get(2).paths.add(new path(16.25, 6.5, 1));
    enemyArrays.get(2).paths.add(new path(17.75, 6.5, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 3
    enemyArrays.get(3).paths.add(new path(10.75, 6.5, 1));
    enemyArrays.get(3).paths.add(new path(9.25, 6.5, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 4
    enemyArrays.get(4).paths.add(new path(13.5, 2.25, 1));
    enemyArrays.get(4).paths.add(new path(13.5, 3.75, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 5
    enemyArrays.get(5).paths.add(new path(9.25, 2.5, 2));
    enemyArrays.get(5).paths.add(new path(17.75, 2.5, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 6
    enemyArrays.get(6).paths.add(new path(17.75, 3.5, 2));
    enemyArrays.get(6).paths.add(new path(9.25, 3.5, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 7
    enemyArrays.get(7).paths.add(new path(16.5, 4.25, 2));
    enemyArrays.get(7).paths.add(new path(16.5, 8.75, 2));
    enemyArrays.get(7).frequencies[0]=3;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 8
    enemyArrays.get(8).paths.add(new path(17.5, 8.75, 2));
    enemyArrays.get(8).paths.add(new path(17.5, 4.25, 2));
    enemyArrays.get(8).frequencies[0]=3;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 9
    enemyArrays.get(9).paths.add(new path(10.5, 4.25, 2));
    enemyArrays.get(9).paths.add(new path(10.5, 8.75, 2));
    enemyArrays.get(9).frequencies[0]=3;
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 10
    enemyArrays.get(10).paths.add(new path(9.5, 8.75, 2));
    enemyArrays.get(10).paths.add(new path(9.5, 4.25, 2));
    enemyArrays.get(10).frequencies[0]=3;
    lasers.add(new laser(13.5, 1, 4, 3));
    triBlocks.add(new triBlock(18.5, 9.5, 7, true));
    triBlocks.add(new triBlock(7.5, 9.5, 5, true));
    endZones.add(new endZone(12, 11, 3, 2));
  }

  void level12() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=0; i<13; i++) { //vertical edges
      for (int j=0; j<7; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=4; i<10; i++) blocks.add(new block(10, i));
    for (int i=6; i<10; i++) { 
      blocks.add(new block(16, i));
      blocks.add(new block(17, i));
    }
    blocks.add(new block(17, 4));
    blocks.add(new block(17, 5));
    blocks.add(new block(15, 6));
    blocks.add(new block(14, 6));
    blocks.add(new block(14, 5));
    blocks.add(new block(14, 4));
    blocks.add(new block(11, 9));
    triBlocks.add(new triBlock(11, 8, 7, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(12, 9, 7, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    for (int i=4; i<12; i++) { 
      if (i!=8) {
        deathBlocks.add(new deathBlock(7, i));
        deathBlocks.add(new deathBlock(8, i));
        deathBlocks.add(new deathBlock(9, i));
      }
    }
    deathBlocks.add(new deathBlock(7, 8));
    deathBlocks.add(new deathBlock(9, 8));
    for (int i=0; i<5; i++) {
      enemyArrays.add(new enemy(2, 2, 10, 0+i*5)); //enArray 0-4
      enemyArrays.get(i).paths.add(new path(18.25, 9-i*0.5, 2));
      enemyArrays.get(i).paths.add(new path(20.75, 9-i*0.5, 2));
      enemyArrays.get(i).frequencies[0]=2;
      enemyArrays.get(i).frequencies[1]=2;
    }
    for (int i=0; i<4; i++) {
      enemyArrays.add(new enemy(2, 2, 10, 15-i*5)); //enArray 5-8
      enemyArrays.get(i+5).paths.add(new path(18.25, 6.5-i*0.5, 2));
      enemyArrays.get(i+5).paths.add(new path(20.75, 6.5-i*0.5, 2));
      enemyArrays.get(i+5).frequencies[0]=2;
      enemyArrays.get(i+5).frequencies[1]=2;
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 9-10
      enemyArrays.get(i+9).paths.add(new path(16.25+i*0.5, 10.25, 0.75));
      enemyArrays.get(i+9).paths.add(new path(16.25+i*0.5, 11.75, 0.75));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 11-12
      enemyArrays.get(i+11).paths.add(new path(17.25+i*0.5, 11.75, 0.75));
      enemyArrays.get(i+11).paths.add(new path(17.25+i*0.5, 10.25, 0.75));
    }
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 13
    enemyArrays.get(13).paths.add(new path(14.25, 3.75, 1.5));
    enemyArrays.get(13).paths.add(new path(17.75, 1.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 14
    enemyArrays.get(14).paths.add(new path(17.75, 3.75, 1.5));
    enemyArrays.get(14).paths.add(new path(14.25, 1.25, 1.5));
    enemyArrays.add(new enemy(1, 5, 12, 0)); //enArray 15 ***
    enemyArrays.get(15).paths.add(new path(17.75, 3.75, 1.25));
    enemyArrays.get(15).paths.add(new path(17.75, 1.25, 1.25));
    enemyArrays.get(15).paths.add(new path(14.25, 1.25, 1.25));
    enemyArrays.get(15).paths.add(new path(14.25, 3.75, 1.25));
    enemyArrays.add(new enemy(1, 5, 7, 5)); //enArray 16
    enemyArrays.get(16).paths.add(new path(7.25, 3.75, 2.25));
    enemyArrays.get(16).paths.add(new path(10.75, 3.75, 2.25));
    enemyArrays.get(16).paths.add(new path(10.75, 1.25, 2.25));
    enemyArrays.get(16).paths.add(new path(7.25, 1.25, 2.25));
    for (int i=0; i<3; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*20)); //enArray 17-19
      enemyArrays.get(i+17).paths.add(new path(7.5+i, 9.25, 1));
      enemyArrays.get(i+17).paths.add(new path(7.5+i, 11.75, 1));
      enemyArrays.get(i+17).frequencies[0]=2;
    }
    enemyArrays.add(new enemy(1, 5, 10, 0)); //enArray 20
    enemyArrays.get(20).paths.add(new path(7.75, 1.75, 1.5));
    enemyArrays.get(20).paths.add(new path(10.25, 1.75, 1.5));
    enemyArrays.get(20).paths.add(new path(10.25, 3.25, 1.5));
    enemyArrays.get(20).paths.add(new path(7.75, 3.25, 1.5));

    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 21-22
      enemyArrays.get(i+21).paths.add(new path(11.25, 4.25+i*0.5, 1.25));
      enemyArrays.get(i+21).paths.add(new path(13.75, 4.25+i*0.5, 1.25));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 23-24
      enemyArrays.get(i+23).paths.add(new path(13.75, 5.25+i*0.5, 1.25));
      enemyArrays.get(i+23).paths.add(new path(11.25, 5.25+i*0.5, 1.25));
    }

    triggers.add(new trigger(8.5, 8.5, 2, false));
    lasers.add(new laser(15, 9, 0, 2));
    doors.add(new door(13, 10, 13, 12, 2));
    for (int i=0; i<3; i++) {
      coins.add(new coin(10.5+i, 10.5));
      coins.add(new coin(10.5+i, 11.5));
    }
    triBlocks.add(new triBlock(19, 10, 7, true));
    triBlocks.add(new triBlock(19, 2, 3, true));
    endZones.add(new endZone(15, 4, 2, 2));
  }

  void level13() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=0; i<13; i++) { //vertical edges
      for (int j=0; j<6; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(21, i));
    }

    for (int i=11; i<16; i++) {
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 11));
    }
    for (int i=2; i<11; i++) {
      blocks.add(new block(20, i));
      blocks.get(blocks.size()-1).edges[3].mirror=true;
    }
    for (int i=2; i<11; i++) {
      blocks.add(new block(6, i));
      blocks.get(blocks.size()-1).edges[1].mirror=true;
    }
    blocks.add(new block(20, 11));
    blocks.add(new block(20, 1));
    blocks.add(new block(6, 11));
    blocks.add(new block(6, 1));
    blocks.add(new block(12, 2));
    blocks.add(new block(13, 2));
    blocks.add(new block(14, 2));
    blocks.add(new block(12, 10));
    blocks.add(new block(13, 10));
    blocks.add(new block(14, 10));
    blocks.add(new block(13, 3));
    blocks.add(new block(13, 9));
    blocks.add(new block(17, 5));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(17, 6));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(17, 7));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(9, 5));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(9, 6));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(9, 7));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(16, 6));
    blocks.add(new block(10, 6));
    triBlocks.add(new triBlock(16, 5, 5, false));
    triBlocks.add(new triBlock(17, 4, 5, false));
    triBlocks.get(triBlocks.size()-1).edges[2].mirror=true;
    triBlocks.add(new triBlock(16, 7, 3, false));
    triBlocks.add(new triBlock(17, 8, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[0].mirror=true;
    triBlocks.add(new triBlock(9, 4, 7, false));
    triBlocks.get(triBlocks.size()-1).edges[0].mirror=true;
    triBlocks.add(new triBlock(10, 5, 7, false));
    triBlocks.add(new triBlock(9, 8, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[2].mirror=true;
    triBlocks.add(new triBlock(10, 7, 1, false));
    triBlocks.add(new triBlock(16, 1, 1, false));
    triBlocks.add(new triBlock(15, 2, 1, false));
    triBlocks.add(new triBlock(14, 3, 1, false));
    triBlocks.add(new triBlock(10, 1, 3, false));
    triBlocks.add(new triBlock(11, 2, 3, false));
    triBlocks.add(new triBlock(12, 3, 3, false));
    triBlocks.add(new triBlock(10, 11, 5, false));
    triBlocks.add(new triBlock(11, 10, 5, false));
    triBlocks.add(new triBlock(12, 9, 5, false));
    triBlocks.add(new triBlock(16, 11, 7, false));
    triBlocks.add(new triBlock(15, 10, 7, false));
    triBlocks.add(new triBlock(14, 9, 7, false));
    triBlocks.add(new triBlock(19, 1, 3, false));
    triBlocks.add(new triBlock(19, 11, 5, false));
    triBlocks.add(new triBlock(7, 11, 7, false));
    triBlocks.add(new triBlock(7, 1, 1, false));
    deathBlocks.add(new deathBlock(13, 8));
    deathBlocks.add(new deathBlock(13, 4));
    deathBlocks.add(new deathBlock(15, 6));
    deathBlocks.add(new deathBlock(11, 6));
    enemyArrays.add(new enemy(1, 3, 10, 0)); //enArray 0
    enemyArrays.get(0).paths.add(new path(16.25, 7.75, 1.5));
    enemyArrays.get(0).paths.add(new path(14.75, 9.25, 1.5));
    enemyArrays.get(0).paths.add(new path(16.25, 10.75, 1.5));
    enemyArrays.get(0).paths.add(new path(17.75, 9.25, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0)); //enArray 1
    enemyArrays.get(1).paths.add(new path(16.25, 5.25, 1.5));
    enemyArrays.get(1).paths.add(new path(14.75, 3.75, 1.5));
    enemyArrays.get(1).paths.add(new path(16.25, 2.25, 1.5));
    enemyArrays.get(1).paths.add(new path(17.75, 3.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 2
    enemyArrays.get(2).paths.add(new path(16.25, 7.75, 1.5));
    enemyArrays.get(2).paths.add(new path(16.25, 10.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 3
    enemyArrays.get(3).paths.add(new path(14.75, 9.25, 1.5));
    enemyArrays.get(3).paths.add(new path(17.75, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 4
    enemyArrays.get(4).paths.add(new path(16.25, 5.25, 1.5));
    enemyArrays.get(4).paths.add(new path(16.25, 2.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 5
    enemyArrays.get(5).paths.add(new path(14.75, 3.75, 1.5));
    enemyArrays.get(5).paths.add(new path(17.75, 3.75, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0)); //enArray 6
    enemyArrays.get(6).paths.add(new path(11.75, 4.75, 1.5));
    enemyArrays.get(6).paths.add(new path(11.75, 3.25, 1.5));
    enemyArrays.get(6).paths.add(new path(10.25, 3.25, 1.5));
    enemyArrays.get(6).paths.add(new path(10.25, 4.75, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0)); //enArray 7
    enemyArrays.get(7).paths.add(new path(10.75, 3.75, 1.5));
    enemyArrays.get(7).paths.add(new path(10.75, 2.25, 1.5));
    enemyArrays.get(7).paths.add(new path(9.25, 2.25, 1.5));
    enemyArrays.get(7).paths.add(new path(9.25, 3.75, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0)); //enArray 8
    enemyArrays.get(8).paths.add(new path(11.75, 8.25, 1.5));
    enemyArrays.get(8).paths.add(new path(11.75, 9.75, 1.5));
    enemyArrays.get(8).paths.add(new path(10.25, 9.75, 1.5));
    enemyArrays.get(8).paths.add(new path(10.25, 8.25, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0)); //enArray 9
    enemyArrays.get(9).paths.add(new path(10.75, 9.25, 1.5));
    enemyArrays.get(9).paths.add(new path(10.75, 10.75, 1.5));
    enemyArrays.get(9).paths.add(new path(9.25, 10.75, 1.5));
    enemyArrays.get(9).paths.add(new path(9.25, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 10
    enemyArrays.get(10).paths.add(new path(11.0, 5.5, 2));
    enemyArrays.get(10).paths.add(new path(11.0, 2.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 11
    enemyArrays.get(11).paths.add(new path(10.0, 4.5, 2));
    enemyArrays.get(11).paths.add(new path(10.0, 1.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 12
    enemyArrays.get(12).paths.add(new path(11.0, 10.5, 2));
    enemyArrays.get(12).paths.add(new path(11.0, 7.5, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray 13
    enemyArrays.get(13).paths.add(new path(10.0, 11.5, 2));
    enemyArrays.get(13).paths.add(new path(10.0, 8.5, 2));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray 14
    enemyArrays.get(14).paths.add(new path(18.25, 4.25, 2));
    enemyArrays.get(14).paths.add(new path(19.75, 5.75, 2));
    enemyArrays.get(14).paths.add(new path(18.25, 7.25, 2));
    enemyArrays.get(14).paths.add(new path(19.75, 8.75, 2));
    enemyArrays.get(14).frequencies[0]=1;
    enemyArrays.get(14).frequencies[1]=1;
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray 15
    enemyArrays.get(15).paths.add(new path(19.75, 4.25, 2));
    enemyArrays.get(15).paths.add(new path(18.25, 5.75, 2));
    enemyArrays.get(15).paths.add(new path(19.75, 7.25, 2));
    enemyArrays.get(15).paths.add(new path(18.25, 8.75, 2));
    enemyArrays.get(15).frequencies[0]=1;
    enemyArrays.get(15).frequencies[1]=1;
    enemyArrays.add(new enemy(1, 6, 7, 0)); //enArray 16
    enemyArrays.get(16).paths.add(new path(7.25, 4.25, 2.25));
    enemyArrays.get(16).paths.add(new path(7.25, 8.75, 2.25));
    enemyArrays.get(16).paths.add(new path(8.75, 8.75, 2.25));
    enemyArrays.get(16).paths.add(new path(8.75, 4.25, 2.25));
    for (int i=0; i<6; i++) enemyArrays.get(16).frequencies[i]=1;
    enemyArrays.add(new enemy(1, 4, 10, 0)); //enArray 17
    enemyArrays.get(17).paths.add(new path(7.75, 8.25, 1.5));
    enemyArrays.get(17).paths.add(new path(7.75, 4.75, 1.5));
    enemyArrays.get(17).paths.add(new path(8.25, 4.75, 1.5));
    enemyArrays.get(17).paths.add(new path(8.25, 8.25, 1.5));
    for (int i=0; i<4; i++) enemyArrays.get(17).frequencies[i]=1;
    triBlocks.add(new triBlock(7.75, 6, 0, true));
    lasers.add(new laser(18, 11, 0, 1));
    lasers.add(new laser(18, 2, 4, 1));
    coins.add(new coin(18.5, 5.5));
    coins.add(new coin(19.5, 5.5));
    coins.add(new coin(18.5, 6.5));
    coins.add(new coin(19.5, 6.5));
    coins.add(new coin(18.5, 7.5));
    coins.add(new coin(19.5, 7.5));
    endZones.add(new endZone(12, 5, 3, 3));
  }

  void level14() {

    for (int i=0; i<28; i++) { //horizontal edges
      if (i!=15 && i!=16 && i!=17)blocks.add(new block(i, 0));
    }
    for (int i=0; i<14; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    blocks.add(new block(15, 0));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    blocks.add(new block(16, 0));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    blocks.add(new block(17, 0));
    blocks.get(blocks.size()-1).edges[2].mirror=true;
    for (int i=5; i<14; i++) { 
      blocks.add(new block(8, i));
      blocks.add(new block(9, i));
      blocks.add(new block(18, i));
      blocks.add(new block(19, i));
    }
    for (int i=3; i<12; i++) { 
      blocks.add(new block(10, i));
      blocks.add(new block(11, i));
      blocks.add(new block(17, i));
      blocks.add(new block(16, i));
    }
    for (int i=3; i<12; i++) { 
      blocks.add(new block(12, i));
      blocks.get(blocks.size()-1).edges[1].mirror=true;
      blocks.add(new block(15, i));
      blocks.get(blocks.size()-1).edges[3].mirror=true;
    }

    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*7.5)); //enArray 0-5
      enemyArrays.get(i).paths.add(new path(13.25, 3.25+i*0.5, 1));
      enemyArrays.get(i).paths.add(new path(14.75, 3.25+i*0.5, 1));
      enemyArrays.get(i).frequencies[0] = 2;
    }
    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*7.5)); //enArray 6-11
      enemyArrays.get(i+6).paths.add(new path(14.75, 6.25+i*0.5, 1));
      enemyArrays.get(i+6).paths.add(new path(13.25, 6.25+i*0.5, 1));
      enemyArrays.get(i+6).frequencies[0] = 2;
    }
    for (int i=0; i<6; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*7.5)); //enArray 12-17
      enemyArrays.get(i+12).paths.add(new path(13.25, 9.25+i*0.5, 1));
      enemyArrays.get(i+12).paths.add(new path(14.75, 9.25+i*0.5, 1));
      enemyArrays.get(i+12).frequencies[0] = 2;
    }
    enemyArrays.add(new enemy(1, 4, 10, 0)); //enArray 18
    enemyArrays.get(18).paths.add(new path(15.25, 1.25, 2));
    enemyArrays.get(18).paths.add(new path(17.75, 1.25, 2));
    enemyArrays.get(18).paths.add(new path(17.75, 2.75, 2));
    enemyArrays.get(18).paths.add(new path(15.25, 2.75, 2));
    enemyArrays.add(new enemy(1, 4, 10, 0)); //enArray 19
    enemyArrays.get(19).paths.add(new path(12.75, 1.25, 2));
    enemyArrays.get(19).paths.add(new path(10.25, 1.25, 2));
    enemyArrays.get(19).paths.add(new path(10.25, 2.75, 2));
    enemyArrays.get(19).paths.add(new path(12.75, 2.75, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 20
    enemyArrays.get(20).paths.add(new path(16, 1.25, 1.5));
    enemyArrays.get(20).paths.add(new path(16, 2.75, 1.5));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 21
    enemyArrays.get(21).paths.add(new path(17, 2.75, 1.5));
    enemyArrays.get(21).paths.add(new path(17, 1.25, 1.5));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 22
    enemyArrays.get(22).paths.add(new path(12, 1.25, 1.5));
    enemyArrays.get(22).paths.add(new path(12, 2.75, 1.5));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 23
    enemyArrays.get(23).paths.add(new path(11, 2.75, 1.5));
    enemyArrays.get(23).paths.add(new path(11, 1.25, 1.5));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 24
    enemyArrays.get(24).paths.add(new path(12.75, 12.25, 1));
    enemyArrays.get(24).paths.add(new path(12.75, 13.75, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 25
    enemyArrays.get(25).paths.add(new path(15.25, 12.25, 1));
    enemyArrays.get(25).paths.add(new path(15.25, 13.75, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 26
    enemyArrays.get(26).paths.add(new path(12.25, 12.25, 1));
    enemyArrays.get(26).paths.add(new path(12.25, 13.75, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 27
    enemyArrays.get(27).paths.add(new path(15.75, 12.25, 1));
    enemyArrays.get(27).paths.add(new path(15.75, 13.75, 1));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 28
    enemyArrays.get(28).paths.add(new path(12.25, 13.75, 2));
    enemyArrays.get(28).paths.add(new path(15.75, 12.25, 2));
    enemyArrays.add(new enemy(1, 1, 0, 0)); //enArray 29
    enemyArrays.get(29).paths.add(new path(15.75, 13.75, 2));
    enemyArrays.get(29).paths.add(new path(12.25, 12.25, 2));
    lasers.add(new laser(19.5, 4, 7, 2));
    buttons.add(new button(8.5, 4, 1, false));
    doors.add(new door(18, 1, 18, 3, 1));
    coins.add(new coin(16.5, 12.5));
    coins.add(new coin(17.5, 12.5));
    coins.add(new coin(16.5, 13.5));
    coins.add(new coin(17.5, 13.5));
    coins.add(new coin(10.5, 12.5));
    coins.add(new coin(11.5, 12.5));
    coins.add(new coin(10.5, 13.5));
    coins.add(new coin(11.5, 13.5));
    endZones.add(new endZone(13, 1, 2, 2));
  }

  void level15() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<7; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(21, i));
    }
    for (int i=10; i<21; i++) {
      blocks.add(new block(i, 2));
    }
    for (int i=17; i<21; i++) {
      blocks.add(new block(i, 8));
    }
    blocks.add(new block(17, 3));
    blocks.add(new block(16, 3));
    blocks.add(new block(7, 6));
    blocks.add(new block(8, 6));
    blocks.add(new block(9, 6));
    blocks.add(new block(9, 7));
    blocks.add(new block(9, 8));
    blocks.add(new block(10, 8));
    blocks.add(new block(17, 10));
    blocks.add(new block(17, 11));
    blocks.add(new block(20, 9));
    blocks.add(new block(20, 10));
    triBlocks.add(new triBlock(16, 4, 3, false));
    triBlocks.add(new triBlock(9, 2, 3, false));
    triBlocks.add(new triBlock(17, 4, 1, false));
    triBlocks.add(new triBlock(11, 8, 7, false));
    triBlocks.add(new triBlock(9, 5, 5, false));
    buttons.add(new button(10.5, 9.5, 1, true));
    triggers.add(new trigger(15.5, 3.5, 2, true));
    triggers.add(new trigger(10.5, 6.5, 3, false));
    doors.add(new door(12, 9, 17, 9, 1));
    doors.add(new door(17, 5, 17, 8, 2));
    doors.add(new door(10, 3, 10, 5, 3));
    lasers.add(new laser(16.5, 11, 5, 2));
    lasers.add(new laser(19.5, 3.5, 4, 3));
    triBlocks.add(new triBlock(10, 5, 3, true));
    triBlocks.add(new triBlock(10, 11, 5, true));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray0
    enemyArrays.get(0).paths.add(new path(12.25, 7.75, 1.5));
    enemyArrays.get(0).paths.add(new path(14.75, 5.25, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray1
    enemyArrays.get(1).paths.add(new path(14.75, 7.75, 1.5));
    enemyArrays.get(1).paths.add(new path(12.25, 5.25, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray2
    enemyArrays.get(2).paths.add(new path(12.25, 4.25, 1.5));
    enemyArrays.get(2).paths.add(new path(14.75, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray3 **
    enemyArrays.get(3).paths.add(new path(14.75, 4.25, 1.5));
    enemyArrays.get(3).paths.add(new path(12.25, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray4
    enemyArrays.get(4).paths.add(new path(16.5, 8.25, 1.5));
    enemyArrays.get(4).paths.add(new path(16.5, 4.75, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray5
    enemyArrays.get(5).paths.add(new path(15.5, 4.25, 1.5));
    enemyArrays.get(5).paths.add(new path(15.5, 7.75, 1.5));
    enemyArrays.add(new enemy(1, 2, 10, 0)); //enArray6
    enemyArrays.get(6).paths.add(new path(12.5, 11.5, 1.5));
    enemyArrays.get(6).paths.add(new path(14.5, 9.5, 1.5));
    enemyArrays.get(6).paths.add(new path(14.5, 11.5, 1.5));
    enemyArrays.get(6).paths.add(new path(12.5, 9.5, 1.5));
    enemyArrays.add(new enemy(1, 2, 10, 0)); //enArray7
    enemyArrays.get(7).paths.add(new path(14.5, 11.5, 1.5));
    enemyArrays.get(7).paths.add(new path(12.5, 9.5, 1.5));
    enemyArrays.get(7).paths.add(new path(12.5, 11.5, 1.5));
    enemyArrays.get(7).paths.add(new path(14.5, 9.5, 1.5));
    enemyArrays.add(new enemy(1, 9, 9, 0)); //enArray8
    enemyArrays.get(8).paths.add(new path(17.5, 7.5, 1.5));
    enemyArrays.get(8).paths.add(new path(20.5, 7.5, 1.5));
    enemyArrays.get(8).paths.add(new path(20.5, 5.5, 1.5));
    enemyArrays.get(8).paths.add(new path(17.5, 5.5, 1.5));
    enemyArrays.add(new enemy(1, 4, 9, 8)); //enArray9
    enemyArrays.get(9).paths.add(new path(20.5, 7.5, 1.5));
    enemyArrays.get(9).paths.add(new path(20.5, 5.5, 1.5));
    enemyArrays.get(9).paths.add(new path(17.5, 5.5, 1.5));
    enemyArrays.get(9).paths.add(new path(17.5, 7.5, 1.5));
    enemyArrays.add(new enemy(1, 7, 9, 1)); //enArray10
    enemyArrays.get(10).paths.add(new path(20.5, 5.5, 1.5));
    enemyArrays.get(10).paths.add(new path(17.5, 5.5, 1.5));
    enemyArrays.get(10).paths.add(new path(17.5, 7.5, 1.5));
    enemyArrays.get(10).paths.add(new path(20.5, 7.5, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray11
    enemyArrays.get(11).paths.add(new path(18.25, 11.75, 1.5));
    enemyArrays.get(11).paths.add(new path(18.25, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray12
    enemyArrays.get(12).paths.add(new path(19.75, 11.75, 1.5));
    enemyArrays.get(12).paths.add(new path(19.75, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray13
    enemyArrays.get(13).paths.add(new path(19, 9.25, 1.5));
    enemyArrays.get(13).paths.add(new path(19, 11.75, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray14
    enemyArrays.get(14).paths.add(new path(7.25, 10.25, 1.5));
    enemyArrays.get(14).paths.add(new path(9.75, 10.25, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray15
    enemyArrays.get(15).paths.add(new path(9.75, 10.75, 1.5));
    enemyArrays.get(15).paths.add(new path(7.25, 10.75, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray16
    enemyArrays.get(16).paths.add(new path(8.75, 11.75, 1.5));
    enemyArrays.get(16).paths.add(new path(8.75, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray17
    enemyArrays.get(17).paths.add(new path(8.25, 9.25, 1.5));
    enemyArrays.get(17).paths.add(new path(8.25, 11.75, 1.5));
    endZones.add(new endZone(7, 7, 2, 2));
    coins.add(new coin(7.5, 11.5));
    coins.add(new coin(7.5, 3.5));
    coins.add(new coin(8.5, 3.5));
    coins.add(new coin(7.5, 4.5));
    coins.add(new coin(8.5, 4.5));
    coins.add(new coin(18.5, 6.5));
    coins.add(new coin(19.5, 6.5));
  }

  void level16() {

    for (int i=5; i<23; i++) { //horizontal edges
      if (i<=11 || i>15) blocks.add(new block(i, 11));
      if (i<=11 || i>15) blocks.add(new block(i, 12));
      if (i<=11 || i>15) blocks.add(new block(i, 13));
    }
    for (int i=0; i<14; i++) { //vertical edges
      for (int j=0; j<5; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=8; i<20; i++) { 
      if (i<=11 || i>15) blocks.add(new block(i, 4));
      if (i<=11 || i>15) blocks.add(new block(i, 5));
      if (i<=11 || i>15) blocks.add(new block(i, 6));
      if (i<=11 || i>15) blocks.add(new block(i, 7));
    }
    blocks.add(new block(12, 0));
    blocks.add(new block(12, 1));
    blocks.add(new block(12, 2));
    blocks.add(new block(12, 3));
    blocks.add(new block(15, 0));
    blocks.add(new block(15, 1));
    blocks.add(new block(15, 2));
    blocks.add(new block(15, 3));
    blocks.add(new block(12, 13));
    blocks.add(new block(15, 13));
    blocks.add(new block(13, 0));
    blocks.add(new block(14, 0));
    blocks.add(new block(5, 0));
    blocks.add(new block(6, 0));
    blocks.add(new block(5, 1));
    blocks.add(new block(21, 0));
    blocks.add(new block(22, 0));
    blocks.add(new block(22, 1));
    triBlocks.add(new triBlock(12, 12, 7, false));
    triBlocks.add(new triBlock(15, 12, 5, false));
    triBlocks.add(new triBlock(13, 9, 5, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(14, 9, 7, false));
    triBlocks.add(new triBlock(13, 10, 3, false));
    triBlocks.add(new triBlock(14, 10, 1, false));
    triBlocks.add(new triBlock(11, 3, 5, false));
    triBlocks.add(new triBlock(12, 4, 1, false));
    triBlocks.add(new triBlock(15, 4, 3, false));
    triBlocks.add(new triBlock(16, 3, 7, false));
    triBlocks.add(new triBlock(11, 0, 3, false));
    triBlocks.add(new triBlock(16, 0, 1, false));
    triBlocks.add(new triBlock(5, 2, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(6, 1, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(7, 0, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(22, 2, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(21, 1, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(20, 0, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    for (int i=8; i<20; i++) {
      if (i<12 || i>15) deathBlocks.add(new deathBlock(i, 8));
      if (i<12 || i>15) deathBlocks.add(new deathBlock(i, 9));
    }
    deathBlocks.add(new deathBlock(5, 7));
    deathBlocks.add(new deathBlock(7, 4));
    deathBlocks.add(new deathBlock(22, 7));
    deathBlocks.add(new deathBlock(20, 4));
    lasers.add(new laser(13.5, 3.5, 4, 1));
    lasers.add(new laser(7.5, 8.5, 2, 2));
    triggers.add(new trigger(10.5, 1.5, 1, false));
    triggers.add(new trigger(17.5, 1.5, 2, false));
    buttons.add(new button(5.5, 8.5, 1, true));
    doors.add(new door(13, 4, 15, 4, 1));
    doors.add(new door(13, 3, 15, 3, 2));
    radialEnemies.add(new radialEnemy(9, 10, 0.75, 2, 17.5, 5, 3, 1, PI/4, 0, false));
    radialEnemies.add(new radialEnemy(11, 10, 0.75, 2, 17.5, 5, 3, 1, (3*PI)/4, 0, true));
    radialEnemies.add(new radialEnemy(17, 10, 0.75, 2, 17.5, 5, 3, 1, PI/4, 0, false));
    radialEnemies.add(new radialEnemy(19, 10, 0.75, 2, 17.5, 5, 3, 1, (3*PI)/4, 0, true));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray0
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 8, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.75, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 8.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=2;
    enemyArrays.get(enemyArrays.size()-1).frequencies[1]=2;
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray1
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 8, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 8.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=2;
    enemyArrays.get(enemyArrays.size()-1).frequencies[1]=2;
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray2
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 6.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray3
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 5.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 5.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray4
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 6, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 6, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray5
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 6.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray6
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 5.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 5.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray7
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 6, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 6, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray8
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.5, 3.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.5, 0.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=2;
    enemyArrays.get(enemyArrays.size()-1).frequencies[1]=2;
    enemyArrays.add(new enemy(2, 2, 10, 0)); //enArray9
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 3.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 0.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0]=2;
    enemyArrays.get(enemyArrays.size()-1).frequencies[1]=2;
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray10
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 7.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 7.5, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray15
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 6, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 6, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray16
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 6.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray17
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 5.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.25, 5.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray18
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 7.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 4.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray19
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 4.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 7.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray20
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.75, 7.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 4.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0)); //enArray21
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 7.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.75, 4.75, 1.5));
    coins.add(new coin(13.5, 1.5));
    coins.add(new coin(14.5, 1.5));
    coins.add(new coin(13.5, 2.5));
    coins.add(new coin(14.5, 2.5));
    triBlocks.add(new triBlock(18.5, 2.5, 5, true));
    triBlocks.add(new triBlock(8.5, 2.5, 7, true));
    endZones.add(new endZone(13, 13, 2, 1));
  }

  void level17() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<4; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(4, i));
    }
    for (int i=10; i<24; i++) {
      if (i!=10)blocks.add(new block(i, 2));
      blocks.add(new block(i, 11));
    }
    for (int i=3; i<7; i++) {
      blocks.add(new block(17, i));
      blocks.add(new block(18, i));
    }
    for (int i=3; i<11; i++) {
      if (i!=5 && i!=6 && i!=8 && i!=9) blocks.add(new block(22, i));
      if (i!=5 && i!=6 && i!=8 && i!=9) blocks.add(new block(23, i));
    }
    blocks.add(new block(5, 11));
    blocks.add(new block(6, 11));
    triBlocks.add(new triBlock(10, 10, 5, false));
    triBlocks.add(new triBlock(11, 10, 7, false));
    triBlocks.add(new triBlock(10, 2, 3, false));
    triBlocks.add(new triBlock(17, 7, 3, false));
    triBlocks.add(new triBlock(18, 7, 1, false));
    deathBlocks.add(new deathBlock(7, 9));
    deathBlocks.add(new deathBlock(8, 9));
    deathBlocks.add(new deathBlock(9, 9));
    deathBlocks.add(new deathBlock(10, 9));
    deathBlocks.add(new deathBlock(10, 8));
    deathBlocks.add(new deathBlock(10, 7));
    deathBlocks.add(new deathBlock(10, 6));
    deathBlocks.add(new deathBlock(5, 6));
    deathBlocks.add(new deathBlock(6, 6));
    deathBlocks.add(new deathBlock(7, 6));
    triDeathBlocks.add(new triDeathBlock(10, 10, 1));
    triDeathBlocks.add(new triDeathBlock(10, 5, 7));
    lasers.add(new laser(9.5, 10.5, 0, 3));
    lasers.add(new laser(16, 5.5, 4, 4));
    triggers.add(new trigger(8, 4, 3, true));
    triggers.add(new trigger(20.5, 5, 4, false));
    triBlocks.add(new triBlock(15.5, 10, 5, true));
    triBlocks.add(new triBlock(9, 3.5, 3, true));
    doors.add(new door(10, 2, 10, 5, 3));
    doors.add(new door(22, 8, 22, 10, 4));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray0
    enemyArrays.get(0).paths.add(new path(16.75, 9.75, 1));
    enemyArrays.get(0).paths.add(new path(14.25, 9.75, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray1
    enemyArrays.get(1).paths.add(new path(16.75, 8.75, 1));
    enemyArrays.get(1).paths.add(new path(14.25, 8.75, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray2
    enemyArrays.get(2).paths.add(new path(14.25, 9.25, 1));
    enemyArrays.get(2).paths.add(new path(16.75, 9.25, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray3
    enemyArrays.get(3).paths.add(new path(11.25, 7.25, 1));
    enemyArrays.get(3).paths.add(new path(13.75, 7.25, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray4
    enemyArrays.get(4).paths.add(new path(11.25, 6.25, 1));
    enemyArrays.get(4).paths.add(new path(13.75, 6.25, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray5
    enemyArrays.get(5).paths.add(new path(13.75, 6.75, 1));
    enemyArrays.get(5).paths.add(new path(11.25, 6.75, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray6
    enemyArrays.get(6).paths.add(new path(16.75, 7.25, 1));
    enemyArrays.get(6).paths.add(new path(14.25, 7.25, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray7
    enemyArrays.get(7).paths.add(new path(16.75, 6.25, 1));
    enemyArrays.get(7).paths.add(new path(14.25, 6.25, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray8
    enemyArrays.get(8).paths.add(new path(14.25, 6.75, 1));
    enemyArrays.get(8).paths.add(new path(16.75, 6.75, 1));
    enemyArrays.add(new enemy(1, 5, 10, 0)); //enArray9
    enemyArrays.get(9).paths.add(new path(17.5, 10.5, 1.5));
    enemyArrays.get(9).paths.add(new path(17.5, 8.5, 1.5));
    enemyArrays.get(9).paths.add(new path(18.5, 8.5, 1.5));
    enemyArrays.get(9).paths.add(new path(18.5, 10.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray10
    enemyArrays.get(10).paths.add(new path(19.25, 7.75, 1));
    enemyArrays.get(10).paths.add(new path(21.75, 7.75, 1));
    enemyArrays.add(new enemy(2, 2, 15, 0)); //enArray11
    enemyArrays.get(11).paths.add(new path(21.75, 7.25, 1));
    enemyArrays.get(11).paths.add(new path(19.25, 7.25, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray12
    enemyArrays.get(12).paths.add(new path(5.25, 8.75, 1));
    enemyArrays.get(12).paths.add(new path(7.5, 8.75, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray13
    enemyArrays.get(13).paths.add(new path(7.5, 8, 1));
    enemyArrays.get(13).paths.add(new path(5.25, 8, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray14
    enemyArrays.get(14).paths.add(new path(5.25, 7.25, 1));
    enemyArrays.get(14).paths.add(new path(7.5, 7.25, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray15
    enemyArrays.get(15).paths.add(new path(9.75, 8.75, 1));
    enemyArrays.get(15).paths.add(new path(7.5, 8.75, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray16
    enemyArrays.get(16).paths.add(new path(7.5, 8, 1));
    enemyArrays.get(16).paths.add(new path(9.75, 8, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0)); //enArray17
    enemyArrays.get(17).paths.add(new path(9.75, 7.25, 1));
    enemyArrays.get(17).paths.add(new path(7.5, 7.25, 1));
    coins.add(new coin(22.5, 8.5));
    coins.add(new coin(23.5, 8.5));
    coins.add(new coin(22.5, 9.5));
    coins.add(new coin(23.5, 9.5));
    endZones.add(new endZone(22, 5, 2, 2));
  }

  void level18() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 13));
    }
    for (int i=1; i<13; i++) { //vertical edges
      for (int j=0; j<5; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=5; i<23; i++) {
      if (i<10 || i>17) {
        blocks.add(new block(i, 1));
        blocks.add(new block(i, 12));
      } 
      if (i<9 || i>18) {
        blocks.add(new block(i, 2));
        blocks.add(new block(i, 11));
      } 
      if (i<8 || i>19) {
        blocks.add(new block(i, 3));
        blocks.add(new block(i, 10));
      }
    }
    for (int i=10; i<18; i++) if (i<12 || i>15) blocks.add(new block(i, 8));
    for (int i=11; i<17; i++) if (i<12 || i>15) blocks.add(new block(i, 9)); 
    for (int i=10; i<18; i++) if (i<12|| i>15) blocks.add(new block(i, 5));
    for (int i=11; i<17; i++) if (i<12 || i>15) blocks.add(new block(i, 4));
    blocks.add(new block(12, 3));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(15, 3));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(12, 10));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(15, 10));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(12, 4));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(12, 5));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(12, 8));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(12, 9));
    blocks.get(blocks.size()-1).edges[1].mirror=true;
    blocks.add(new block(15, 4));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(15, 5));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(15, 8));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    blocks.add(new block(15, 9));
    blocks.get(blocks.size()-1).edges[3].mirror=true;
    triBlocks.add(new triBlock(8, 3, 1, false));
    triBlocks.add(new triBlock(9, 2, 1, false));
    triBlocks.add(new triBlock(10, 1, 1, false));
    triBlocks.add(new triBlock(17, 1, 3, false));
    triBlocks.add(new triBlock(18, 2, 3, false));
    triBlocks.add(new triBlock(19, 3, 3, false));
    triBlocks.add(new triBlock(8, 10, 7, false));
    triBlocks.add(new triBlock(9, 11, 7, false));
    triBlocks.add(new triBlock(10, 12, 7, false));
    triBlocks.add(new triBlock(17, 12, 5, false));
    triBlocks.add(new triBlock(18, 11, 5, false));
    triBlocks.add(new triBlock(19, 10, 5, false));
    triBlocks.add(new triBlock(10, 9, 3, false));
    triBlocks.add(new triBlock(11, 10, 3, false));
    triBlocks.add(new triBlock(16, 10, 1, false));
    triBlocks.add(new triBlock(17, 9, 1, false));
    triBlocks.add(new triBlock(16, 3, 7, false));
    triBlocks.add(new triBlock(17, 4, 7, false));
    triBlocks.add(new triBlock(10, 4, 5, false));
    triBlocks.add(new triBlock(11, 3, 5, false));
    deathBlocks.add(new deathBlock(8, 6));
    deathBlocks.add(new deathBlock(8, 7));
    deathBlocks.add(new deathBlock(19, 6));
    deathBlocks.add(new deathBlock(19, 7));
    triDeathBlocks.add(new triDeathBlock(8, 5, 5));
    triDeathBlocks.add(new triDeathBlock(8, 8, 3));
    triDeathBlocks.add(new triDeathBlock(19, 5, 7));
    triDeathBlocks.add(new triDeathBlock(19, 8, 1));
    lasers.add(new laser(20.5, 7, 6, 1));
    triBlocks.add(new triBlock(6.5, 6.5, 3, true));
    for (int i=0; i<4; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*12));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 3.25+i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.75, 3.25+i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*12));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.75, 5.25+i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 5.25+i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
    }
    for (int i=0; i<4; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*12));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 10.75-i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.75, 10.75-i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, i*12));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.75, 8.75-i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 8.75-i*0.5, 1));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25+i*1.5, 7.75, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25+i*1.5, 6.25, 1));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5+i*1.5, 6.25, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5+i*1.5, 7.75, 1));
    }

    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25+i*1.5, 7.75, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25+i*1.5, 6.25, 1));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 1, 0, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16+i*1.5, 6.25, 1));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16+i*1.5, 7.75, 1));
    }
    enemyArrays.add(new enemy(2, 4, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 9.5, 1.85));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5, 11.5, 1.85));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.5, 11.5, 1.85));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.5, 9.5, 1.85));
    enemyArrays.add(new enemy(2, 5, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9, 10, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.5, 12.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5, 12.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19, 10, 2));
    enemyArrays.add(new enemy(2, 4, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 4.5, 1.85));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5, 2.5, 1.85));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.5, 2.5, 1.85));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.5, 4.5, 1.85));
    enemyArrays.add(new enemy(2, 5, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9, 4, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.5, 1.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5, 1.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19, 4, 2));
    enemyArrays.add(new enemy(2, 4, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 9.75, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 7.25, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 6.75, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 4.25, 2));
    enemyArrays.add(new enemy(2, 4, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 9.75, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 7.25, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 6.75, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 4.25, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 9.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 8.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 8.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 5.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 5.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 4.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 4.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 9, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 9, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.25, 5, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 9.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 9.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 8.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 8.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 5.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 5.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 4.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 4.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 9, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 9, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 5, 1.5));
    endZones.add(new endZone(13, 6, 2, 2));
  }

  void level19() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
    }
    for (int i=1; i<14; i++) { //vertical edges
      for (int j=0; j<3; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(4, i)); 
      blocks.add(new block(3, i)); 
      if (i!=9 && i!=10 && i!=11) blocks.add(new block(24, i));
    }

    for (int i=1; i<10; i++) { 
      blocks.add(new block(5, i));
      blocks.add(new block(6, i));
      blocks.add(new block(7, i));
    }
    for (int i=8; i<13; i++) { 
      blocks.add(new block(i, 8));
      blocks.add(new block(i, 9));
    }
    for (int i=5; i<17; i++) blocks.add(new block(i, 13));
    for (int i=13; i<17; i++) blocks.add(new block(i, 12));
    for (int i=5; i<12; i++) blocks.add(new block(16, i));
    for (int i=8; i<12; i++) blocks.add(new block(i, 1));
    blocks.add(new block(5, 12));
    blocks.add(new block(6, 12));
    blocks.add(new block(16, 3));
    blocks.add(new block(16, 4));
    triBlocks.add(new triBlock(17, 4, 1, false));
    triBlocks.add(new triBlock(12, 1, 1, false));
    triBlocks.add(new triBlock(17, 3, 7, false));
    deathBlocks.add(new deathBlock(22, 13));
    deathBlocks.add(new deathBlock(22, 12));
    deathBlocks.add(new deathBlock(22, 11));
    deathBlocks.add(new deathBlock(19, 11));
    deathBlocks.add(new deathBlock(19, 10));
    deathBlocks.add(new deathBlock(22, 7));
    deathBlocks.add(new deathBlock(23, 7));
    triDeathBlocks.add(new triDeathBlock(19, 9, 5));
    triDeathBlocks.add(new triDeathBlock(20, 8, 5));
    triDeathBlocks.add(new triDeathBlock(21, 7, 5));
    triDeathBlocks.add(new triDeathBlock(20, 9, 1));
    triDeathBlocks.add(new triDeathBlock(21, 8, 1));
    triDeathBlocks.add(new triDeathBlock(22, 10, 5));
    lasers.add(new laser(23.5, 13.5, 6, 1));
    triBlocks.add(new triBlock(17, 13, 7, true));
    triBlocks.add(new triBlock(22, 3, 3, true));
    triggers.add(new trigger(17.5, 8.5, 1, true));
    doors.add(new door(17, 7, 22, 7, 1));
    lasers.add(new laser(18.5, 3.5, 2, 1));
    enemyArrays.add(new enemy(1, 9, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 6.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.5, 6.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.5, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 4.5, 1.5));
    enemyArrays.add(new enemy(1, 4, 10, 6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.5, 6.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.5, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 6.5, 1.5));
    enemyArrays.add(new enemy(1, 5, 10, 3));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.5, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 6.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.5, 6.5, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 13.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 9.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(21.5, 12.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(21.5, 8.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(22.75, 9.5, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.75, 9.5, 1.25));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(23.75, 8.5, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(21.75, 8.5, 1.25));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 3.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 3.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 1.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 1.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 2.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 2.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 7.5, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 7.75, 2.2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 4.25, 2.2));
    enemyArrays.add(new enemy(2, 2, 7.5, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 4.25, 2.2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 7.75, 2.2));
    enemyArrays.add(new enemy(2, 2, 7.5, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.5, 7.75, 2.2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.5, 4.25, 2.2));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 8.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 8.5, 1.5));
    for (int i=0; i<4; i++) {
      enemyArrays.add(new enemy(2, 3, 5, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.25+i*0.5, 7.75, 3));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.25+i*0.5, 5.25, 3));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
      enemyArrays.get(enemyArrays.size()-1).frequencies[1]=1;
      enemyArrays.get(enemyArrays.size()-1).frequencies[2]=1;
      enemyArrays.add(new enemy(2, 3, 5, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(8.25+i*0.5, 2.25, 3));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(8.25+i*0.5, 4.75, 3));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
      enemyArrays.get(enemyArrays.size()-1).frequencies[1]=1;
      enemyArrays.get(enemyArrays.size()-1).frequencies[2]=1;
    }
    radialEnemies.add(new radialEnemy(14.5, 10.5, 1.25, 3, 17, 2, 3, 3, PI/8, 0, false));
    radialEnemies.add(new radialEnemy(11.5, 11.5, 1.25, 3, 17, 2, 3, 3, 0, 0, true));
    radialEnemies.add(new radialEnemy(8.5, 11.5, 1.25, 3, 17, 2, 3, 3, PI, 0, false));
    endZones.add(new endZone(5, 10, 2, 2));
    for (int i=0; i<3; i++) {
      coins.add(new coin(8.5, 5.5+i));
      coins.add(new coin(9.5, 5.5+i));
    }
  }

  void level20() {

    for (int i=0; i<28; i++) { //horizontal edges
      if (i!=19 && i!=20) blocks.add(new block(i, 0));
    }
    for (int i=1; i<14; i++) { //vertical edges
      for (int j=0; j<5; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      if (i!=8) blocks.add(new block(5, i)); 
      if (i!=6) blocks.add(new block(21, i)); 
      blocks.add(new block(22, i));
    }
    for (int i=8; i<22; i++) {
      if (i!=11 && i!=12 && i!=13 && i!=16 && i!=17 && i!=18) {
        blocks.add(new block(i, 12));
        blocks.add(new block(i, 13));
        blocks.add(new block(26-i, 1));
        blocks.add(new block(26-i, 2));
      }
    }
    for (int i=8; i<19; i+=2) {
      deathBlocks.add(new deathBlock(i, 5));
      deathBlocks.add(new deathBlock(i, 7));
      deathBlocks.add(new deathBlock(i, 9));
    }
    lasers.add(new laser(12.5, 13, 0, 2));
    lasers.add(new laser(14.5, 2, 4, 4));
    triggers.add(new trigger(21.5, 6.5, 2, true));
    triggers.add(new trigger(5.5, 8.5, 4, true));
    triBlocks.add(new triBlock(17, 12, 5, true));
    triBlocks.add(new triBlock(9, 2, 1, true));
    doors.add(new door(19, 3, 21, 3, 2));
    doors.add(new door(19, 2, 21, 2, 4));
    radialEnemies.add(new radialEnemy(10.5, 7.5, 1.5, 3, 17, 1.5, 3, 3, PI, 0, false));
    radialEnemies.add(new radialEnemy(12.5, 7.5, 1.5, 3, 17, 1.5, 3, 3, 0, 0, true));
    radialEnemies.add(new radialEnemy(14.5, 7.5, 1.5, 3, 17, 1.5, 3, 3, 0, 0, true));
    radialEnemies.add(new radialEnemy(16.5, 7.5, 1.5, 3, 17, 1.5, 3, 3, PI, 0, false));
    enemyArrays.add(new enemy(2, 4, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 10.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.5, 10.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.5, 7.5, 1.775));
    enemyArrays.add(new enemy(2, 6, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 11.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.5, 11.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.5, 7.5, 2));
    enemyArrays.add(new enemy(2, 4, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 10.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 10.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 7.5, 1.775));
    enemyArrays.add(new enemy(2, 6, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 11.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 11.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 7.5, 2));
    enemyArrays.add(new enemy(2, 4, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 4.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.5, 4.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.5, 7.5, 1.775));
    enemyArrays.add(new enemy(2, 6, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 3.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.5, 3.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.5, 7.5, 2));
    enemyArrays.add(new enemy(2, 4, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 4.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 4.5, 1.775));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 7.5, 1.775));
    enemyArrays.add(new enemy(2, 6, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 3.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 3.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(20.5, 7.5, 2));
    coins.add(new coin(19.5, 0.5));
    coins.add(new coin(20.5, 0.5));
    coins.add(new coin(19.5, 1.5));
    coins.add(new coin(20.5, 1.5));
    endZones.add(new endZone(6, 12, 2, 2));
  }

  void level21() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 13));
    }
    for (int i=1; i<13; i++) { //vertical edges
      for (int j=0; j<4; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(4, i));
    }
    for (int i=9; i<24; i++) {
      blocks.add(new block(i, 1));
      if (i>=12 && i<18) blocks.get(blocks.size()-1).edges[2].mirror=true;
    }
    for (int i=2; i<10; i++) {
      blocks.add(new block(20, i));
    }
    blocks.add(new block(9, 2));
    blocks.add(new block(9, 3));
    blocks.add(new block(9, 4));
    blocks.add(new block(10, 2));
    blocks.add(new block(10, 3));
    blocks.add(new block(19, 2));
    blocks.add(new block(19, 3));
    blocks.add(new block(18, 6));
    blocks.add(new block(19, 6));
    triBlocks.add(new triBlock(11, 2, 1, false));
    triBlocks.add(new triBlock(18, 2, 3, false));
    triBlocks.add(new triBlock(9, 5, 3, false));
    triBlocks.add(new triBlock(20, 10, 3, false));
    triBlocks.add(new triBlock(17, 6, 3, false));
    triBlocks.add(new triBlock(5, 1, 1, false));
    for (int i=12; i<18; i++) {
      deathBlocks.add(new deathBlock(i, 2));
      deathBlocks.add(new deathBlock(i, 3));
    }
    for (int i=12; i<16; i++) {
      deathBlocks.add(new deathBlock(i, 4));
      deathBlocks.add(new deathBlock(i, 5));
    }
    for (int i=9; i<13; i++) {
      deathBlocks.add(new deathBlock(9, i));
    }
    deathBlocks.add(new deathBlock(11, 3));
    deathBlocks.add(new deathBlock(18, 3));
    deathBlocks.add(new deathBlock(12, 6));
    deathBlocks.add(new deathBlock(12, 7));
    deathBlocks.add(new deathBlock(16, 4));
    deathBlocks.add(new deathBlock(14, 10));
    deathBlocks.add(new deathBlock(15, 10));
    deathBlocks.add(new deathBlock(14, 11));
    deathBlocks.add(new deathBlock(15, 11));
    deathBlocks.add(new deathBlock(14, 12));
    deathBlocks.add(new deathBlock(7, 7));
    deathBlocks.add(new deathBlock(5, 10));
    deathBlocks.add(new deathBlock(6, 10));
    triDeathBlocks.add(new triDeathBlock(11, 2, 5));
    triDeathBlocks.add(new triDeathBlock(18, 2, 7));
    triDeathBlocks.add(new triDeathBlock(14, 6, 3));
    triDeathBlocks.add(new triDeathBlock(15, 6, 1));
    triDeathBlocks.add(new triDeathBlock(14, 9, 5));
    triDeathBlocks.add(new triDeathBlock(15, 9, 7));
    triDeathBlocks.add(new triDeathBlock(12, 8, 1));
    triDeathBlocks.add(new triDeathBlock(11, 8, 5));
    triDeathBlocks.add(new triDeathBlock(9, 8, 7));
    triDeathBlocks.add(new triDeathBlock(8, 8, 3));
    triDeathBlocks.add(new triDeathBlock(8, 7, 7));
    lasers.add(new laser(22.5, 5.5, 4, 3));
    triggers.add(new trigger(15.5, 12.5, 3, true));
    lasers.add(new laser(7.5, 1.5, 4, 3));
    triBlocks.add(new triBlock(22, 12, 5, true));
    triBlocks.add(new triBlock(10, 5, 7, true));
    doors.add(new door(15, 7, 15, 9, 3));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.25, 4.25, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.25, 5.75, 1));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0] = 3;
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.75, 4.25, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.75, 5.75, 1));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0] = 3;
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.25, 4.25, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.25, 5.75, 1));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0] = 3;
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.75, 4.25, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.75, 5.75, 1));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0] = 3;
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.25, 5.75, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.25, 4.25, 1));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0] = 3;
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75, 5.75, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75, 4.25, 1));
    enemyArrays.get(enemyArrays.size()-1).frequencies[0] = 3;
    radialEnemies.add(new radialEnemy(12, 11, 1.75, 4, 15, 1, 3, 3, 0, 0, false));
    for (int i=0; i<3; i++) {
      enemyArrays.add(new enemy(2, 3, 10, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5-i*1.5, 12.75, 1.5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5-i*1.5, 7.25, 1.5));
    }
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 3, 10, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75-i*1.5, 7.25, 1.5));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75-i*1.5, 12.75, 1.5));
    }
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 4.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(8.75, 4.5, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(5.25, 7.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 7.5, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(8.75, 10.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.25, 10.5, 1.5));
    enemyArrays.add(new enemy(2, 1, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.25, 9.75, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 8.25, 1.25));
    enemyArrays.add(new enemy(2, 1, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.75, 9.75, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(6.25, 8.25, 1.25));
    endZones.add(new endZone(5, 11, 2, 2));
  }

  void level22() {
    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 2));
      blocks.add(new block(i, 10));
      blocks.add(new block(i, 11));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=3; i<10; i++) { //vertical edges
      for (int j=0; j<7; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=5; i<8; i++) { 
      blocks.add(new block(7, i));
      blocks.add(new block(8, i));
    }
    blocks.add(new block(13, 3));
    blocks.add(new block(14, 3));
    triBlocks.add(new triBlock(13, 4, 3, false));
    triBlocks.add(new triBlock(14, 4, 1, false));
    triBlocks.add(new triBlock(13, 9, 5, false));
    triBlocks.add(new triBlock(14, 9, 7, false));
    for (int i=18; i<21; i++) { 
      deathBlocks.add(new deathBlock(i, 5));
      deathBlocks.add(new deathBlock(i, 8));
      deathBlocks.add(new deathBlock(i, 9));
    }
    for (int i=5; i<8; i++) { 
      deathBlocks.add(new deathBlock(10, i));
    }
    deathBlocks.add(new deathBlock(11, 6));
    triDeathBlocks.add(new triDeathBlock(11, 5, 7));
    triDeathBlocks.add(new triDeathBlock(11, 7, 1));
    lasers.add(new laser(10, 9.5, 0, 2));
    buttons.add(new button(12.5, 3.5, 1, true));
    triggers.add(new trigger(19.5, 4.5, 2, false));
    triBlocks.add(new triBlock(15.5, 3, 2, true));
    triBlocks.add(new triBlock(11, 3, 5, true));
    doors.add(new door(14, 5, 14, 9, 1));
    doors.add(new door(9, 3, 9, 5, 2));
    radialEnemies.add(new radialEnemy(16, 7, 1.75, 4, 16, 1.5, 3, 3, 0, 0, false));
    enemyArrays.add(new enemy(2, 3, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 9.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 5.5, 2));
    enemyArrays.add(new enemy(2, 3, 7, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 5.5, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 9.5, 2));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 5, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.75, 5, 1.25));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 8, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.75, 8, 1.25));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.75, 5.75, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 5.75, 1.25));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.75, 7.25, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 7.25, 1.25));
    enemyArrays.add(new enemy(2, 1, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5, 7.25, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5, 9.75, 1.25));
    enemyArrays.add(new enemy(2, 1, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25, 9.75, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25, 7.25, 1.25));
    coins.add(new coin(20.5, 6.5));
    coins.add(new coin(20.5, 7.5));
    coins.add(new coin(7.5, 3.5));
    coins.add(new coin(8.5, 3.5));
    coins.add(new coin(7.5, 4.5));
    coins.add(new coin(8.5, 4.5));
    endZones.add(new endZone(7, 8, 2, 2));
  }

  void level23() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 13));
    }
    for (int i=0; i<13; i++) { //vertical edges
      for (int j=0; j<10; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(10, i));
    }
    for (int i=13; i<16; i++) {
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 1));
    }
    blocks.add(new block(14, 2));
    blocks.add(new block(11, 11));
    blocks.add(new block(11, 12));
    blocks.add(new block(12, 12));
    blocks.add(new block(17, 11));
    blocks.add(new block(17, 12));
    blocks.add(new block(16, 12));
    triBlocks.add(new triBlock(13, 2, 3, false));
    triBlocks.add(new triBlock(15, 2, 1, false));
    triBlocks.add(new triBlock(12, 11, 7, false));
    triBlocks.add(new triBlock(16, 11, 5, false));
    triBlocks.add(new triBlock(11, 6, 7, false));
    triBlocks.add(new triBlock(11, 7, 1, false));
    triBlocks.add(new triBlock(17, 6, 5, false));
    triBlocks.add(new triBlock(17, 7, 3, false));
    lasers.add(new laser(11.5, 9.5, 2, 1));
    triggers.add(new trigger(17.5, 9.5, 1, true));
    buttons.add(new button(11.5, 5.5, 1, true));
    buttons.add(new button(12, 1, 4, false));
    doors.add(new door(12, 7, 17, 7, 1));
    doors.add(new door(16, 2, 18, 2, 4));
    triBlocks.add(new triBlock(17, 5, 5, true));
    deathBlocks.add(new deathBlock(14, 7));
    deathBlocks.add(new deathBlock(14, 8));
    deathBlocks.add(new deathBlock(14, 9));
    deathBlocks.add(new deathBlock(13, 9));
    deathBlocks.add(new deathBlock(15, 9));
    triDeathBlocks.add(new triDeathBlock(13, 8, 5));
    triDeathBlocks.add(new triDeathBlock(15, 8, 7));
    for (int i=0; i<2; i++) {
      enemyArrays.add(new enemy(2, 3, 7.5, 0));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11.25, 2.25+i*0.5, 2));
      enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.75, 2.25+i*0.5, 2));
      enemyArrays.get(enemyArrays.size()-1).frequencies[0]=1;
      enemyArrays.get(enemyArrays.size()-1).frequencies[1]=1;
      enemyArrays.get(enemyArrays.size()-1).frequencies[2]=1;
    }
    radialEnemies.add(new radialEnemy(14.5, 5, 1.5, 4, 15, 2, 3, 3, PI/8, 0, false));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17, 6.5, 1.015));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12, 6.5, 1.015));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12, 3.5, 1.015));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17, 3.5, 1.015));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13, 11.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16, 11.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13, 10.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16, 10.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16, 11, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13, 11, 1.5));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5, 11, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5, 8, 1.5));
    enemyArrays.add(new enemy(2, 1, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 8, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 11, 1.5));
    coins.add(new coin(16.5, 0.5));
    coins.add(new coin(17.5, 0.5));
    coins.add(new coin(16.5, 1.5));
    coins.add(new coin(17.5, 1.5));
    endZones.add(new endZone(13, 12, 3, 1));
  }

  void level24() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 0));
      blocks.add(new block(i, 1));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=2; i<12; i++) { //vertical edges
      for (int j=0; j<6; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(6, i));
    }
    for (int i=4; i<10; i++) {
      blocks.add(new block(20, i));
      blocks.add(new block(21, i));
    }
    for (int i=7; i<12; i++) {
      blocks.add(new block(16, i));
    }
    for (int i=12; i<16; i++) {
      blocks.add(new block(i, 6));
      blocks.add(new block(i, 7));
      blocks.add(new block(i, 8));
    }
    blocks.add(new block(11, 6));
    blocks.add(new block(11, 7));
    triBlocks.add(new triBlock(16, 6, 7, false));
    triBlocks.add(new triBlock(12, 9, 3, false));
    triBlocks.add(new triBlock(13, 9, 1, false));
    triBlocks.add(new triBlock(10, 6, 5, false));
    triBlocks.add(new triBlock(10, 7, 3, false));
    lasers.add(new laser(18.5, 11.5, 0, 2));
    buttons.add(new button(8.5, 2.5, 3, true));
    triggers.add(new trigger(8.5, 11.5, 2, true));
    doors.add(new door(7, 7, 10, 7, 3));
    doors.add(new door(13, 10, 13, 12, 2));
    triBlocks.add(new triBlock(18, 4, 3, true));
    triBlocks.add(new triBlock(10, 8, 7, true));
    radialEnemies.add(new radialEnemy(13.5, 4, 1.75, 4, 15, 3, 3, 3, 0, 0, false));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 6.75, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 6.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 9.25, 1.5));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5, 9.75, 1.2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 9.75, 1.2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19.5, 6.25, 1.2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5, 6.25, 1.2));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16, 5.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16, 2.25, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11, 2.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(11, 5.75, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.25, 6.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.25, 6.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.25, 7.5, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(7.25, 7.5, 1.5));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 9.75, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 11.75, 1));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 11.75, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 9.75, 1));
    endZones.add(new endZone(20, 2, 2, 2));
    coins.add(new coin(14.5, 9.5));
    coins.add(new coin(15.5, 9.5));
    coins.add(new coin(14.5, 10.5));
    coins.add(new coin(15.5, 10.5));
    coins.add(new coin(14.5, 11.5));
    coins.add(new coin(15.5, 11.5));
  }

  void level25() {

    for (int i=0; i<28; i++) { //horizontal edges
      blocks.add(new block(i, 13));
    }
    for (int i=0; i<13; i++) { //vertical edges
      for (int j=0; j<7; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=0; i<11; i++) {
      blocks.add(new block(20, i));
      blocks.add(new block(7, i));
      if (i<2||i>7) blocks.add(new block(19, i));
      if (i<2||i>7) blocks.add(new block(8, i));
      if (i<1||i>8) blocks.add(new block(18, i));
      if (i<1||i>8) blocks.add(new block(9, i));
    } 
    for (int i=3; i<7; i++) {
      blocks.add(new block(10, i));
      blocks.add(new block(11, i));
      blocks.add(new block(12, i));
      blocks.add(new block(15, i));
      blocks.add(new block(16, i));
      blocks.add(new block(17, i));
    } 
    for (int i=10; i<13; i++) {
      blocks.add(new block(13, i));
      blocks.add(new block(14, i));
    } 
    blocks.add(new block(17, 10));
    blocks.add(new block(10, 10));
    triBlocks.add(new triBlock(10, 0, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(9, 1, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(8, 2, 1, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(17, 0, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(18, 1, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(19, 2, 3, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(19, 7, 5, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(18, 8, 5, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(17, 9, 5, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(8, 7, 7, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(9, 8, 7, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(10, 9, 7, false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror = true;
    triBlocks.add(new triBlock(13, 9, 5, false));
    triBlocks.add(new triBlock(14, 9, 7, false));
    for (int i=3; i<7; i++) {
      deathBlocks.add(new deathBlock(8, i));
      deathBlocks.add(new deathBlock(9, i));
      deathBlocks.add(new deathBlock(18, i));
      deathBlocks.add(new deathBlock(19, i));
    } 
    lasers.add(new laser(16, 1.5, 2, 1));
    lasers.add(new laser(12, 1.5, 6, 2));
    triggers.add(new trigger(11.5, 10.5, 2, true));
    triggers.add(new trigger(16.5, 10.5, 1, true));
    buttons.add(new button(8, 12, 3, true));
    doors.add(new door(18, 11, 18, 13, 1));
    doors.add(new door(10, 11, 10, 13, 2));
    doors.add(new door(15, 0, 15, 3, 3));
    triBlocks.add(new triBlock(11, 8, 3, true));
    triBlocks.add(new triBlock(16, 8, 1, true));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 3.25, 0.6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 3.25, 0.6));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 6.75, 0.6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 6.75, 0.6));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 3.75, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.5, 6.25, 1.25));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 6.25, 1.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5, 3.75, 1.25));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 12.5, 1.6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 7.5, 1.6));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.5, 7.5, 1.6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.5, 12.5, 1.6));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16, 7.5, 1.75));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(19, 7.5, 1.75));
    enemyArrays.add(new enemy(2, 2, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12, 7.5, 1.75));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9, 7.5, 1.75));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.5, 11.25, 1.075));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.5, 12.75, 1.075));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5, 12.75, 1.075));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5, 11.25, 1.075));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 11.25, 1.075));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.5, 12.75, 1.075));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5, 12.75, 1.075));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5, 11.25, 1.075));
    endZones.add(new endZone(13, 7, 2, 2));
    coins.add(new coin(19.5, 11.5));
    coins.add(new coin(19.5, 12.5));
    coins.add(new coin(20.5, 11.5));
    coins.add(new coin(20.5, 12.5));
  }

  void level26() {

    for (int i=0; i<28; i++) { //horizontal edges
      if (i!=17 && i!=18)blocks.add(new block(i, 0));
    }
    for (int i=0; i<14; i++) { //vertical edges
      for (int j=0; j<8; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
      blocks.add(new block(8, i));
    }
    for (int i=12; i<16; i++) {
      blocks.add(new block(i, 1));
    }
    for (int i=16; i<20; i++) {
      blocks.add(new block(i, 10));
      blocks.add(new block(i, 11));
      blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    blocks.add(new block(16, 9));
    blocks.add(new block(19, 9));
    for (int i=9; i<13; i++) {
      blocks.add(new block(i, 9));
    }
    blocks.add(new block(12, 8));
    blocks.add(new block(12, 10));
    triBlocks.add(new triBlock(16, 8, 7, false));
    triBlocks.add(new triBlock(17, 9, 7, false));
    triBlocks.add(new triBlock(19, 8, 5, false));
    triBlocks.add(new triBlock(18, 9, 5, false));
    triBlocks.add(new triBlock(16, 1, 1, false));
    triBlocks.add(new triBlock(17, 0, 1, false));
    triBlocks.add(new triBlock(19, 1, 3, false));
    triBlocks.add(new triBlock(18, 0, 3, false));
    lasers.add(new laser(10.5, 8.5, 0, 4));
    triggers.add(new trigger(18, 1, 4, false));
    triggers.add(new trigger(18, 9, 4, false));
    doors.add(new door(13, 8, 16, 8, 4));
    triBlocks.add(new triBlock(17.5, 4.5, 5, true));
    radialEnemies.add(new radialEnemy(11, 5, 1.75, 4, 15, 3, 3, 3, 0, 0, true));
    radialEnemies.add(new radialEnemy(14.5, 12.5, 1.25, 3, 15, 2, 3, 3, 0, 0, false));
    radialEnemies.add(new radialEnemy(10.5, 12.5, 1.25, 3, 15, 2, 3, 3, 0, 0, false));
    enemyArrays.add(new enemy(2, 2, 15, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 11.25, 1));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(12.5, 13.75, 1));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 7.75, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 7.75, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75, 7.75, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 7.75, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 7, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 7, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 7, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75, 7, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 2.25, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 2.25, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75, 2.25, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 2.25, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 3, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(9.25, 3, 2));
    enemyArrays.add(new enemy(2, 1, 0, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14, 3, 2));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(18.75, 3, 2));
    enemyArrays.add(new enemy(1, 4, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 4.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 3.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 3.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 4.75, 1.5));
    enemyArrays.add(new enemy(1, 4, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 5.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.25, 6.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 6.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.75, 5.25, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.25, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.25, 10.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.25, 10.75, 1.5));
    enemyArrays.add(new enemy(1, 3, 10, 0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.75, 9.25, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.75, 10.75, 1.5));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.75, 10.75, 1.5));
    coins.add(new coin(9.5, 10.5));
    coins.add(new coin(10.5, 10.5));
    coins.add(new coin(11.5, 10.5));
    endZones.add(new endZone(9, 1, 3, 1));
  }

  void level27() {

    for (int i=0; i<28; i++) { //horizontal edges
      if(i!=10&&i!=11)blocks.add(new block(i, 0));
      if(i!=10&&i!=11)blocks.add(new block(i, 1));
      if(i!=10&&i!=11)blocks.add(new block(i, 11));
      if(i!=10&&i!=11)blocks.add(new block(i, 12));
      blocks.add(new block(i, 13));
    }
    for (int i=0; i<14; i++) { //vertical edges
      for (int j=0; j<10; j++) {
        blocks.add(new block(j, i)); 
        blocks.add(new block(27-j, i));
      }
    }
    for (int i=13; i<18; i++) {
      blocks.add(new block(i, 2));
      if(i>13)blocks.add(new block(i, 3));
      if(i>14)blocks.add(new block(i, 4));
    }
    blocks.add(new block(14, 9));
    blocks.add(new block(15, 9));
    blocks.add(new block(15, 10));
    triBlocks.add(new triBlock(12,2,3,false));
    triBlocks.add(new triBlock(13,3,3,false));
    triBlocks.add(new triBlock(14,4,3,false));
    triBlocks.add(new triBlock(17,5,3,false));
    triBlocks.get(triBlocks.size()-1).edges[1].mirror=true;
    triBlocks.add(new triBlock(14,8,5,false));
    triBlocks.add(new triBlock(15,8,7,false));
    buttons.add(new button(10.5,3.5,3,true));
    triggers.add(new trigger(14.5,10.5,4,false));
    lasers.add(new laser(17.5,10.5,0,4));
    doors.add(new door(15,5,15,8,3));
    doors.add(new door(10,2,12,2,4));
    triBlocks.add(new triBlock(13,5,1,true));
    triBlocks.add(new triBlock(12,5,3,true));
    radialEnemies.add(new radialEnemy(12.5,7.5,1.25,3,15,2,3,3,0,0,true));
    enemyArrays.add(new enemy(2,2,10,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.25,9.5,1.6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.75,9.5,1.6));
    enemyArrays.add(new enemy(2,2,10,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(13.75,4.5,1.6));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.25,4.5,1.6));
    enemyArrays.add(new enemy(2,1,0,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5,8.5,2.15));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(10.5,6.5,2.15));
    enemyArrays.add(new enemy(2,1,0,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5,5.5,2.15));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(14.5,7.5,2.15));
    enemyArrays.add(new enemy(2,1,0,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.5,7.5,2.15));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(15.5,5.5,2.15));
    enemyArrays.add(new enemy(2,1,0,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5,5.5,2.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(16.5,9,2.25));
    enemyArrays.add(new enemy(2,1,0,0));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5,9.5,2.25));
    enemyArrays.get(enemyArrays.size()-1).paths.add(new path(17.5,6,2.25));
    coins.add(new coin(10.5,0.5));
    coins.add(new coin(11.5,0.5));
    coins.add(new coin(10.5,1.5));
    coins.add(new coin(11.5,1.5));
    endZones.add(new endZone(10,11,2,2));
  }
}
