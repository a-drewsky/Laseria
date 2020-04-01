class radialEnemy {

  PVector center;
  float radius;
  int enemyAmount;
  float spread;
  float speed;
  float rotationAmount;
  float type;
  float size = enemySize;

  float curRotation = 0;
  float startPos;

  boolean goReverse = false;
  PVector[] enemyPositions;
  boolean reversed;
  int spokes;

  boolean showCenter = false;

  IntList gaps;

  int[] frequencies;

  float[] fadeTimes;
  boolean[] dying;

  radialEnemy(float x_, float y_, float r, int ea, float spread_, float speed_, int type_, int spokes_, float startPos_, float rotAmt, boolean reversed_) {
    center = new PVector(x_*Grid.Xiteration, y_*Grid.Yiteration+35);
    gaps = new IntList();
    spokes = spokes_;
    radius = r*Grid.Xiteration;
    reversed = reversed_;
    curRotation = startPos_;
    startPos = startPos_;
    enemyAmount = ea;
    spread = spread_;
    speed = speed_;
    rotationAmount = rotAmt;
    type = type_;
    if (type==1||type==2) {
      enemyPositions = new PVector[ea];
      frequencies = new int[ea];
      fadeTimes = new float[ea];
      dying = new boolean[ea];
    } else {
      enemyPositions = new PVector[ea*spokes];
      frequencies = new int[ea*spokes];
      fadeTimes = new float[ea*spokes];
      dying = new boolean[ea*spokes];
    }
    initialize();
  }

  void initialize() {
    if (type==3 || type==4) {
      for (int i=0; i<enemyAmount*spokes; i++) {
        frequencies[i] = 0;
        if (!gaps.hasValue(i)) enemyPositions[i] = new PVector(0, 0);
      }
    } else {
      for (int i=0; i<enemyAmount; i++) {
        frequencies[i] = 0;
        if (!gaps.hasValue(i)) enemyPositions[i] = new PVector(0, 0);
      }
    }
    if (type==4 && rotationAmount<startPos) println("error - a radEnemy needs to swap startPos and rotationAmount");
  }

  void radEnemyFade(int i) {
    if (fadeTimes[i]<=0) { 
      gaps.append(i);
    } else {
      fadeTimes[i]-=1;
    }
  }

  void show() {
    noStroke();
    fill(0);
    if (type==1||type==2) {
      for (int i=0; i<enemyAmount; i++) {
        if (!gaps.hasValue(i)) {
          pushMatrix();  
          translate(center.x, center.y);
          noStroke();
          fill(0);
          if (showCenter) ellipse(0, 0, 5, 5);
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
          ellipse(enemyPositions[i].x, enemyPositions[i].y, size, size);

          popMatrix();
        }
      }
    } else {
      for (int i=0; i<enemyAmount*spokes; i++) {
        if (!gaps.hasValue(i)) {
          pushMatrix();  
          translate(center.x, center.y);
          noStroke();
          fill(0);
          if (showCenter) ellipse(0, 0, 5, 5);
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
          ellipse(enemyPositions[i].x, enemyPositions[i].y, size, size);

          popMatrix();
        }
      }
    }
  }

  void update() {
    if (type==1 || type==2) {
      for (int i=0; i<enemyAmount; i++) if (dying[i] && !gaps.hasValue(i)) radEnemyFade(i);
    } else {
      for (int i=0; i<enemyAmount*spokes; i++) if (dying[i] && !gaps.hasValue(i)) radEnemyFade(i);
    }
    if (type==1 || type==3) {
      if (reversed)curRotation-=0.01*speed;
      else curRotation+=0.01*speed;
    } else { //if(type==2 || type==4)
      if (curRotation<startPos || curRotation>rotationAmount) goReverse=!goReverse;
      if (goReverse) curRotation-=0.01*speed;
      else curRotation+=0.01*speed;
    }
    if (type==1 || type==2) {
      for (int i=0; i<enemyAmount; i++) {
        if (!gaps.hasValue(i) && !dying[i]) {
          pushMatrix();
          translate(center.x, center.y);
          PVector rotation = PVector.fromAngle(curRotation+spread*i);
          enemyPositions[i] = PVector.mult(rotation, radius);
          popMatrix();
        }
      }
    } else { //if(type==3 || type==4)
      int enCount = 0;
      for (int i=0; i<spokes; i++) {
        for (int j=0; j<enemyAmount; j++) {
          pushMatrix();
          translate(center.x, center.y);
          PVector rotation = PVector.fromAngle(curRotation+((2*PI)/spokes)*i);
          if (!dying[i*enemyAmount+j])enemyPositions[enCount] = PVector.mult(rotation, radius-(j*spread));
          popMatrix();
          enCount+=1;
        }
      }
    }
  }
}
