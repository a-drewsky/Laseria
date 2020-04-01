class saveData {

  PVector moverPosS;
  boolean[] laserStates;
  float[] laserRotationS;
  PVector[] triBlockPos;
  int[] triBlockRot;
  boolean[] triBlockMovable;

  ArrayList<Integer>[] enemyGapsS;
  ArrayList<Integer>[] radEnemyGapsS;

  ArrayList<PVector> coinPosS;

  ArrayList<Float>[] enemyTimeS;
  ArrayList<Integer>[] enemyPathNumS;
  ArrayList<PVector>[] enemyStartLocS;
  ArrayList<PVector>[] enemyTargetS;
  boolean[] enemyReverseS;
  ArrayList<Float>[] enemyFadeTimesS;
  ArrayList<Boolean>[] enemyDyingS;

  ArrayList<enemy> enemyArraysS;
  ArrayList<radialEnemy> radialEnemiesS;

  boolean[] radEnemyReverseS;
  float[] radEnemyRotS;
  ArrayList<Float>[] radEnemyFadeTimesS;
  ArrayList<Boolean>[] radEnemyDyingS;

  boolean[] buttonsS;
  boolean[] triggersS;


  saveData() {
  }

  void saveState() {

    enemyArraysS = new ArrayList(enemyArrays);
    radialEnemiesS = new ArrayList(radialEnemies);

    moverPosS = new PVector(Mover.pos.x, Mover.pos.y);
    triBlockPos = new PVector[triBlocks.size()];
    for (int i=0; i<triBlockPos.length; i++) {
      triBlockPos[i] = new PVector(triBlocks.get(i).pos.x, triBlocks.get(i).pos.y);
    }
    triBlockRot = new int[triBlocks.size()];
    for (int i=0; i<triBlockRot.length; i++) {
      triBlockRot[i] = new Integer(triBlocks.get(i).rotation);
    }
    enemyGapsS = new ArrayList[enemyArrays.size()];
    for (int i=0; i<enemyGapsS.length; i++) {
      enemyGapsS[i] = new ArrayList<Integer>();
      enemyGapsS[i].clear();
      for (int j=0; j<enemyArrays.get(i).gaps.size(); j++) {
        enemyGapsS[i].add(new Integer(enemyArrays.get(i).gaps.get(j)));
      }
    }

    buttonsS = new boolean[buttons.size()];
    for (int i=0; i<buttonsS.length; i++) {
      buttonsS[i] = buttons.get(i).triggered;
    }
    triggersS = new boolean[triggers.size()];
    for (int i=0; i<triggersS.length; i++) {
      triggersS[i] = triggers.get(i).triggered;
    }

    radEnemyGapsS = new ArrayList[radialEnemies.size()];
    for (int i=0; i<radEnemyGapsS.length; i++) {
      radEnemyGapsS[i] = new ArrayList<Integer>();
      radEnemyGapsS[i].clear();
      for (int j=0; j<radialEnemies.get(i).gaps.size(); j++) {
        radEnemyGapsS[i].add(new Integer(radialEnemies.get(i).gaps.get(j)));
      }
    }

    coinPosS = new ArrayList<PVector>();
    coinPosS.clear();
    for (int i=0; i<coins.size(); i++) {
      coinPosS.add(new PVector(coins.get(i).pos.x/Grid.Xiteration, coins.get(i).pos.y/Grid.Yiteration-1));
    }
    laserStates = new boolean[lasers.size()];
    for (int i=0; i<laserStates.length; i++) {
      laserStates[i] = lasers.get(i).fire;
    }
    laserRotationS = new float[lasers.size()];
    for (int i=0; i<laserRotationS.length; i++) {
      laserRotationS[i] = lasers.get(i).rotation;
    }

    //Enemy Data
    enemyReverseS = new boolean[enemyArrays.size()];
    enemyTimeS = new ArrayList[enemyArrays.size()];
    enemyPathNumS = new ArrayList[enemyArrays.size()];
    enemyStartLocS = new ArrayList[enemyArrays.size()];
    enemyTargetS = new ArrayList[enemyArrays.size()];
    enemyFadeTimesS = new ArrayList[enemyArrays.size()];
    enemyDyingS = new ArrayList[enemyArrays.size()];
    for (int i=0; i<enemyArrays.size(); i++) {
      enemyReverseS[i] = enemyArrays.get(i).goReverse;
      enemyTimeS[i] = new ArrayList<Float>();
      enemyTimeS[i].clear();
      for (int j=0; j<enemyArrays.get(i).time.length; j++) {
        enemyTimeS[i].add(new Float(enemyArrays.get(i).time[j]));
      }
      enemyPathNumS[i] = new ArrayList<Integer>();
      enemyPathNumS[i].clear();
      for (int j=0; j<enemyArrays.get(i).curPathNum.length; j++) {
        enemyPathNumS[i].add(new Integer(enemyArrays.get(i).curPathNum[j]));
      }
      enemyStartLocS[i] = new ArrayList<PVector>();
      enemyStartLocS[i].clear();
      for (int j=0; j<enemyArrays.get(i).curStartLoc.length; j++) {
        enemyStartLocS[i].add(new PVector(enemyArrays.get(i).curStartLoc[j].x, enemyArrays.get(i).curStartLoc[j].y));
      }
      enemyTargetS[i] = new ArrayList<PVector>();
      enemyTargetS[i].clear();
      for (int j=0; j<enemyArrays.get(i).curTarget.length; j++) {
        enemyTargetS[i].add(new PVector(enemyArrays.get(i).curTarget[j].x, enemyArrays.get(i).curTarget[j].y));
      }
      enemyFadeTimesS[i] = new ArrayList<Float>();
      enemyFadeTimesS[i].clear();
      for (int j=0; j<enemyArrays.get(i).fadeTimes.length; j++) {
        enemyFadeTimesS[i].add(new Float(enemyArrays.get(i).fadeTimes[j]));
      }
      enemyDyingS[i] = new ArrayList<Boolean>();
      enemyDyingS[i].clear();
      for (int j=0; j<enemyArrays.get(i).dying.length; j++) {
        enemyDyingS[i].add(new Boolean(enemyArrays.get(i).dying[j]));
      }
    }

    //radial Enemy Data

    radEnemyReverseS = new boolean[radialEnemies.size()];
    radEnemyRotS = new float[radialEnemies.size()];
    radEnemyFadeTimesS = new ArrayList[radialEnemies.size()];
    radEnemyDyingS = new ArrayList[radialEnemies.size()];
    for (int i=0; i<radialEnemies.size(); i++) {
      radEnemyReverseS[i] = radialEnemies.get(i).goReverse;
      radEnemyRotS[i] = radialEnemies.get(i).curRotation;

      radEnemyFadeTimesS[i] = new ArrayList<Float>();
      radEnemyFadeTimesS[i].clear();
      for (int j=0; j<radialEnemies.get(i).fadeTimes.length; j++) {
        radEnemyFadeTimesS[i].add(new Float(radialEnemies.get(i).fadeTimes[j]));
      }
      radEnemyDyingS[i] = new ArrayList<Boolean>();
      radEnemyDyingS[i].clear();
      for (int j=0; j<radialEnemies.get(i).dying.length; j++) {
        radEnemyDyingS[i].add(new Boolean(radialEnemies.get(i).dying[j]));
      }
    }
  }
}
