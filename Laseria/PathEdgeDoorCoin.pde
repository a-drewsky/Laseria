class path {

  PVector pos;
  float speed;

  path(float x, float y, float speed_) {
    pos = new PVector((x*Grid.Xiteration), (y*Grid.Yiteration+35));
    speed = speed_*1.1; //sets speed 2 equal to max mover speed
  }
}


class edge {
  PVector v1 = new PVector();
  PVector v2 = new PVector();
  boolean open;
  boolean mirror;

  edge(float x1, float y1, float x2, float y2) {
    v1.x = x1;
    v1.y = y1;
    v2.x = x2;
    v2.y = y2;
    open = true;
    mirror = false;
  }

  void mirrorTrue() {
    mirror=true;
  }
}


class door {

  PVector v1;
  PVector v2;
  int frequency;
  boolean triggered;
  color c;

  door(float _v1x, float _v1y, float _v2x, float _v2y, int freq) {
    float v1x = _v1x*Grid.Xiteration;
    float v1y = _v1y*Grid.Yiteration;
    float v2x = _v2x*Grid.Xiteration;
    float v2y = _v2y*Grid.Yiteration;
    v1 = new PVector(v1x, v1y+35);
    v2 = new PVector(v2x, v2y+35);
    frequency = freq;
    //triggered = false;
    c=freqColors[freq-1];
  }

  void show() {
    if (v1.x>v2.x) println("ERROR - a door has V1 to the right on V2! V1 must be on the left side of V2!");
    if (!triggered) {
      strokeWeight(8);
      stroke(c);
      line(v1.x, v1.y, v2.x, v2.y);
      strokeWeight(5);
      stroke(150);
      line(v1.x, v1.y, v2.x, v2.y);
    }
    
    for (int i=0; i<buttons.size(); i++) {
      if (buttons.get(i).triggered && buttons.get(i).frequency==frequency && buttons.get(i).toggle) {
        triggered = true;
        return;
      }
    }
    for (int i=0; i<triggers.size(); i++) {
      if (triggers.get(i).triggered && triggers.get(i).frequency==frequency && triggers.get(i).toggle) {
        triggered = true;
        return;
      }
    }
    
    for (int i=0; i<buttons.size(); i++) {
      if (!buttons.get(i).triggered && buttons.get(i).frequency==frequency) {
        triggered = false;
        return;
      }
    }
    for (int i=0; i<triggers.size(); i++) {
      if (!triggers.get(i).triggered && triggers.get(i).frequency==frequency) {
        triggered = false;
        return;
      }
    }
    triggered = true;
  }
}


class coin {

  PVector pos;
  float radius;
  int shineT;
  int shineX;
  int shineY;
  ArrayList<shine> shines;

  coin(float x, float y) {
    shines = new ArrayList<shine>();
    pos = new PVector(x*Grid.Xiteration, y*Grid.Yiteration+35);
    radius = coinSize;
  }

  void show() {
    ellipseMode(CENTER);
    noStroke();
    fill(170, 170, 0);
    ellipse(pos.x+2, pos.y, radius*0.8, radius);
    fill(220, 220, 0);
    ellipse(pos.x, pos.y, radius*0.8, radius);
    if(shines.size()>0)for(int i=0; i<shines.size(); i++) shines.get(i).show();

    //shine
    if (t%10==0) {
      int num = int(random(0, 100));
      if (num%5==0) {
        shineX = int(random(pos.x-radius*0.7, pos.x+radius*0.7));
        shineY = int(random(pos.y-radius*0.7, pos.y+radius*0.7));
        shines.add(new shine(shineX, shineY, this));
      }
    }
  }
}

class shine {
  PVector pos;
  int shineT;
  coin c;

  shine(float x, float y, coin c_) {
    pos = new PVector(x, y);
    shineT=0;
    c = c_;
  }

  void show() {
    rectMode(CENTER);
    if (shineT<20) {
      fill(200, 200, 120, shineT*12);
      noStroke();
      rect(pos.x, pos.y, 3, 3);
      shineT++;
    } else if (shineT<40) {
      fill(200, 200, 120, 240-shineT*6);
      noStroke();
      rect(pos.x, pos.y, 3, 3);
      shineT++;
    } else {
      rectMode(CORNER);
      c.shines.remove(this);
    }
    rectMode(CORNER);
  }
}
