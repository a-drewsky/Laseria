class block {
  PVector pos;
  PVector size;
  PVector corner1;
  PVector corner2;
  PVector corner3;
  PVector corner4;
  edge[] edges = new edge[4];

  block(int Xp, int Yp) {
    pos = new PVector(Grid.positions[Xp][Yp].x, Grid.positions[Xp][Yp].y);
    size = new PVector(Grid.Xiteration, Grid.Yiteration);
    corners();
    edges();
  }

  void show() {
    if (texturesOn) {
      if (levelNum-1>=0 && levelNum-1<=2) copy(textures[0], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=3 && levelNum-1<=5) copy(textures[1], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=6 && levelNum-1<=8) copy(textures[2], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=9 && levelNum-1<=11) copy(textures[3], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=12 && levelNum-1<=14) copy(textures[4], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=15 && levelNum-1<=17) copy(textures[5], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=18 && levelNum-1<=20) copy(textures[6], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=21 && levelNum-1<=23) copy(textures[7], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1>=24 && levelNum-1<=26) copy(textures[8], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
      if (levelNum-1==27) copy(textures[9], (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1, (int)pos.x, (int)pos.y, (int)size.x+1, (int)size.y+1);
    } else {  
      noStroke();
      fill(100, 100, 200);
      rect(pos.x, pos.y, size.x, size.y);
    }
  }

  void showStroke() {
    if (texturesOn) {
      if (levelNum-1>=0 && levelNum-1<=2) stroke(blockStrokes[0]);
      if (levelNum-1>=3 && levelNum-1<=5) stroke(blockStrokes[1]);
      if (levelNum-1>=6 && levelNum-1<=8) stroke(blockStrokes[2]);
      if (levelNum-1>=9 && levelNum-1<=11) stroke(blockStrokes[3]);
      if (levelNum-1>=12 && levelNum-1<=14) stroke(blockStrokes[4]);
      if (levelNum-1>=15 && levelNum-1<=17) stroke(blockStrokes[5]);
      if (levelNum-1>=18 && levelNum-1<=20) stroke(blockStrokes[6]);
      if (levelNum-1>=21 && levelNum-1<=23) stroke(blockStrokes[7]);
      if (levelNum-1>=24 && levelNum-1<=26) stroke(blockStrokes[8]);
      if (levelNum-1==27) stroke(blockStrokes[9]);
    } else stroke(75, 75, 150);
    strokeWeight(5);
    if (edges[0].open == true) line(corner1.x, corner1.y, corner2.x, corner2.y);
    if (edges[1].open == true) line(corner2.x, corner2.y, corner3.x, corner3.y);
    if (edges[2].open == true) line(corner3.x, corner3.y, corner4.x, corner4.y);
    if (edges[3].open == true) line(corner4.x, corner4.y, corner1.x, corner1.y);
  }

  void showMirrors() {
    stroke(200);
    strokeWeight(5);
    if (edges[0].mirror == true) line(corner1.x, corner1.y, corner2.x, corner2.y);
    if (edges[1].mirror == true) line(corner2.x, corner2.y, corner3.x, corner3.y);
    if (edges[2].mirror == true) line(corner3.x, corner3.y, corner4.x, corner4.y);
    if (edges[3].mirror == true) line(corner4.x, corner4.y, corner1.x, corner1.y);
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
}


class deathBlock {
  levelBuilder LB = new levelBuilder();
  PVector pos;
  PVector size;
  PVector corners[];
  edge[] edges = new edge[4];

  deathBlock(int Xp, int Yp) {
    pos = new PVector(Grid.positions[Xp][Yp].x, Grid.positions[Xp][Yp].y);
    size = new PVector(Grid.Xiteration, Grid.Yiteration);
    corners = new PVector[4];
    corners();
    edges();
  }

  void show() {
    noStroke();
    fill(200, 50, 50);
    rect(pos.x, pos.y, size.x, size.y);
  }

  void showStroke() {
    stroke(250, 150, 100);
    strokeWeight(4);
    if (edges[0].open == true) line(corners[0].x, corners[0].y, corners[1].x, corners[1].y);
    if (edges[1].open == true) line(corners[1].x, corners[1].y, corners[2].x, corners[2].y);
    if (edges[2].open == true) line(corners[2].x, corners[2].y, corners[3].x, corners[3].y);
    if (edges[3].open == true) line(corners[3].x, corners[3].y, corners[0].x, corners[0].y);
  }

  void corners() {
    corners[0] = new PVector(pos.x, pos.y);
    corners[1] = new PVector(pos.x + size.x, pos.y);
    corners[2] = new PVector(pos.x + size.x, pos.y + size.y);
    corners[3] = new PVector(pos.x, pos.y + size.y);
  } 
  void edges() {
    edges[0] = new edge(corners[0].x, corners[0].y, corners[1].x, corners[1].y);
    edges[1] = new edge(corners[1].x, corners[1].y, corners[2].x, corners[2].y);
    edges[2] = new edge(corners[2].x, corners[2].y, corners[3].x, corners[3].y);
    edges[3] = new edge(corners[3].x, corners[3].y, corners[0].x, corners[0].y);
  }
}

class triDeathBlock {
  levelBuilder LB = new levelBuilder();
  PVector pos;
  PVector size;
  PVector corners[];
  edge[] edges;
  int rotation;

  triDeathBlock(int Xp, int Yp, int rotation_) {
    pos = new PVector(Grid.positions[Xp][Yp].x, Grid.positions[Xp][Yp].y);
    size = new PVector(Grid.Xiteration, Grid.Yiteration);
    corners = new PVector[3];
    rotation=rotation_;
    corners();
    edges = new edge[3];
    edges();
  }

  void show() {
    noStroke();
    fill(200, 50, 50);
    triangle(corners[0].x, corners[0].y, corners[1].x, corners[1].y, corners[2].x, corners[2].y);
  }

  void showStroke() {
    stroke(250, 150, 100);
    strokeWeight(4);
    if (edges[0].open == true) line(corners[0].x, corners[0].y, corners[1].x, corners[1].y);
    if (edges[1].open == true) line(corners[1].x, corners[1].y, corners[2].x, corners[2].y);
    if (edges[2].open == true) line(corners[2].x, corners[2].y, corners[0].x, corners[0].y);
  }

  void corners() {
    if (rotation==1) {
      corners[0] = new PVector(pos.x, pos.y);
      corners[1] = new PVector(pos.x + size.x, pos.y);
      corners[2] = new PVector(pos.x, pos.y + size.y);
    }
    if (rotation==3) {
      corners[0] = new PVector(pos.x + size.x, pos.y);
      corners[1] = new PVector(pos.x + size.x, pos.y + size.y);
      corners[2] = new PVector(pos.x, pos.y);
    }
    if (rotation==5) {
      corners[0] = new PVector(pos.x + size.x, pos.y + size.y);
      corners[1] = new PVector(pos.x, pos.y + size.y);
      corners[2] = new PVector(pos.x + size.x, pos.y);
    }
    if (rotation==7) {
      corners[0] = new PVector(pos.x, pos.y + size.y);
      corners[1] = new PVector(pos.x, pos.y);
      corners[2] = new PVector(pos.x + size.x, pos.y + size.y);
    }
  } 
  void edges() {
    edges[0] = new edge(corners[0].x, corners[0].y, corners[1].x, corners[1].y);
    edges[1] = new edge(corners[1].x, corners[1].y, corners[2].x, corners[2].y);
    edges[2] = new edge(corners[2].x, corners[2].y, corners[0].x, corners[0].y);
  }
}


class endZone {

  PVector pos;
  int w;
  int h;
  color notDone = color(50, 200, 50, 80);
  color done = color(50, 200, 50);
  PVector corner1;
  PVector corner2;
  PVector corner3;
  PVector corner4;
  edge edges[];
  endZone(int Xp, int Yp, int _w, int _h) {
    pos = new PVector(Xp*Grid.Xiteration, Yp*Grid.Yiteration+35);
    w=_w * Grid.Xiteration;
    h=_h * Grid.Yiteration;
    edges = new edge[4];
    corners();
    edges();
  }

  void corners() {
    corner1 = new PVector(pos.x, pos.y);
    corner2 = new PVector(pos.x + w, pos.y);
    corner3 = new PVector(pos.x + w, pos.y + h);
    corner4 = new PVector(pos.x, pos.y + h);
  }
  void edges() {
    edges[0] = new edge(corner1.x, corner1.y, corner2.x, corner2.y);
    edges[1] = new edge(corner2.x, corner2.y, corner3.x, corner3.y);
    edges[2] = new edge(corner3.x, corner3.y, corner4.x, corner4.y);
    edges[3] = new edge(corner4.x, corner4.y, corner1.x, corner1.y);
  }

  void show() {
    noStroke();
    if (Mover.corner1.y+3>pos.y && Mover.corner4.y-3<pos.y+h
      && Mover.corner1.x+3>pos.x && Mover.corner2.x-3<pos.x+w) {
      if (objectivesComplete) {
        if(gameState==2 && soundOn) endLevelSound.play();
        stopMoverTime=2;
        awardStars();
        fill(done);
        gameState=4;
      } else {
        Gui.ONCMessage();
        fill(notDone);
      }
    } else {
      fill(notDone);
    }
    rect(pos.x, pos.y, w, h);
  }
}
