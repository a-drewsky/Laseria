class spark {

  PVector loc;

  float rads = random(2*PI);

  float endDist = (randomGaussian()*2)+8;

  float speed = (randomGaussian()*2)+10;

  PVector angle = PVector.fromAngle(rads);

  float time = 0;

  PVector p2;
  
  boolean done = false;
  
  color c;

  spark(float x, float y, int f) {
    loc = new PVector(x, y);

    speed = constrain(speed, 5, 15);
    endDist = constrain(endDist, 5, 10);

    p2 = PVector.mult(angle, endDist);
    p2 = PVector.add(loc,p2);
    c= freqColors[f-1];
  }

  void update() {

    time+= speed/10;

    float d = dist(loc.x, loc.y, p2.x, p2.y);

    PVector n = new PVector();

    n=PVector.mult(angle,time);
    n=PVector.add(loc,n);

    stroke(c);
    strokeWeight(2);
    pushMatrix();
    //translate(loc.x,loc.y);
    line(loc.x, loc.y, n.x, n.y);
    popMatrix();
    if(PVector.dist(n,loc)>=d) done = true;
  }
}
