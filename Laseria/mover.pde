class mover {

  PVector size = new PVector();
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();

  PVector dir = new PVector(1, 0);
  float slope = 0;

  PVector corner1;
  PVector corner2;
  PVector corner3;
  PVector corner4;
  edge[] edges = new edge[4];
  boolean goUp=false; 
  boolean goDown=false; 
  boolean goLeft=false; 
  boolean goRight=false; 
  PVector center;

  float fricCoefficient = 0.5;
  float accCoefficient = 1.2;
  float fullvLimit = 1.5;
  float halfvLimit = 0.5;
  float QuartervLimit = 0.01;
  float vLimitX = fullvLimit;
  float vLimitY = fullvLimit;

  float threshold = 0.3;

  float fadeTime;
  boolean dead = false;
  boolean showCircle;
  float hideTime;

  boolean doubleHor;
  boolean doubleVert;

  PVector circPos = new PVector();

  boolean screenSaver = false;
  float circR = 5;

  mover(int w_, int h_, float x_, float y_) {
    size.x = w_;
    size.y = h_;
    pos.x=x_;
    pos.y=y_;
    corners();
    edges();
  }

  void update() {
    center = new PVector(pos.x+(size.x/2),pos.y+(size.y/2));
    vel.limit(fullvLimit);
    vel.x = constrain(vel.x, -vLimitX, vLimitX);
    vel.y = constrain(vel.y, -vLimitY, vLimitY);
    screenEdges();
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    hideCircle();
    dirCircle();
  }


  void startScreenSaver(float x, float y) {
    screenSaver=true;
    vel.x = x;
    vel.y = y;
  }

  void screenSaver() {
    hideCircle();
    if (corner4.y>height) vel.y = -1*abs(vel.y);
    if (corner1.y<35) vel.y = 1*abs(vel.y);
    if (corner3.x>width) vel.x = -1*abs(vel.x);
    if (corner4.x<0) vel.x = 1*abs(vel.x);
  }

  void hideCircle() {
    if (gameState!=2) {
      showCircle = false;
      return;
    }
    for (int i=0; i<blocks.size(); i++) {
      block b = blocks.get(i);
      if (rectPointInt(b.pos.x, b.pos.y, b.size.x, b.size.y, circPos.x, circPos.y)) {
        showCircle = false;
        return;
      }
    }
    for (int i=0; i<triBlocks.size(); i++) {
      triBlock tb = triBlocks.get(i);
      if (triPointInt(tb.corner1.x, tb.corner1.y, tb.corner2.x, tb.corner2.y, tb.corner3.x, tb.corner3.y, circPos.x, circPos.y) && !tb.movable) {
        showCircle = false;
        return;
      }
    }
    showCircle = true;
  }

  void dirCircle() {
    fill(220, 130, 90);
    noStroke();

    float x;
    float xn;
    float xd;
    float y;
    if (vel.x != 0 || vel.y != 0) {
      dir.x = vel.x;
      dir.y = vel.y;
    }
    dir.normalize();
    if (dir.x!=0) {
      slope = dir.y/dir.x;
      xn = pow((size.x/2), (1/4));
      xd = slope + 1;

      if (xd>1 || xd<-1) {
        x = xn/xd;
        y= slope * x;
        circPos = new PVector(pos.x+(size.x/1.85)+x+(dir.x*18), pos.y+(size.y/2.15)+y+(dir.y*18));
      } else {
        slope = -slope;
        xd = slope + 1;
        x = (xn/xd)*-1;
        y= (slope * x)*-1;
        circPos = new PVector(pos.x+(size.x/1.85)+x+(dir.x*18), pos.y+(size.y/2.15)+y+(dir.y*18));
      }
    } else {
      if (dir.y>0)circPos = new PVector(pos.x+(size.x/1.85)+0, pos.y+(size.y/2.15)+18);
      if (dir.y<0)circPos = new PVector(pos.x+(size.x/1.85)+0, pos.y+(size.y/2.15)-18);
    }
    if (showCircle)circle(circPos.x, circPos.y, circR*2);
  }

  void screenEdges() {
    if (pos.y>height-size.y) {
      hideCircle();
      pos.y=height-size.y;
    }
    if (pos.y<35) {
      hideCircle();
      pos.y=35;
    }
    if (pos.x>width-size.x) {
      hideCircle();
      pos.x=width-size.x;
    }
    if (pos.x<0) {
      hideCircle();
      pos.x=0;
    }
  }

  void show() {
    if (!dead) {
      strokeWeight(2);
      stroke(150, 75, 38);
      fill(200, 100, 50);
      rect(pos.x, pos.y, size.x, size.y, size.x/2.5);
    } else {
      strokeWeight(2);
      stroke(150, 75, 38, map(fadeTime, 0, fadeT, 0, 255));
      fill(200, 100, 50, map(fadeTime, 0, fadeT, 0, 255));
      rect(pos.x, pos.y, size.x, size.y, size.x/2.5);
    }
    if (hideTime!=0) {
      hideTime-=1;
    } else {
      showCircle = true;
    }
  }

  void corners() {
    corner1 = new PVector(pos.x, pos.y);
    corner2 = new PVector(pos.x + size.x, pos.y);
    corner3 = new PVector(pos.x + size.x, pos.y + size.y);
    corner4 = new PVector(pos.x, pos.y + size.y);
  }
  void edges() {
    edges[0] = new edge(corner1.x, corner1.y, corner2.x, corner2.y);
    edges[1] = new edge(corner2.x, corner2.y, corner3.x, corner3.y);
    edges[2] = new edge(corner3.x, corner3.y, corner4.x, corner4.y);
    edges[3] = new edge(corner4.x, corner4.y, corner1.x, corner1.y);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void friction() {
    if (vel.mag()<threshold && !goUp && !goDown && !goLeft && !goRight) { 
      vel.set(0, 0); 
      return;
    }
    PVector friction = new PVector();
    friction.set(vel); 
    friction.mult(-1);
    friction.normalize();
    friction.mult(fricCoefficient);
    applyForce(friction);
  }


  boolean canGoUp(){
    for(int i=0; i<blocks.size(); i++){
      block b = blocks.get(i);
       if((intersection(b.edges[2],edges[3]) || intersection(b.edges[2],edges[1])) && b.edges[2].open && b.edges[2].v1.y<center.y) return false;
    }
    for(int i=0; i<triBlocks.size(); i++){
      triBlock t = triBlocks.get(i);
       for(int j=0; j<3; j++){
         if(((intersection(t.edges[j],edges[3])&& intersectionPoint(t.edges[j],edges[3]).y<center.y) || (intersection(t.edges[j],edges[1])&& intersectionPoint(t.edges[j],edges[1]).y<center.y))
         && t.edges[j].open){
           if(j==1 && (t.rotation==7||t.rotation==5)) return true;
           return false;
         }
       }
    }
    for(int i=0; i<doors.size(); i++){
      door dr = doors.get(i);
      edge d = new edge(dr.v1.x,dr.v1.y,dr.v2.x,dr.v2.y);
      if((intersection(d,edges[3]) && intersectionPoint(d,edges[3]).y<center.y) || (intersection(d,edges[1]) && intersectionPoint(d,edges[1]).y<center.y)) return false;
    }
   return true; 
  }
  boolean canGoDown(){
    for(int i=0; i<blocks.size(); i++){
      block b = blocks.get(i);
       if((intersection(b.edges[0],edges[3]) || intersection(b.edges[0],edges[1])) && b.edges[0].open && b.edges[0].v1.y>center.y) return false;
    }
    for(int i=0; i<triBlocks.size(); i++){
      triBlock t = triBlocks.get(i);
       for(int j=0; j<3; j++){
         if(((intersection(t.edges[j],edges[3])&& intersectionPoint(t.edges[j],edges[3]).y>center.y) || (intersection(t.edges[j],edges[1])&& intersectionPoint(t.edges[j],edges[1]).y>center.y))
         && t.edges[j].open){
           if(j==1 && (t.rotation==3||t.rotation==1)) return true;
           return false;
         }
       }
    }
    for(int i=0; i<doors.size(); i++){
      door dr = doors.get(i);
      edge d = new edge(dr.v1.x,dr.v1.y,dr.v2.x,dr.v2.y);
      if((intersection(d,edges[3]) && intersectionPoint(d,edges[3]).y>center.y) || (intersection(d,edges[1]) && intersectionPoint(d,edges[1]).y>center.y)) return false;
    }
   return true; 
  }
  boolean canGoLeft(){
    for(int i=0; i<blocks.size(); i++){
      block b = blocks.get(i);
       if((intersection(b.edges[1],edges[2]) || intersection(b.edges[1],edges[0])) && b.edges[1].open && b.edges[1].v1.x<center.x) return false;
    }
    for(int i=0; i<triBlocks.size(); i++){
      triBlock t = triBlocks.get(i);
       for(int j=0; j<3; j++){
         if(((intersection(t.edges[j],edges[2])&& intersectionPoint(t.edges[j],edges[2]).x<center.x) || (intersection(t.edges[j],edges[0])&& intersectionPoint(t.edges[j],edges[0]).x<center.x))
         && t.edges[j].open){
           if(j==1 && (t.rotation==3||t.rotation==5)) return true;
           return false;
         }
       }
    }
    for(int i=0; i<doors.size(); i++){
      door dr = doors.get(i);
      edge d = new edge(dr.v1.x,dr.v1.y,dr.v2.x,dr.v2.y);
      if((intersection(d,edges[2]) && intersectionPoint(d,edges[2]).x<center.x) || (intersection(d,edges[0]) && intersectionPoint(d,edges[0]).x<center.x)) return false;
    }
   return true; 
  }
  boolean canGoRight(){
    for(int i=0; i<blocks.size(); i++){
      block b = blocks.get(i);
       if((intersection(b.edges[3],edges[2]) || intersection(b.edges[3],edges[0])) && b.edges[3].open && b.edges[3].v1.x>center.x) return false;
    }
    for(int i=0; i<triBlocks.size(); i++){
      triBlock t = triBlocks.get(i);
       for(int j=0; j<3; j++){
         if(((intersection(t.edges[j],edges[2])&& intersectionPoint(t.edges[j],edges[2]).x>center.x) || (intersection(t.edges[j],edges[0])&& intersectionPoint(t.edges[j],edges[0]).x>center.x))
         && t.edges[j].open){
           if(j==1 && (t.rotation==1||t.rotation==7)) return true;
           return false;
         }
       }
    }
    for(int i=0; i<doors.size(); i++){
      door dr = doors.get(i);
      edge d = new edge(dr.v1.x,dr.v1.y,dr.v2.x,dr.v2.y);
      if((intersection(d,edges[2]) && intersectionPoint(d,edges[2]).x>center.x) || (intersection(d,edges[0]) && intersectionPoint(d,edges[0]).x>center.x)) return false;
    }
   return true; 
  }


  void movement() {
    if (goRight && goLeft) {
      return;
    }
    if (goUp && goDown) {
      return;
    }
    PVector right = new PVector(accCoefficient, 0);
    PVector left = new PVector(-accCoefficient, 0);
    PVector up = new PVector(0, -accCoefficient);
    PVector down = new PVector(0, accCoefficient);

    if (goRight) applyForce(right);
    if (goLeft) applyForce(left);
    if (goUp) applyForce(up);
    if (goDown) applyForce(down);
  }
}
