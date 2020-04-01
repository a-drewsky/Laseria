class button {

  PVector pos;
  PVector size;
  float r;
  boolean triggered= false;
  int frequency;
  color c;
  color s;
  boolean toggle;
  boolean canClickMover;
  boolean canClickMirror;

  button(float Xp, float Yp, int freq, boolean toggle_) {
    pos = new PVector(Xp*Grid.Xiteration, Yp*Grid.Yiteration+35);
    size = new PVector(Grid.Xiteration, Grid.Yiteration);
    r = size.x/5;
    frequency = freq;
    c=freqColors[freq-1];
    s=freqSColors[freq-1];
    toggle = toggle_;
  }

  void triggered() {
    if(canClickMover && canClickMirror && soundOn) buttonClickSound.play();
    triggered = true;
  }

  void setCanClick(){
    for(int i=0; i<triBlocks.size(); i++){
      triBlock t = triBlocks.get(i);
      if (lineCircleInt(t.edges[0], pos, r) || lineCircleInt(t.edges[1], pos, r) || lineCircleInt(t.edges[2], pos, r)) {
        return;
      }
    }
    canClickMirror = true;
  }

  void show() {
    setCanClick();
    ellipseMode(CENTER);
    if (toggle) {
      noFill();
      stroke(0);
      strokeWeight(4);
      ellipse(pos.x, pos.y, size.x/1.5, size.y/2);
    } else {
      noFill();
      stroke(s);
      strokeWeight(4);
      ellipse(pos.x, pos.y, size.x/1.5, size.y/2);
    }
    noStroke();
    fill(150);
    ellipse(pos.x, pos.y, size.x/1.5, size.y/2);
    if (triggered) {
      fill(c);
      ellipse(pos.x, pos.y, size.x/3, size.y/4);
    } else {
      fill(240);
      rect(pos.x-size.x/5.5, pos.y-size.y/8, size.x/3, size.y/8);
      ellipse(pos.x, pos.y, size.x/3, size.y/4);

      fill(c);
      ellipse(pos.x, pos.y-size.y/7, size.x/3, size.y/4);
    }
    if (toggle)triggered = false;
  }
}


class laser {
  PVector pos;
  PVector size;
  float rotation;
  boolean fire;
  float r;
  int frequency;
  color c;
  color s;
  
  ArrayList <spark> sparks;
  float ti =0;

  laser(float Xp, float Yp, int rot, int freq) {
    pos = new PVector(Xp*Grid.Xiteration, Yp*Grid.Yiteration+35);
    size = new PVector(Grid.Xiteration, Grid.Yiteration);
    r = size.x/4;
    rotation = rot * (PI/4);
    fire = false;
    frequency = freq;
    c = freqColors[freq-1];
    s=freqSColors[freq-1];
    sparks = new ArrayList<spark>();
  }

  void rotation() {
    if (rotation > (3*PI)/2) rotation = 0; 
    else rotation += QUARTER_PI;
  }

  void fire() {
    PVector center = new PVector(pos.x, pos.y);
    beam b = new beam(0,0,0,1);
    if (rotation == 0) { //0
      b = new beam(center.x, center.y-(size.y/4)-1, 0, frequency);
      b.show();
    }
    if (rotation == PI/4) { //1
      b = new beam(center.x+(size.x/4)+1, center.y-(size.y/4)-1, 1, frequency);
      b.show();
    }
    if (rotation == PI/2) { //2
      b = new beam(center.x+(size.x/4)+1, center.y, 2, frequency);
      b.show();
    }
    if (rotation == (3*PI)/4) { //3
       b = new beam(center.x+(size.x/4)+1, center.y+(size.x/4)+1, 3, frequency);
      b.show();
    }
    if (rotation == PI) { //4
      b = new beam(center.x, center.y+(size.x/4)+1, 4, frequency);
      b.show();
    }
    if (rotation == (5*PI)/4) { //5
      b = new beam(center.x-(size.x/4)-1, center.y+(size.y/4)+1, 5, frequency);
      b.show();
    }
    if (rotation == 3*PI/2) { //6
      b = new beam(center.x-(size.x/4)-1, center.y, 6, frequency);
      b.show();
    }
    if (rotation >  3*PI/2) { //7
      b = new beam(center.x-(size.x/4)-1, center.y-(size.y/4)-1, 7, frequency);
      b.show();
    }
    
    
      PVector lastInt = b.intersections.get(b.intersections.size()-1);
     sparks.add(new spark(lastInt.x,lastInt.y, frequency)); 
    
    
  }

  void show() {
    for(int i=0; i<sparks.size(); i++){
     if(sparks.get(i).done || !fire) sparks.remove(i); 
    }
    for(int i=0; i<sparks.size(); i++)sparks.get(i).update();
    ti++;
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    ellipseMode(CENTER);
    
    noFill();
    stroke(s);
    strokeWeight(3);
    arc(0, 0, r*2, r*2, -1*QUARTER_PI, PI+QUARTER_PI, CHORD);
    triangle(-1*(size.x/8), -1*(size.y/4), (size.x/8), -1*(size.y/4), 0, -1*(size.y/2));

    noStroke();
    fill(c);
    arc(0, 0, r*2, r*2, -1*QUARTER_PI, PI+QUARTER_PI, CHORD);
    triangle(-1*(size.x/8), -1*(size.y/4), (size.x/8), -1*(size.y/4), 0, -1*(size.y/2));
    popMatrix();

    if (fire) fire();
  }
}


class trigger {
  PVector pos;
  PVector size;
  float r;
  boolean triggered= false;
  int frequency;
  color c;
  color s;
  boolean toggle;

  trigger(float Xp, float Yp, int freq, boolean toggle_) {
    pos = new PVector(Xp*Grid.Xiteration, Yp*Grid.Yiteration+35);
    size = new PVector(Grid.Xiteration, Grid.Yiteration);
    r = size.x/5;
    frequency = freq;
    c=freqColors[freq-1];
    toggle = toggle_;
    s=freqSColors[freq-1];
  }

  void triggered(int f) {
    if (f == frequency) triggered = true;
  }

  void show() {
    ellipseMode(CENTER);
    if (toggle) {
      noFill();
      strokeWeight(10);
      stroke(0);
      ellipse(pos.x, pos.y, size.x/2.5, size.y/2.5);
    }else{
      noFill();
      strokeWeight(10);
      stroke(s);
      ellipse(pos.x, pos.y, size.x/2.5, size.y/2.5);
    }
    strokeWeight(5);
    stroke(c);
    if (triggered) fill(75, 150, 75);
    else fill(250, 50, 50);
    ellipse(pos.x, pos.y, size.x/2.5, size.y/2.5);
    if (toggle)triggered = false;
    //for(int i=0; i<doors.size(); i++) doors.get(i).triggered = false;
  }
}
