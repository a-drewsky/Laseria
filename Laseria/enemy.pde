class enemy {

  PVector[] enemies;
  float size = enemySize;
  int type;
  ArrayList <path> paths;
  float[] time;
  path[] curPath;
  PVector[] curStartLoc;
  PVector[] curTarget;
  boolean pathInitialized = false;
  float[] curSpeed;
  int pathCount;
  int[] curPathNum;
  boolean goReverse = false;

  int enemyAmount;
  float spread;
  int arrayNum;

  float displacement;

  int[] frequencies;

  float[] fadeTimes;
  boolean[] dying;

  ArrayList<Integer> gaps;

  enemy(int type_, int ea, float spread_, float d) {
    enemies = new PVector[ea];
    gaps = new ArrayList<Integer>();
    enemyAmount = ea;
    spread = spread_;
    type = type_;
    paths = new ArrayList<path>();
    curPathNum = new int[ea];
    curPath = new path[ea];
    curStartLoc = new PVector[ea];
    curTarget = new PVector[ea];
    curSpeed = new float[ea];
    time = new float[ea];
    frequencies = new int[ea];
    fadeTimes = new float[ea];
    dying = new boolean[ea];
    displacement = d;
    initialize();
  }

  void initialize() {

    for (int i=0; i<enemyAmount; i++) {
      frequencies[i] = 0;
      if (!gaps.contains(i)) {
        enemies[i] = new PVector(); 
        curPathNum[i] = 1;
        time[i] = displacement+i*spread;
      }
    }
  }


  void enemyFade(int i) {
    if (fadeTimes[i]<=0) { 
      gaps.add(i);
    } else {
      fadeTimes[i]-=1;
    }
  }

  void show() {
    for (int i=0; i<enemyAmount; i++) {
      if (!gaps.contains(i)) {
        strokeWeight(3);
        if (!dying[i])stroke(enStroke);
        else stroke(enStroke, map(fadeTimes[i], 0, fadeT, 0, 255));

        if (frequencies[i]==0)fill(enColor);
        else if (frequencies[i]==1) {
          if (!dying[i])fill(col1);
          else fill(col1, map(fadeTimes[i], 0, fadeT, 0, 255));
        } else if (frequencies[i]==2) {
          if (!dying[i])fill(col2);
          else fill(col2, map(fadeTimes[i], 0, fadeT, 0, 255));
        } else if (frequencies[i]==3) {
          if (!dying[i])fill(col3);
          else fill(col3, map(fadeTimes[i], 0, fadeT, 0, 255));
        } else if (frequencies[i]==4) {
          if (!dying[i])fill(col4);
          else fill(col4, map(fadeTimes[i], 0, fadeT, 0, 255));
        }
        ellipseMode(CENTER);
        ellipse(enemies[i].x, enemies[i].y, size, size);
      }
    }
  }

  void nextPath(int n) {
    if (type==2) {
      if (goReverse == false) {
        if (curPathNum[n] == pathCount) {
          goReverse = true;
          for (int i=0; i<enemyAmount; i++) {
            if (!gaps.contains(i)) {
              curPath[i] = paths.get(pathCount-1);
              curPathNum[i] = pathCount-1;
              curSpeed[i] = paths.get(pathCount).speed;
              curTarget[i] = curPath[i].pos;
              curStartLoc[i] = paths.get(pathCount).pos;
              time[i] = 0+i*spread;
              float d = dist(curStartLoc[i].x, curStartLoc[i].y, curTarget[i].x, curTarget[i].y);
              if ((paths.get(pathCount).speed*time[i])/d>1) {
                println("error!!! --- enemy spread too high on enemyArray: " + arrayNum);
              }
            }
          }
        } else {
          curStartLoc[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
          curPathNum[n]+=1;
          curPath[n] = paths.get(curPathNum[n]);
          curTarget[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
          curSpeed[n] = paths.get(curPathNum[n]).speed;
        }
      } else { //if(goReverse == true)
        if (curPathNum[n] == 0) {
          goReverse = false;
          for (int i=0; i<enemyAmount; i++) {
            if (!gaps.contains(i)) {
              curPath[i] = paths.get(1);
              curPathNum[i] = 1;
              curTarget[i] = curPath[i].pos;
              curStartLoc[i] = paths.get(0).pos;
              curSpeed[i] = paths.get(1).speed;
              time[i] = 0+i*spread;
            }
          }
        } else {
          curStartLoc[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
          curPathNum[n]-=1;
          curPath[n] = paths.get(curPathNum[n]);
          curTarget[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
          curSpeed[n] = paths.get(curPathNum[n]+1).speed;
        }
      }
    }
    if (type==1) {
      if (curPathNum[n] == pathCount) {

        curStartLoc[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
        curPathNum[n]=0;
        curPath[n] = paths.get(curPathNum[n]);
        curTarget[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
        curSpeed[n] = curPath[n].speed;
      } else {
        curStartLoc[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
        curPathNum[n]+=1;
        curPath[n] = paths.get(curPathNum[n]);
        curTarget[n] = new PVector(curPath[n].pos.x, curPath[n].pos.y);
        curSpeed[n] = curPath[n].speed;
      }
    }
  }

  void initializePath() {
    for (int i=0; i<enemyAmount; i++) {
      if (!gaps.contains(i)) {

        curPath[i] = paths.get(curPathNum[i]);
        curTarget[i] = new PVector(curPath[i].pos.x, curPath[i].pos.y);
        curStartLoc[i] = new PVector(paths.get(curPathNum[i]-1).pos.x, paths.get(curPathNum[i]-1).pos.y);
        curSpeed[i] = curPath[i].speed;

        pathCount = paths.size()-1;
        pathInitialized = true;

        if (type==3) {
          float d = dist(curStartLoc[i].x, curStartLoc[i].y, curTarget[i].x, curTarget[i].y);
          enemies[i].x=lerp(curStartLoc[i].x, curTarget[i].x, (time[i])/d);
          enemies[i].y=lerp(curStartLoc[i].y, curTarget[i].y, (time[i])/d);
        }
      }
    }
  }

  void update() {
    for (int i=0; i<enemyAmount; i++) if (dying[i] && !gaps.contains(i)) enemyFade(i);

    float s;
    if (pathInitialized == false) {
      initializePath();
    }
    for (int i=0; i<enemyAmount; i++) {
      if (!gaps.contains(i) && type!=3) {
        if (goReverse) {
          s = paths.get(curPathNum[i]+1).speed;
        } else { 
          s = curPath[i].speed;
        }
        time[i] +=1;
        float d = dist(curStartLoc[i].x, curStartLoc[i].y, curTarget[i].x, curTarget[i].y);
        if (type==2 || type==1) {

          if ((s*time[i])/d<1) {

            if (!dying[i])enemies[i].x=lerp(curStartLoc[i].x, curTarget[i].x, (s*time[i])/d);
            if (!dying[i])enemies[i].y=lerp(curStartLoc[i].y, curTarget[i].y, (s*time[i])/d);
          } else {
            time[i] = 0;
            nextPath(i);
          }
        }
      }
    }
  }
}
