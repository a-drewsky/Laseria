class triBlock {
  levelBuilder LB = new levelBuilder();
  PVector pos;
  PVector size;
  PVector corner1;
  PVector corner2;
  PVector corner3;
  edge[] edges = new edge[3];
  edge hor;
  edge vert;
  edge diagonal;
  edge diag1;
  edge diag2;
  int rotation;
  boolean canGoUp = true;
  boolean canGoDown = true;
  boolean canGoLeft = true;
  boolean canGoRight = true;

  boolean goingUp;
  boolean goingDown;
  boolean goingRight;
  boolean goingLeft;

  boolean movable;
  boolean touchingMover = false;
  boolean removed = false;

  PVector vel;

  float fadeTime;
  boolean dying;

  triPusher tp = new triPusher();

  triBlock(float Xp, float Yp, int r, boolean m) {
    dying=false;
    if (!m)pos = new PVector(Grid.positions[(int)Xp][(int)Yp].x, Grid.positions[(int)Xp][(int)Yp].y);
    else {
      pos = new PVector(Xp*Grid.Xiteration + Grid.Xiteration/6, Yp*Grid.Yiteration+35 + Grid.Yiteration/6);
    }
    rotation = r;
    movable = m;
    if (movable) size = new PVector(Grid.Xiteration/1.5, Grid.Yiteration/1.5);
    else size = new PVector(Grid.Xiteration, Grid.Yiteration);
    corners();
    edges();
    horVertEdges();
    vel = new PVector();
  }

  void update() {
    if (movable) {
      corners();
      edges();
      horVertEdges();
      canGoUp = true;
      canGoDown = true;
      canGoLeft = true;
      canGoRight = true;
      screenEdges();
      detectBlocks();
      detectTriBlocks();
      detectCircularObjects();
      detectDoors();
      detectMB();
      floatBack();

      goingUp=false;
      goingDown=false;
      goingLeft=false;
      goingRight=false;

      if (dying) triFade();
      if (removed) pos = new PVector(-100, -100);
    }
  }

  void screenEdges() {
    if (corner1.y>height || corner2.y>height || corner3.y>height) {
      canGoDown = false;
    }
    if (corner1.y<35 || corner2.y<35 || corner3.y<35) {
      canGoUp = false;
    }
    if (corner1.x>width || corner2.x>width || corner3.x>width) {
      canGoRight = false;
    }
    if (corner1.x<0 || corner2.x<0 || corner3.x<0) {
      canGoLeft = false;
    }
  }

  void goRotate() {
    if (rotation==7) rotation=0;
    else rotation++;
  }

  void detectCircularObjects() {
    for (int i=0; i<buttons.size(); i++) { //collision with buttons
      button b = buttons.get(i);
      PVector bPos = new PVector(b.pos.x, b.pos.y);
      if (lineCircleInt(edges[0], bPos, b.r)) {
        buttons.get(i).triggered();
        buttons.get(i).canClickMirror = false;
        return;
      }
      if (lineCircleInt(edges[1], bPos, b.r)) {
        buttons.get(i).triggered();
        buttons.get(i).canClickMirror = false;
        return;
      }
      if (lineCircleInt(edges[2], bPos, b.r)) {
        buttons.get(i).triggered();
        buttons.get(i).canClickMirror = false;
        return;
      }
      
    }

    for (int i=0; i<triggers.size(); i++) { //collision with triggers
      trigger t = triggers.get(i);
      PVector tPos = new PVector(t.pos.x, t.pos.y);

      if (rotation == 0) {
        if (lineCircleInt(vert, tPos, t.r) && corner2.x<tPos.x) {
          canGoRight = false;
        }
        if (lineCircleInt(diag1, tPos, t.r)) {
          canGoUp = false;
          canGoLeft = false;
        }
        if (lineCircleInt(diag2, tPos, t.r)) {
          canGoLeft = false;
          canGoDown = false;
        }
        if (pointCircleInt(corner1, tPos, t.r)) {
          canGoDown=true;
          canGoUp=true;
        }
        if (pointCircleInt(corner2, tPos, t.r) && corner2.x<tPos.x) canGoLeft=true;
        if (pointCircleInt(corner3, tPos, t.r) && corner3.x<tPos.x) canGoLeft=true;
      }
      if (rotation == 1) {
        if (lineCircleInt(diagonal, tPos, t.r)) {
          canGoRight = false;
          canGoDown = false;
        }
        if (lineCircleInt(hor, tPos, t.r) && pos.y>tPos.y) {
          canGoUp = false;
          if (pointCircleInt(corner2, tPos, t.r)) canGoDown=true;
        }
        if (lineCircleInt(vert, tPos, t.r) && pos.x>tPos.x) {
          canGoLeft = false;
          if (pointCircleInt(corner3, tPos, t.r)) canGoRight=true;
        }
      }
      if (rotation == 2) {
        if (lineCircleInt(hor, tPos, t.r) && corner2.y<tPos.y) {
          canGoDown = false;
        }
        if (lineCircleInt(diag1, tPos, t.r)) {
          canGoRight = false;
          canGoUp = false;
        }
        if (lineCircleInt(diag2, tPos, t.r)) {
          canGoUp = false;
          canGoLeft = false;
        }
        if (pointCircleInt(corner1, tPos, t.r)) {
          canGoLeft=true;
          canGoRight=true;
        }
        if (pointCircleInt(corner2, tPos, t.r) && corner2.y<tPos.y) canGoUp=true;
        if (pointCircleInt(corner3, tPos, t.r) && corner3.y<tPos.y) canGoUp=true;
      }
      if (rotation == 3) {
        if (lineCircleInt(diagonal, tPos, t.r)) {
          canGoLeft = false;
          canGoDown = false;
        }
        if (lineCircleInt(hor, tPos, t.r) && pos.y>tPos.y) {
          canGoUp = false;
          if (pointCircleInt(corner3, tPos, t.r)) canGoDown=true;
        }
        if (lineCircleInt(vert, tPos, t.r) && pos.x+size.x<tPos.x) {
          canGoRight = false;
          if (pointCircleInt(corner2, tPos, t.r)) canGoLeft=true;
        }
      }
      if (rotation == 4) {
        if (lineCircleInt(vert, tPos, t.r) && corner2.x>tPos.x) {
          canGoLeft = false;
        }
        if (lineCircleInt(diag1, tPos, t.r)) {
          canGoDown = false;
          canGoRight = false;
        }
        if (lineCircleInt(diag2, tPos, t.r)) {
          canGoRight = false;
          canGoUp = false;
        }
        if (pointCircleInt(corner1, tPos, t.r)) {
          canGoUp=true;
          canGoDown=true;
        }
        if (pointCircleInt(corner2, tPos, t.r) && corner2.x>tPos.x) canGoRight=true;
        if (pointCircleInt(corner3, tPos, t.r) && corner3.x>tPos.x) canGoRight=true;
      }
      if (rotation == 5) {
        if (lineCircleInt(diagonal, tPos, t.r)) {
          canGoLeft = false;
          canGoUp = false;
        }
        if (lineCircleInt(hor, tPos, t.r) && pos.y+size.y<tPos.y) {
          canGoDown = false;
          if (pointCircleInt(corner2, tPos, t.r)) canGoUp=true;
        }
        if (lineCircleInt(vert, tPos, t.r) && pos.x+size.x<tPos.x) {
          canGoRight = false;
          if (pointCircleInt(corner3, tPos, t.r)) canGoLeft=true;
        }
      }
      if (rotation == 6) {
        if (lineCircleInt(hor, tPos, t.r) && corner2.y>tPos.y) {
          canGoUp = false;
        }
        if (lineCircleInt(diag1, tPos, t.r)) {
          canGoLeft = false;
          canGoDown = false;
        }
        if (lineCircleInt(diag2, tPos, t.r)) {
          canGoDown = false;
          canGoRight = false;
        }
        if (pointCircleInt(corner1, tPos, t.r)) {
          canGoRight=true;
          canGoLeft=true;
        }
        if (pointCircleInt(corner2, tPos, t.r) && corner2.y>tPos.y) canGoDown=true;
        if (pointCircleInt(corner3, tPos, t.r) && corner3.y>tPos.y) canGoDown=true;
      }
      if (rotation == 7) {
        if (lineCircleInt(diagonal, tPos, t.r)) {
          canGoRight = false;
          canGoUp = false;
        }
        if (lineCircleInt(hor, tPos, t.r) && pos.y+size.y<tPos.y) {
          canGoDown = false;
          if (pointCircleInt(corner3, tPos, t.r)) canGoUp=true;
        }
        if (lineCircleInt(vert, tPos, t.r) && pos.x>tPos.x) {
          canGoLeft = false;
          if (pointCircleInt(corner2, tPos, t.r)) canGoRight=true;
        }
      }
    }
    for (int i=0; i<lasers.size(); i++) { //collision with lasers
      laser l = lasers.get(i);
      PVector lPos = new PVector(l.pos.x, l.pos.y);

      if (rotation == 0) {
        if (lineCircleInt(vert, lPos, l.r) && corner2.x<lPos.x) {
          canGoRight = false;
        }
        if (lineCircleInt(diag1, lPos, l.r)) {
          canGoUp = false;
          canGoLeft = false;
        }
        if (lineCircleInt(diag2, lPos, l.r)) {
          canGoLeft = false;
          canGoDown = false;
        }
        if (pointCircleInt(corner1, lPos, l.r)) {
          canGoDown=true;
          canGoUp=true;
        }
        if (pointCircleInt(corner2, lPos, l.r) && corner2.x<lPos.x) canGoLeft=true;
        if (pointCircleInt(corner3, lPos, l.r) && corner3.x<lPos.x) canGoLeft=true;
      }
      if (rotation == 1) {
        if (lineCircleInt(diagonal, lPos, l.r)) {
          canGoRight = false;
          canGoDown = false;
        }
        if (lineCircleInt(hor, lPos, l.r) && pos.y>lPos.y) {
          canGoUp = false;
          if (pointCircleInt(corner2, lPos, l.r)) canGoDown=true;
        }
        if (lineCircleInt(vert, lPos, l.r) && pos.x>lPos.x) {
          canGoLeft = false;
          if (pointCircleInt(corner3, lPos, l.r)) canGoRight=true;
        }
      }
      if (rotation == 2) {
        if (lineCircleInt(hor, lPos, l.r) && corner2.y<lPos.y) {
          canGoDown = false;
        }
        if (lineCircleInt(diag1, lPos, l.r)) {
          canGoRight = false;
          canGoUp = false;
        }
        if (lineCircleInt(diag2, lPos, l.r)) {
          canGoUp = false;
          canGoLeft = false;
        }
        if (pointCircleInt(corner1, lPos, l.r)) {
          canGoLeft=true;
          canGoRight=true;
        }
        if (pointCircleInt(corner2, lPos, l.r) && corner2.y<lPos.y) canGoUp=true;
        if (pointCircleInt(corner3, lPos, l.r) && corner3.y<lPos.y) canGoUp=true;
      }
      if (rotation == 3) {
        if (lineCircleInt(diagonal, lPos, l.r)) {
          canGoLeft = false;
          canGoDown = false;
        }
        if (lineCircleInt(hor, lPos, l.r) && pos.y>lPos.y) {
          canGoUp = false;
          if (pointCircleInt(corner3, lPos, l.r)) canGoDown=true;
        }
        if (lineCircleInt(vert, lPos, l.r) && pos.x+size.x<lPos.x) {
          canGoRight = false;
          if (pointCircleInt(corner2, lPos, l.r)) canGoLeft=true;
        }
      }
      if (rotation == 4) {
        if (lineCircleInt(vert, lPos, l.r) && corner2.x>lPos.x) {
          canGoLeft = false;
        }
        if (lineCircleInt(diag1, lPos, l.r)) {
          canGoDown = false;
          canGoRight = false;
        }
        if (lineCircleInt(diag2, lPos, l.r)) {
          canGoRight = false;
          canGoUp = false;
        }
        if (pointCircleInt(corner1, lPos, l.r)) {
          canGoUp=true;
          canGoDown=true;
        }
        if (pointCircleInt(corner2, lPos, l.r) && corner2.x>lPos.x) canGoRight=true;
        if (pointCircleInt(corner3, lPos, l.r) && corner3.x>lPos.x) canGoRight=true;
      }
      if (rotation == 5) {
        if (lineCircleInt(diagonal, lPos, l.r)) {
          canGoLeft = false;
          canGoUp = false;
        }
        if (lineCircleInt(hor, lPos, l.r) && pos.y+size.y<lPos.y) {
          canGoDown = false;
          if (pointCircleInt(corner2, lPos, l.r)) canGoUp=true;
        }
        if (lineCircleInt(vert, lPos, l.r) && pos.x+size.x<lPos.x) {
          canGoRight = false;
          if (pointCircleInt(corner3, lPos, l.r)) canGoLeft=true;
        }
      }
      if (rotation == 6) {
        if (lineCircleInt(hor, lPos, l.r) && corner2.y>lPos.y) {
          canGoUp = false;
        }
        if (lineCircleInt(diag1, lPos, l.r)) {
          canGoLeft = false;
          canGoDown = false;
        }
        if (lineCircleInt(diag2, lPos, l.r)) {
          canGoDown = false;
          canGoRight = false;
        }
        if (pointCircleInt(corner1, lPos, l.r)) {
          canGoRight=true;
          canGoLeft=true;
        }
        if (pointCircleInt(corner2, lPos, l.r) && corner2.y>lPos.y) canGoDown=true;
        if (pointCircleInt(corner3, lPos, l.r) && corner3.y>lPos.y) canGoDown=true;
      }
      if (rotation == 7) {
        if (lineCircleInt(diagonal, lPos, l.r)) {
          canGoRight = false;
          canGoUp = false;
        }
        if (lineCircleInt(hor, lPos, l.r) && pos.y+size.y<lPos.y) {
          canGoDown = false;
          if (pointCircleInt(corner3, lPos, l.r)) canGoUp=true;
        }
        if (lineCircleInt(vert, lPos, l.r) && pos.x>lPos.x) {
          canGoLeft = false;
          if (pointCircleInt(corner2, lPos, l.r)) canGoRight=true;
        }
      }
    }
  }

  void detectBlocks() {

    for (int j=0; j<blocks.size(); j++) {
      edge bTop = blocks.get(j).edges[0];
      edge bRight = blocks.get(j).edges[1];
      edge bBottom = blocks.get(j).edges[2];
      edge bLeft = blocks.get(j).edges[3];

      if (rotation == 0) {
        if ((intersection(diag2, bTop) && bTop.open)) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        } 
        if ((intersection(diag1, bLeft) && bLeft.open) || (intersection(diag2, bLeft) && bLeft.open)) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        }
        if (((intersection(diag1, bBottom) && bBottom.open))) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        } 
        if ((intersection(diag1, bRight) && bRight.open) || (intersection(diag2, bRight) && bRight.open)) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 1) {
        if ((intersection(diagonal, bTop) && bTop.open) 
          && pos.y+size.y<bTop.v1.y+2) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        } 
        if ((intersection(diagonal, bLeft) && bLeft.open)) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        }
        if (((intersection(diagonal, bBottom) && bBottom.open) || (intersection(vert, bBottom) && bBottom.open))
          && pos.y>bBottom.v1.y-2) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        } 
        if (((intersection(diagonal, bRight) && bRight.open) || (intersection(hor, bRight) && bRight.open))
          && pos.x>bRight.v1.x-2) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 2) {
        if (((intersection(diag1, bTop) && bTop.open) || (intersection(diag2, bTop) && bTop.open))) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        }
        if ((intersection(diag1, bLeft) && bLeft.open)) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        } 
        if ((intersection(diag1, bBottom) && bBottom.open) || (intersection(diag2, bBottom) && bBottom.open)) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        }
        if ((intersection(diag2, bRight) && bRight.open)) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 3) {
        if ((intersection(diagonal, bTop) && bTop.open)) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
          ;
        } 
        if (((intersection(diagonal, bLeft) && bLeft.open) || (intersection(hor, bLeft) && bLeft.open))
          && pos.x+size.x<bLeft.v1.x+2) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        }
        if (((intersection(diagonal, bBottom) && bBottom.open) || (intersection(vert, bBottom) && bBottom.open))
          && pos.y>bBottom.v1.y-2) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        } 
        if ((intersection(diagonal, bRight) && bRight.open)) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 4) {
        if ((intersection(diag1, bTop) && bTop.open)) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        } 
        if ((intersection(diag1, bLeft) && bLeft.open) || (intersection(diag2, bLeft) && bLeft.open)) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        }
        if (((intersection(diag2, bBottom) && bBottom.open))) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        } 
        if ((intersection(diag1, bRight) && bRight.open) || (intersection(diag2, bRight) && bRight.open)) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 5) {
        if (((intersection(diagonal, bTop) && bTop.open) ||  (intersection(vert, bTop) && bTop.open))
          && pos.y+size.y<bTop.v1.y+2) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        } 
        if (((intersection(diagonal, bLeft) && bLeft.open) || (intersection(hor, bLeft) && bLeft.open))
          && pos.x+size.x<bLeft.v1.x+2) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        }
        if (((intersection(diagonal, bBottom) && bBottom.open))
          && pos.y+size.y>bBottom.v1.y-2) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        } 
        if ((intersection(diagonal, bRight) && bRight.open)) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 6) {
        if (((intersection(diag1, bTop) && bTop.open) || (intersection(diag2, bTop) && bTop.open))) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        }
        if ((intersection(diag2, bLeft) && bLeft.open)) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        } 
        if ((intersection(diag1, bBottom) && bBottom.open) || (intersection(diag2, bBottom) && bBottom.open)) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        }
        if ((intersection(diag1, bRight) && bRight.open)) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
      if (rotation == 7) {
        if (((intersection(diagonal, bTop) && bTop.open) ||  (intersection(vert, bTop) && bTop.open))
          && pos.y+size.y<bTop.v1.y+2) {
          canGoDown = false;
          if (corner1.y>bTop.v1.y+2 || corner2.y>bTop.v1.y+2 || corner3.y>bTop.v1.y+2) pos.y-=0.5;
        } 
        if ((intersection(diagonal, bLeft) && bLeft.open)) {
          canGoRight = false;
          if (corner1.x>bLeft.v1.x+2 || corner2.x>bLeft.v1.x+2 || corner3.x>bLeft.v1.x+2) pos.x-=0.5;
        }
        if (((intersection(diagonal, bBottom) && bBottom.open))
          && pos.y+size.y>bBottom.v1.y-2) {
          canGoUp = false;
          if (corner1.y<bBottom.v1.y-2 || corner2.y<bBottom.v1.y-2 || corner3.y<bBottom.v1.y-2) pos.y+=0.5;
        } 
        if (((intersection(diagonal, bRight) && bRight.open) || (intersection(hor, bRight) && bRight.open))
          && pos.x>bRight.v1.x-2) {
          canGoLeft = false;
          if (corner1.x<bRight.v1.x-2 || corner2.x<bRight.v1.x-2 || corner3.x<bRight.v1.x-2) pos.x+=0.5;
        }
      }
    }
  }

  void detectDoors() {
    for (int i=0; i<doors.size(); i++) {
      if (!doors.get(i).triggered) {
        door d = doors.get(i);
        edge door = new edge(d.v1.x, d.v1.y, d.v2.x, d.v2.y);
        PVector center = new PVector(pos.x+(size.x/2), pos.y+(size.y/2));
        PVector mid = midPoint(center, corner1);
        if (door.v1.y==door.v2.y) {
          if (intersection(hor, door) || intersection(diagonal, door) || intersection(diag1, door) || intersection(diag2, door)) {
            if (mid.y>door.v1.y) {
              canGoUp = false;
              if (corner1.y<door.v1.y || corner2.y<door.v1.y || corner3.y<door.v1.y) pos.y+=1;
            } else {
              canGoDown = false;
              if (corner1.y>door.v1.y || corner2.y>door.v1.y || corner3.y>door.v1.y) pos.y-=1;
            }
          }
        } else if (door.v1.x==door.v2.x) {
          if (intersection(vert, door) || intersection(diagonal, door) || intersection(diag1, door) || intersection(diag2, door)) {   
            if (mid.x>door.v1.x) {
              canGoLeft = false;
              if (corner1.x<door.v1.x || corner2.x<door.v1.x || corner3.x<door.v1.x) pos.x+=1;
            } else {
              canGoRight = false;
              if (corner1.x>door.v1.x || corner2.x>door.v1.x || corner3.x>door.v1.x) pos.x-=1;
            }
          }
        } else if (rotation==0) {
          if (door.v1.y>door.v2.y) {
            if (corner1.y+corner1.x<=door.v1.y+door.v1.x) {
              if (intersection(door, diag2) || intersection(door, vert)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, diag2) || intersection(door, vert)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (corner1.y-2-corner1.x<=door.v1.y-door.v1.x) {
              if (intersection(vert, door) || intersection(diag1, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(vert, door) || intersection(diag1, door)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        } else if (rotation==1) {
          if (door.v1.y>door.v2.y) {
            if (pos.y+pos.x+(size.x/2)<=door.v1.y+door.v1.x) {
              if (intersection(door, vert) || intersection(door, hor)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, vert) || intersection(door, hor)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (pos.y-pos.x<=door.v1.y-door.v1.x) {
              if (intersection(vert, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(hor, door)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        } else if (rotation==2) {
          if (door.v1.y>door.v2.y) {
            if (corner1.y+2+corner1.x<=door.v1.y+door.v1.x) {
              if (intersection(door, diag1) || intersection(door, hor)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, diag1) || intersection(door, hor)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (corner1.y+2-corner1.x<=door.v1.y-door.v1.x) {
              if (intersection(hor, door) || intersection(diag2, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(hor, door) || intersection(diag2, door)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        } else if (rotation==3) {
          if (door.v1.y>door.v2.y) {
            if (pos.y+pos.x+(size.x/2)<=door.v1.y+door.v1.x) {
              if (intersection(door, vert)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, hor)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (pos.y-pos.x-(size.x/2)<=door.v1.y-door.v1.x) {
              if (intersection(vert, door) || intersection(hor, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(vert, door)) canGoRight = false;
              if (intersection(hor, door)) canGoUp = false;
            }
          }
        } else if (rotation==4) {
          if (door.v1.y>door.v2.y) {
            if (corner1.y-2+corner1.x<=door.v1.y+door.v1.x) {
              if (intersection(door, diag2) || intersection(door, vert)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, diag2) || intersection(door, vert)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (corner1.y+2-corner1.x<=door.v1.y-door.v1.x) {
              if (intersection(vert, door) || intersection(diag1, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(vert, door) || intersection(diag1, door)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        } else if (rotation==5) {
          if (door.v1.y>door.v2.y) {
            if (pos.y+pos.x+(size.x*1.5)<=door.v1.y+door.v1.x) {
              if (intersection(door, vert) || intersection(door, hor)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, vert) || intersection(door, hor)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (pos.y-pos.x<=door.v1.y-door.v1.x) {
              if (intersection(hor, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(vert, door)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        } else if (rotation==6) {
          if (door.v1.y>door.v2.y) {
            if (corner1.y-2+corner1.x<=door.v1.y+door.v1.x) {
              if (intersection(door, diag1) || intersection(door, hor)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, diag1) || intersection(door, hor)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (corner1.y-2-corner1.x<=door.v1.y-door.v1.x) {
              if (intersection(hor, door) || intersection(diag2, door)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(hor, door) || intersection(diag2, door)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        } else if (rotation==7) {
          if (door.v1.y>door.v2.y) {
            if (pos.y+pos.x+(size.x/2)<=door.v1.y+door.v1.x) {
              if (intersection(door, hor)) {
                canGoDown = false;
                canGoRight = false;
              }
            } else {
              if (intersection(door, vert)) {
                canGoUp = false;
                canGoLeft = false;
              }
            }
          } else { //if(door.v1.y<door.v2.y)
            if (pos.y-pos.x+(size.x/2)<=door.v1.y-door.v1.x) {
              if (intersection(door, vert) || intersection(door, hor)) {
                canGoDown = false;
                canGoLeft = false;
              }
            } else {
              if (intersection(door, vert) || intersection(door, hor)) {
                canGoUp = false;
                canGoRight = false;
              }
            }
          }
        }
      }
    }
  }

  void detectTriBlocks() {

    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i) != this && (!triBlocks.get(i).movable || !touchingMover)) {
        triBlock other = triBlocks.get(i);
        edge otherHor = triBlocks.get(i).hor;
        edge otherVert = triBlocks.get(i).vert;
        edge otherDiagonal = triBlocks.get(i).diagonal;
        edge otherDiag1 = triBlocks.get(i).diag1;
        edge otherDiag2 = triBlocks.get(i).diag2;

        if (rotation == 0) { //----------------ROTATION0----------------//

          if (other.rotation == 0) {
            if (intersection(vert, otherDiag1) && intersection(vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoRight=false;
            }
            if (intersection(diag1, otherVert) && intersection(diag1, otherDiag2) && otherVert.open && otherDiag2.open) {
              canGoLeft=false;
              canGoUp=false;
            }
            if (intersection(diag2, otherVert) && intersection(diag2, otherDiag1) && otherVert.open && otherDiag1.open) {
              canGoLeft=false;
              canGoDown=false;
            }
            if (intersection(vert, otherDiag1) && intersection(diag2, otherDiag1) && otherDiag1.open) {
              canGoRight = false;
              canGoDown = false;
            }
            if (intersection(diag1, otherVert) && intersection(diag2, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
            if (intersection(vert, otherDiag2) && intersection(diag1, otherDiag2) && otherDiag2.open) {
              canGoRight=false;
              canGoUp = false;
            }
          }
          if (other.rotation == 1) {
            if (((intersection(diag2, otherDiagonal) && otherDiagonal.open) || (intersection(vert, otherDiagonal) && otherDiagonal.open))
              && (corner1.y > other.pos.y+2 && corner2.x > other.pos.x+2)) {
              canGoUp = false;
              canGoLeft = false;
            } else if (intersection(vert, otherHor) && otherHor.open && corner3.x>other.pos.x+2) {
              canGoDown = false;
            } else if ((intersection(diag2, otherDiagonal)  && otherDiagonal.open) && corner3.x>other.pos.x) {
              canGoDown= false;
              canGoLeft= false;
            } else if ((intersection(vert, otherDiagonal)  && otherDiagonal.open) || (intersection(vert, otherHor)) && otherHor.open) {
              canGoRight= false;
            }
          }
          if (other.rotation == 2) {
            if (intersection(vert, otherDiag2) && otherDiag2.open) {
              canGoRight=false;
            }
            if (intersection(diag1, otherHor) && otherHor.open) {
              canGoUp=false;
            }
            if ((intersection(diag1, otherDiag1) && otherDiag1.open) || (intersection(vert, otherDiag1) && otherDiag1.open) ) {
              canGoLeft=false; 
              if (pos.y<other.pos.y) {
                canGoDown=false;
              }
            }
            if (intersection(diag2, otherDiag2) && otherDiag2.open) {
              canGoDown=false;
            }
          }
          if (other.rotation == 3) {
            if ((intersection(diag2, otherHor) && otherHor.open) && (intersection(diag2, otherVert) && otherVert.open)) {
              canGoDown=false;
              canGoLeft=false;
            } else if ((intersection(vert, otherHor) && otherHor.open) && (intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoRight=false;
            } else if ((intersection(diag1, otherVert) && otherVert.open) && (intersection(diag1, otherDiagonal) && otherDiagonal.open)) {
              canGoUp=false;
              canGoLeft=false;
            } else if (intersection(vert, otherDiagonal) && otherDiagonal.open) {
              canGoUp=false;
              canGoRight=false;
            } else if (intersection(vert, otherHor) && otherHor.open) {
              canGoDown=false;
            } else if (intersection(diag1, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
          }
          if (other.rotation == 4) {
            if (((intersection(diag1, otherVert) && otherVert.open) || (intersection(diag2, otherVert) && otherVert.open)) && pos.x<other.pos.x+2) {
              canGoRight=false;
            } else {
              if (((intersection(diag1, otherDiag2) && otherDiag2.open) || (intersection(diag1, otherVert) && otherVert.open))
                && corner1.y>other.corner1.y) {
                canGoUp=false;
                canGoLeft=false;
              }
              if (((intersection(diag2, otherDiag1) && otherDiag1.open) || (intersection(diag2, otherVert) && otherVert.open))
                && corner1.y<other.corner1.y) {
                canGoDown=false;
                canGoLeft=false;
              }
            }
          }
          if (other.rotation == 5) {
            if ((intersection(diag2, otherDiagonal) && otherDiagonal.open) && (intersection(diag2, otherVert) && otherVert.open)) {
              canGoDown=false;
              canGoLeft=false;
            } else if ((intersection(vert, otherHor) && otherHor.open) && (intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoRight=false;
            } else if ((intersection(diag1, otherVert) && otherVert.open) && (intersection(diag1, otherHor) && otherHor.open)) {
              canGoUp=false;
              canGoLeft=false;
            } else if (intersection(vert, otherDiagonal) && otherDiagonal.open) {
              canGoDown=false;
              canGoRight=false;
            } else if (intersection(vert, otherHor) && otherHor.open) {
              canGoUp=false;
            } else if (intersection(diag1, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
          }
          if (other.rotation == 6) {
            if (intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoRight=false;
            }
            if (intersection(diag2, otherHor) && otherHor.open) {
              canGoDown=false;
            }
            if ((intersection(diag2, otherDiag2) && otherDiag2.open) || (intersection(vert, otherDiag2) && otherDiag2.open) ) {
              canGoLeft=false; 
              if (pos.y>other.pos.y) {
                canGoUp=false;
              }
            }
            if (intersection(diag1, otherDiag1) && otherDiag1.open) {
              canGoUp=false;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(diag2, otherHor) && otherHor.open || intersection(diag2, otherVert) && otherVert.open)
              && other.pos.x<corner2.x-2) {
              canGoLeft = false;
              canGoDown = false;
            } else if (intersection(diag1, otherHor) && otherHor.open) {
              canGoLeft = false;
              canGoUp = false;
              if (intersection(vert, otherHor) && otherHor.open) {
                canGoLeft = true;
              }
            } else if ((intersection(vert, otherHor) && otherHor.open) || (intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoRight = false;
              canGoDown = true;
            }
          }
        }

        if (rotation == 1) { //----------------ROTATION1----------------//

          if (other.rotation == 0) {
            if (((intersection(diagonal, otherDiag2) && otherDiag2.open) || (intersection(diagonal, otherVert) && otherVert.open))
              && (pos.y < other.corner1.y-2 && pos.x < other.corner2.x-2)) {
              canGoDown = false;
              canGoRight = false;
            } else if (intersection(hor, otherVert) && otherVert.open && pos.x<other.corner3.x-2) {
              canGoUp = false;
            } else if ((intersection(diagonal, otherDiag2)  && otherDiag2.open) && pos.x<other.corner3.x) {
              canGoUp= false;
              canGoRight= false;
            } else if ((intersection(diagonal, otherVert)  && otherVert.open) || (intersection(hor, otherVert)) && otherVert.open) {
              canGoLeft= false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(vert, otherHor)) && otherHor.open) {
              canGoDown = false;
              if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
                canGoDown = true;
                canGoLeft = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoRight = true;
                canGoUp = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open) || (intersection(diagonal, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoDown = false;
            } else if ((intersection(otherDiagonal, vert) && otherDiagonal.open) || (intersection(otherDiagonal, hor) && otherDiagonal.open)) {
              canGoUp = false;
              canGoLeft = false;
            }
          }

          if (other.rotation == 2) {
            if ((intersection(hor, otherDiag2) && otherDiag2.open || intersection(vert, otherDiag2) && otherDiag2.open) ||
              (intersection(diagonal, otherHor) && otherHor.open && intersection(diagonal, otherDiag1) && otherDiag1.open)) {
              canGoRight = false;
              canGoDown = false;
              if (pos.y>other.corner3.y-2) {
                canGoUp = false;
                canGoRight = true;
                canGoDown = false;
              }
            } else if (intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoLeft = false;
              canGoDown = false;
              if (intersection(vert, otherHor) && otherHor.open && pos.y>other.corner2.y-2) {
                canGoLeft = true;
              }
              if (pos.x>other.corner2.x-2) {
                canGoDown = true;
              }
            } else if ((intersection(vert, otherHor) && otherHor.open) || (intersection(diagonal, otherHor) && otherHor.open)) {
              canGoUp = false;
              canGoRight = true;
            }
          }

          if (other.rotation == 3) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoDown = false;
              if ((intersection(diagonal, otherVert) && otherVert.open)) {
                canGoDown = true;
                canGoLeft = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoLeft = true;
                canGoUp = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open)) {
              canGoRight = false;
              canGoDown = false;
            } else if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoUp = false;
              canGoRight = false;
              if ((intersection(hor, otherVert) && otherVert.open)) {
                canGoRight = true;
              }
            }
          }

          if (other.rotation == 4) {
            if (intersection(hor, otherVert) && intersection(diagonal, otherVert) && otherVert.open) {
              canGoRight=false;
            }
            if (intersection(vert, otherDiag2) && intersection(diagonal, otherDiag2) && otherDiag2.open) {
              canGoLeft=false;
              canGoDown=false;
            }
            if (intersection(vert, otherDiag1) && intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoLeft=false;
              canGoUp=false;
            }
            if (intersection(hor, otherDiag1) && intersection(hor, otherVert) && otherVert.open && otherDiag1.open) {
              canGoUp=false;
            }
            if (intersection(vert, otherDiag2) && intersection(vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoLeft=false;
            }
            if (intersection(diagonal, otherVert) && intersection(diagonal, otherDiag2) && otherVert.open && otherDiag2.open) {
              canGoDown=false;
              canGoRight=false;
            }
          }

          if (other.rotation == 5) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && pos.y>otherHor.v1.y-2) {
              canGoUp = false;
            }
            if ((intersection(hor, otherVert) && otherVert.open || intersection(diagonal, otherVert) && otherVert.open) && pos.x>otherVert.v1.x-2) {
              canGoLeft = false;
              canGoUp = true;
            }

            if ((intersection(hor, otherDiagonal) && otherDiagonal.open || intersection(vert, otherDiagonal) && otherDiagonal.open) 
              && pos.y<otherHor.v1.y-2 && pos.x<otherVert.v1.x-2) {
              canGoRight= false;
              canGoDown = false;
            }
          }

          if (other.rotation == 6) {
            if (intersection(hor, otherDiag1) && intersection(hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoUp=false;
            }
            if (intersection(diagonal, otherHor) && intersection(diagonal, otherDiag1) && otherHor.open && otherDiag1.open) {
              canGoRight=false;
              canGoDown=false;
            }
            if (intersection(vert, otherHor) && intersection(vert, otherDiag2) && otherHor.open && otherDiag2.open) {
              canGoLeft=false;
            }
            if (intersection(hor, otherDiag2) && intersection(vert, otherDiag2) && otherDiag2.open) {
              canGoUp=false;
              canGoLeft = false;
            }
            if (intersection(diagonal, otherHor) && intersection(vert, otherHor) && otherHor.open) {
              canGoDown=false;
            }
            if (intersection(diagonal, otherDiag1) && intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoUp=false;
              canGoRight=false;
            }
          }

          if (other.rotation == 7) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && !(intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoUp = false;
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
            } else if ((intersection(diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(diagonal, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoDown = false;
            } 
            if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoLeft = false;
            } 
            if ((intersection(diagonal, otherVert) && otherVert.open) && !(intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoDown = false;
            }
          }
        }

        if (rotation == 2) { //----------------ROTATION2----------------//

          if (other.rotation == 0) {

            if (intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoDown=false;
            }
            if (intersection(diag2, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
            if ((intersection(diag2, otherDiag2) && otherDiag2.open) || (intersection(hor, otherDiag2) && otherDiag2.open) ) {
              canGoUp=false; 
              if (pos.x<other.pos.x) {
                canGoRight=false;
              }
            }
            if (intersection(diag1, otherDiag1) && otherDiag1.open) {
              canGoRight=false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(diag1, otherDiagonal) && otherDiagonal.open || intersection(hor, otherDiagonal) && otherDiagonal.open)
              && other.pos.y<corner2.y-2 && other.pos.x+other.size.x>corner3.x+2 && other.pos.x<corner1.x-2) {
              canGoUp = false;
              canGoLeft = false;
            } else if (intersection(diag1, otherVert) && otherVert.open) {
              canGoUp = false;
              canGoRight = false;
              if (intersection(hor, otherVert) && otherVert.open) {
                canGoUp = true;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open) || (intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoDown = false;
              canGoLeft = true;
            }
          }

          if (other.rotation == 2) {
            if (intersection(hor, otherDiag1) && intersection(hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoDown=false;
            }
            if (intersection(diag1, otherHor) && intersection(diag1, otherDiag2) && otherHor.open && otherDiag2.open) {
              canGoUp=false;
              canGoRight=false;
            }
            if (intersection(diag2, otherHor) && intersection(diag2, otherDiag1) && otherHor.open && otherDiag1.open) {
              canGoUp=false;
              canGoLeft=false;
            }
            if (intersection(hor, otherDiag1) && intersection(diag2, otherDiag1) && otherDiag1.open) {
              canGoDown = false;
              canGoLeft = false;
            }
            if (intersection(diag1, otherHor) && intersection(diag2, otherHor) && otherHor.open) {
              canGoUp=false;
            }
            if (intersection(hor, otherDiag2) && intersection(diag1, otherDiag2) && otherDiag2.open) {
              canGoDown=false;
              canGoRight = false;
            }
          }

          if (other.rotation == 3) {
            if (((intersection(diag2, otherDiagonal) && otherDiagonal.open) || (intersection(hor, otherDiagonal) && otherDiagonal.open))
              && (corner1.x < other.pos.x+size.x-2 && corner2.y > other.pos.y+2)) {
              canGoRight = false;
              canGoUp = false;
            } else if (intersection(hor, otherVert) && otherVert.open && corner3.y>other.pos.y+2) {
              canGoLeft= false;
            } else if ((intersection(diag2, otherDiagonal)  && otherDiagonal.open) && corner3.y>other.pos.y) {
              canGoLeft= false;
              canGoUp= false;
            } else if ((intersection(hor, otherDiagonal)  && otherDiagonal.open) || (intersection(hor, otherVert)) && otherVert.open) {
              canGoDown= false;
            }
          }

          if (other.rotation == 4) {
            if (intersection(hor, otherDiag2) && otherDiag2.open) {
              canGoDown=false;
            }
            if (intersection(diag1, otherVert) && otherVert.open) {
              canGoRight=false;
            }
            if ((intersection(diag1, otherDiag1) && otherDiag1.open) || (intersection(hor, otherDiag1) && otherDiag1.open) ) {
              canGoUp=false; 
              if (pos.x>other.pos.x) {
                canGoLeft=false;
              }
            }
            if (intersection(diag2, otherDiag2) && otherDiag2.open) {
              canGoLeft=false;
            }
          }

          if (other.rotation == 5) {
            if ((intersection(diag2, otherVert) && otherVert.open) && (intersection(diag2, otherHor) && otherHor.open)) {
              canGoLeft=false;
              canGoUp=false;
            } else if ((intersection(hor, otherVert) && otherVert.open) && (intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoDown=false;
            } else if ((intersection(diag1, otherHor) && otherHor.open) && (intersection(diag1, otherDiagonal) && otherDiagonal.open)) {
              canGoRight=false;
              canGoUp=false;
            } else if (intersection(hor, otherDiagonal) && otherDiagonal.open) {
              canGoRight=false;
              canGoDown=false;
            } else if (intersection(hor, otherVert) && otherVert.open) {
              canGoLeft=false;
            } else if (intersection(diag1, otherHor) && otherHor.open) {
              canGoUp=false;
            }
          }

          if (other.rotation == 6) {
            if (((intersection(diag1, otherHor) && otherHor.open) || (intersection(diag2, otherHor) && otherHor.open)) && pos.y<other.pos.y+2) {
              canGoDown=false;
            } else {
              if (((intersection(diag1, otherDiag2) && otherDiag2.open) || (intersection(diag1, otherHor) && otherHor.open))
                && corner1.x<other.corner1.x) {
                canGoRight=false;
                canGoUp=false;
              }
              if (((intersection(diag2, otherDiag1) && otherDiag1.open) || (intersection(diag2, otherHor) && otherHor.open))
                && corner1.x>other.corner1.x) {
                canGoLeft=false;
                canGoUp=false;
              }
            }
          }
          if (other.rotation == 7) {
            if ((intersection(diag2, otherDiagonal) && otherDiagonal.open) && (intersection(diag2, otherHor) && otherHor.open)) {
              canGoLeft=false;
              canGoUp=false;
            } else if ((intersection(hor, otherVert) && otherVert.open) && (intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoDown=false;
            } else if ((intersection(diag1, otherHor) && otherHor.open) && (intersection(diag1, otherVert) && otherVert.open)) {
              canGoRight=false;
              canGoUp=false;
            } else if (intersection(hor, otherDiagonal) && otherDiagonal.open) {
              canGoLeft=false;
              canGoDown=false;
            } else if (intersection(hor, otherVert) && otherVert.open) {
              canGoRight=false;
            } else if (intersection(diag1, otherHor) && otherHor.open) {
              canGoUp=false;
            }
          }
        }

        if (rotation == 3) { //----------------ROTATION3----------------//

          if (other.rotation == 0) {
            if (intersection(vert, otherDiag1) && intersection(vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoRight=false;
            }
            if (intersection(diagonal, otherVert) && intersection(diagonal, otherDiag1) && otherVert.open && otherDiag1.open) {
              canGoDown=false;
              canGoLeft=false;
            }
            if (intersection(hor, otherVert) && intersection(hor, otherDiag2) && otherVert.open && otherDiag2.open) {
              canGoUp=false;
            }
            if (intersection(vert, otherDiag2) && intersection(hor, otherDiag2) && otherDiag2.open) {
              canGoRight=false;
              canGoUp = false;
            }
            if (intersection(diagonal, otherVert) && intersection(hor, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
            if (intersection(diagonal, otherDiag1) && intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoRight=false;
              canGoDown=false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoDown = false;
              if ((intersection(diagonal, otherVert) && otherVert.open)) {
                canGoDown = true;
                canGoRight = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoRight = true;
                canGoUp = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open)) {
              canGoLeft = false;
              canGoDown = false;
            } else if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoUp = false;
              canGoLeft = false;
              if ((intersection(hor, otherVert) && otherVert.open)) {
                canGoLeft = true;
              }
            }
          }

          if (other.rotation == 2) {
            if (((intersection(diagonal, otherDiag2) && otherDiag2.open) || (intersection(diagonal, otherHor) && otherHor.open))
              && (pos.x+size.x > other.corner1.x+2 && pos.y < other.corner2.y-2)) {
              canGoLeft = false;
              canGoDown = false;
            } else if (intersection(vert, otherHor) && otherHor.open && pos.y<other.corner3.y-2) {
              canGoRight = false;
            } else if ((intersection(diagonal, otherDiag2)  && otherDiag2.open) && pos.y<other.corner3.y) {
              canGoRight= false;
              canGoDown= false;
            } else if ((intersection(diagonal, otherHor)  && otherHor.open) || (intersection(vert, otherHor)) && otherHor.open) {
              canGoUp= false;
            }
          }
          if (other.rotation == 3) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoDown = false;
              if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
                canGoDown = true;
                canGoRight = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoLeft = true;
                canGoUp = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open) || (intersection(diagonal, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoDown = false;
            } else if ((intersection(otherDiagonal, vert) && otherDiagonal.open) || (intersection(otherDiagonal, hor) && otherDiagonal.open)) {
              canGoUp = false;
              canGoRight = false;
            }
          }
          if (other.rotation == 4) {
            if ((intersection(vert, otherDiag2) && otherDiag2.open || intersection(hor, otherDiag2) && otherDiag2.open) ||
              (intersection(diagonal, otherVert) && otherVert.open && intersection(diagonal, otherDiag1) && otherDiag1.open)) {
              canGoDown = false;
              canGoLeft = false;
              if (pos.x+size.x<other.corner3.x+2) {
                canGoRight = false;
                canGoDown = true;
                canGoLeft = false;
              }
            } else if (intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoUp = false;
              canGoLeft = false;
              if (intersection(hor, otherVert) && otherVert.open && pos.x+size.x<other.corner2.x+2) {
                canGoUp = true;
              }
              if (pos.y>other.corner2.y-2) {
                canGoLeft = true;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open) || (intersection(diagonal, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoDown = true;
            }
          }
          if (other.rotation == 5) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && !(intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoUp = false;
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
            } else if ((intersection(diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(diagonal, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoDown = false;
            } 
            if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoRight = false;
            } 
            if ((intersection(diagonal, otherVert) && otherVert.open) && !(intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoDown = false;
            }
          }
          if (other.rotation == 6) {
            if (intersection(vert, otherHor) && intersection(diagonal, otherHor) && otherHor.open) {
              canGoDown=false;
            }
            if (intersection(hor, otherDiag2) && intersection(diagonal, otherDiag2) && otherDiag2.open) {
              canGoUp=false;
              canGoLeft=false;
            }
            if (intersection(hor, otherDiag1) && intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoUp=false;
              canGoRight=false;
            }
            if (intersection(vert, otherDiag1) && intersection(vert, otherHor) && otherHor.open && otherDiag1.open) {
              canGoRight=false;
            }
            if (intersection(hor, otherDiag2) && intersection(hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoUp=false;
            }
            if (intersection(diagonal, otherHor) && intersection(diagonal, otherDiag2) && otherHor.open && otherDiag2.open) {
              canGoLeft=false;
              canGoDown=false;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && pos.y>otherHor.v1.y-2) {
              canGoUp = false;
            }
            if ((intersection(hor, otherVert) && otherVert.open || intersection(diagonal, otherVert) && otherVert.open) && pos.x+size.x<otherVert.v1.x+2) {
              canGoRight = false;
              canGoUp = true;
            }

            if ((intersection(hor, otherDiagonal) && otherDiagonal.open || intersection(vert, otherDiagonal) && otherDiagonal.open) 
              && pos.y<otherHor.v1.y-2 && pos.x+size.x>otherVert.v1.x+2) {
              canGoLeft= false;
              canGoDown = false;
            }
          }
        }

        if (rotation == 4) { //----------------ROTATION4----------------//

          if (other.rotation == 0) {
            if (((intersection(diag1, otherVert) && otherVert.open) || (intersection(diag2, otherVert) && otherVert.open)) && pos.x>other.pos.x-2) {
              canGoLeft=false;
            } else {
              if (((intersection(diag1, otherDiag2) && otherDiag2.open) || (intersection(diag1, otherVert) && otherVert.open))
                && corner1.y<other.corner1.y) {
                canGoDown=false;
                canGoRight=false;
              }
              if (((intersection(diag2, otherDiag1) && otherDiag1.open) || (intersection(diag2, otherVert) && otherVert.open))
                && corner1.y>other.corner1.y) {
                canGoUp=false;
                canGoRight=false;
              }
            }
          }
          if (other.rotation == 1) {
            if ((intersection(diag2, otherDiagonal) && otherDiagonal.open) && (intersection(diag2, otherVert) && otherVert.open)) {
              canGoUp=false;
              canGoRight=false;
            } else if ((intersection(vert, otherHor) && otherHor.open) && (intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoLeft=false;
            } else if ((intersection(diag1, otherVert) && otherVert.open) && (intersection(diag1, otherHor) && otherHor.open)) {
              canGoDown=false;
              canGoRight=false;
            } else if (intersection(vert, otherDiagonal) && otherDiagonal.open) {
              canGoUp=false;
              canGoLeft=false;
            } else if (intersection(vert, otherHor) && otherHor.open) {
              canGoDown=false;
            } else if (intersection(diag1, otherVert) && otherVert.open) {
              canGoRight=false;
            }
          }
          if (other.rotation == 2) {

            if (intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoLeft=false;
            }
            if (intersection(diag2, otherHor) && otherHor.open) {
              canGoUp=false;
            }
            if ((intersection(diag2, otherDiag2) && otherDiag2.open) || (intersection(vert, otherDiag2) && otherDiag2.open) ) {
              canGoRight=false; 
              if (pos.y<other.pos.y) {
                canGoDown=false;
              }
            }
            if (intersection(diag1, otherDiag1) && otherDiag1.open) {
              canGoDown=false;
            }
          }

          if (other.rotation == 3) {
            if ((intersection(diag1, otherDiagonal) && otherDiagonal.open || intersection(vert, otherDiagonal) && otherDiagonal.open)
              && other.pos.x+size.x>corner2.x+2 && other.pos.y+other.size.y>corner3.y+2 && other.pos.y<corner1.y-2) {
              canGoRight = false;
              canGoUp = false;
            } else if (intersection(diag1, otherHor) && otherHor.open) {
              canGoRight = false;
              canGoDown = false;
              if (intersection(vert, otherHor) && otherHor.open) {
                canGoRight = true;
              }
            } else if ((intersection(vert, otherHor) && otherHor.open) || (intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoLeft = false;
              canGoUp = true;
            }
          }
          if (other.rotation == 4) {
            if (intersection(vert, otherDiag1) && intersection(vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoLeft=false;
            }
            if (intersection(diag1, otherVert) && intersection(diag1, otherDiag2) && otherVert.open && otherDiag2.open) {
              canGoRight=false;
              canGoDown=false;
            }
            if (intersection(diag2, otherVert) && intersection(diag2, otherDiag1) && otherVert.open && otherDiag1.open) {
              canGoRight=false;
              canGoUp=false;
            }
            if (intersection(vert, otherDiag1) && intersection(diag2, otherDiag1) && otherDiag1.open) {
              canGoLeft = false;
              canGoUp = false;
            }
            if (intersection(diag1, otherVert) && intersection(diag2, otherVert) && otherVert.open) {
              canGoRight=false;
            }
            if (intersection(vert, otherDiag2) && intersection(diag1, otherDiag2) && otherDiag2.open) {
              canGoLeft=false;
              canGoDown = false;
            }
          }

          if (other.rotation == 5) {
            if (((intersection(diag2, otherDiagonal) && otherDiagonal.open) || (intersection(vert, otherDiagonal) && otherDiagonal.open))
              && (corner1.y < other.pos.y+size.y-2 && corner2.x < other.pos.x+size.x-2)) {
              canGoDown = false;
              canGoRight = false;
            } else if (intersection(vert, otherHor) && otherHor.open && corner3.x<other.pos.x+size.x-2) {
              canGoUp= false;
            } else if ((intersection(diag2, otherDiagonal)  && otherDiagonal.open) && corner3.x<other.pos.x) {
              canGoUp= false;
              canGoRight= false;
            } else if ((intersection(vert, otherDiagonal)  && otherDiagonal.open) || (intersection(vert, otherHor)) && otherHor.open) {
              canGoLeft= false;
            }
          }
          if (other.rotation == 6) {
            if (intersection(vert, otherDiag2) && otherDiag2.open) {
              canGoLeft=false;
            }
            if (intersection(diag1, otherHor) && otherHor.open) {
              canGoDown=false;
            }
            if ((intersection(diag1, otherDiag1) && otherDiag1.open) || (intersection(vert, otherDiag1) && otherDiag1.open) ) {
              canGoRight=false; 
              if (pos.y>other.pos.y) {
                canGoUp=false;
              }
            }
            if (intersection(diag2, otherDiag2) && otherDiag2.open) {
              canGoUp=false;
            }
          }

          if (other.rotation == 7) {
            if ((intersection(diag2, otherHor) && otherHor.open) && (intersection(diag2, otherVert) && otherVert.open)) {
              canGoUp=false;
              canGoRight=false;
            } else if ((intersection(vert, otherHor) && otherHor.open) && (intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoLeft=false;
            } else if ((intersection(diag1, otherVert) && otherVert.open) && (intersection(diag1, otherDiagonal) && otherDiagonal.open)) {
              canGoDown=false;
              canGoRight=false;
            } else if (intersection(vert, otherDiagonal) && otherDiagonal.open) {
              canGoDown=false;
              canGoLeft=false;
            } else if (intersection(vert, otherHor) && otherHor.open) {
              canGoUp=false;
            } else if (intersection(diag1, otherVert) && otherVert.open) {
              canGoRight=false;
            }
          }
        }

        if (rotation == 5) { //----------------ROTATION5----------------//

          if (other.rotation == 0) {
            if (intersection(hor, otherVert) && intersection(diagonal, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
            if (intersection(vert, otherDiag2) && intersection(diagonal, otherDiag2) && otherDiag2.open) {
              canGoRight=false;
              canGoUp=false;
            }
            if (intersection(vert, otherDiag1) && intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoRight=false;
              canGoDown=false;
            }
            if (intersection(hor, otherDiag1) && intersection(hor, otherVert) && otherVert.open && otherDiag1.open) {
              canGoDown=false;
            }
            if (intersection(vert, otherDiag2) && intersection(vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoRight=false;
            }
            if (intersection(diagonal, otherVert) && intersection(diagonal, otherDiag2) && otherVert.open && otherDiag2.open) {
              canGoUp=false;
              canGoLeft=false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && pos.y+size.y<otherHor.v1.y+2) {
              canGoDown = false;
            }
            if ((intersection(hor, otherVert) && otherVert.open || intersection(diagonal, otherVert) && otherVert.open) && pos.x+size.x<otherVert.v1.x+2) {
              canGoRight = false;
              canGoDown = true;
            }

            if ((intersection(hor, otherDiagonal) && otherDiagonal.open || intersection(vert, otherDiagonal) && otherDiagonal.open) 
              && pos.y+size.y>otherHor.v1.y+2 && pos.x+size.x>otherVert.v1.x+2) {
              canGoLeft= false;
              canGoUp = false;
            }
          }

          if (other.rotation == 2) {
            if (intersection(hor, otherDiag1) && intersection(hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoDown=false;
            }
            if (intersection(diagonal, otherHor) && intersection(diagonal, otherDiag1) && otherHor.open && otherDiag1.open) {
              canGoLeft=false;
              canGoUp=false;
            }
            if (intersection(vert, otherHor) && intersection(vert, otherDiag2) && otherHor.open && otherDiag2.open) {
              canGoRight=false;
            }
            if (intersection(hor, otherDiag2) && intersection(vert, otherDiag2) && otherDiag2.open) {
              canGoDown=false;
              canGoRight = false;
            }
            if (intersection(diagonal, otherHor) && intersection(vert, otherHor) && otherHor.open) {
              canGoUp=false;
            }
            if (intersection(diagonal, otherDiag1) && intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoDown=false;
              canGoLeft=false;
            }
          }

          if (other.rotation == 3) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && !(intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoDown = false;
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
            } else if ((intersection(diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(diagonal, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoUp = false;
            } 
            if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoRight = false;
            } 
            if ((intersection(diagonal, otherVert) && otherVert.open) && !(intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoUp = false;
            }
          }
          if (other.rotation == 4) {
            if (((intersection(diagonal, otherDiag2) && otherDiag2.open) || (intersection(diagonal, otherVert) && otherVert.open))
              && (pos.y+size.y > other.corner1.y+2 && pos.x+size.x > other.corner2.x+2)) {
              canGoUp = false;
              canGoLeft = false;
            } else if (intersection(hor, otherVert) && otherVert.open && pos.x+size.x>other.corner3.x+2) {
              canGoDown = false;
            } else if ((intersection(diagonal, otherDiag2)  && otherDiag2.open) && pos.x>other.corner3.x) {
              canGoDown= false;
              canGoLeft= false;
            } else if ((intersection(diagonal, otherVert)  && otherVert.open) || (intersection(hor, otherVert)) && otherVert.open) {
              canGoRight= false;
            }
          }
          if (other.rotation == 5) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoUp = false;
              if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
                canGoUp = true;
                canGoRight = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoLeft = true;
                canGoDown = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open) || (intersection(diagonal, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoUp = false;
            } else if ((intersection(otherDiagonal, vert) && otherDiagonal.open) || (intersection(otherDiagonal, hor) && otherDiagonal.open)) {
              canGoDown = false;
              canGoRight = false;
            }
          }
          if (other.rotation == 6) {
            if ((intersection(hor, otherDiag2) && otherDiag2.open || intersection(vert, otherDiag2) && otherDiag2.open) ||
              (intersection(diagonal, otherHor) && otherHor.open && intersection(diagonal, otherDiag1) && otherDiag1.open)) {
              canGoLeft = false;
              canGoUp = false;
              if (pos.y+size.y<other.corner3.y+2) {
                canGoDown = false;
                canGoLeft = true;
                canGoUp = false;
              }
            } else if (intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoRight = false;
              canGoUp = false;
              if (intersection(vert, otherHor) && otherHor.open && pos.y+size.y<other.corner2.y+2) {
                canGoRight = true;
              }
              if (pos.x+size.x<other.corner2.x+2) {
                canGoUp = true;
              }
            } else if ((intersection(vert, otherHor) && otherHor.open) || (intersection(diagonal, otherHor) && otherHor.open)) {
              canGoDown = false;
              canGoLeft = true;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoUp = false;
              if ((intersection(diagonal, otherVert) && otherVert.open)) {
                canGoUp = true;
                canGoRight = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoRight = true;
                canGoDown = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open)) {
              canGoLeft = false;
              canGoUp = false;
            } else if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoDown = false;
              canGoLeft = false;
              if ((intersection(hor, otherVert) && otherVert.open)) {
                canGoLeft = true;
              }
            }
          }
        }

        if (rotation == 6) { //----------------ROTATION6----------------//

          if (other.rotation == 0) {
            if (intersection(hor, otherDiag2) && otherDiag2.open) {
              canGoUp=false;
            }
            if (intersection(diag1, otherVert) && otherVert.open) {
              canGoLeft=false;
            }
            if ((intersection(diag1, otherDiag1) && otherDiag1.open) || (intersection(hor, otherDiag1) && otherDiag1.open) ) {
              canGoDown=false; 
              if (pos.x<other.pos.x) {
                canGoRight=false;
              }
            }
            if (intersection(diag2, otherDiag2) && otherDiag2.open) {
              canGoRight=false;
            }
          }
          if (other.rotation == 1) {
            if ((intersection(diag2, otherVert) && otherVert.open) && (intersection(diag2, otherHor) && otherHor.open)) {
              canGoRight=false;
              canGoDown=false;
            } else if ((intersection(hor, otherVert) && otherVert.open) && (intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoUp=false;
            } else if ((intersection(diag1, otherHor) && otherHor.open) && (intersection(diag1, otherDiagonal) && otherDiagonal.open)) {
              canGoLeft=false;
              canGoDown=false;
            } else if (intersection(hor, otherDiagonal) && otherDiagonal.open) {
              canGoLeft=false;
              canGoUp=false;
            } else if (intersection(hor, otherVert) && otherVert.open) {
              canGoRight=false;
            } else if (intersection(diag1, otherHor) && otherHor.open) {
              canGoDown=false;
            }
          }
          if (other.rotation == 2) {
            if (((intersection(diag1, otherHor) && otherHor.open) || (intersection(diag2, otherHor) && otherHor.open)) && pos.y>other.pos.y-2) {
              canGoUp=false;
            } else {
              if (((intersection(diag1, otherDiag2) && otherDiag2.open) || (intersection(diag1, otherHor) && otherHor.open))
                && corner1.x>other.corner1.x) {
                canGoLeft=false;
                canGoDown=false;
              }
              if (((intersection(diag2, otherDiag1) && otherDiag1.open) || (intersection(diag2, otherHor) && otherHor.open))
                && corner1.x<other.corner1.x) {
                canGoRight=false;
                canGoDown=false;
              }
            }
          }
          if (other.rotation == 3) {
            if ((intersection(diag2, otherDiagonal) && otherDiagonal.open) && (intersection(diag2, otherHor) && otherHor.open)) {
              canGoRight=false;
              canGoDown=false;
            } else if ((intersection(hor, otherVert) && otherVert.open) && (intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoUp=false;
            } else if ((intersection(diag1, otherHor) && otherHor.open) && (intersection(diag1, otherVert) && otherVert.open)) {
              canGoLeft=false;
              canGoDown=false;
            } else if (intersection(hor, otherDiagonal) && otherDiagonal.open) {
              canGoRight=false;
              canGoUp=false;
            } else if (intersection(hor, otherVert) && otherVert.open) {
              canGoLeft=false;
            } else if (intersection(diag1, otherHor) && otherHor.open) {
              canGoDown=false;
            }
          }
          if (other.rotation == 4) {

            if (intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoUp=false;
            }
            if (intersection(diag2, otherVert) && otherVert.open) {
              canGoRight=false;
            }
            if ((intersection(diag2, otherDiag2) && otherDiag2.open) || (intersection(hor, otherDiag2) && otherDiag2.open) ) {
              canGoDown=false; 
              if (pos.x>other.pos.x) {
                canGoLeft=false;
              }
            }
            if (intersection(diag1, otherDiag1) && otherDiag1.open) {
              canGoLeft=false;
            }
          }

          if (other.rotation == 5) {
            if ((intersection(diag1, otherDiagonal) && otherDiagonal.open || intersection(hor, otherDiagonal) && otherDiagonal.open)
              && other.pos.y+size.y>corner2.y+2 && other.pos.x<corner3.x-2 && other.pos.x+other.size.x>corner1.x+2) {
              canGoDown = false;
              canGoRight = false;
            } else if (intersection(diag1, otherVert) && otherVert.open) {
              canGoDown = false;
              canGoLeft = false;
              if (intersection(hor, otherVert) && otherVert.open) {
                canGoDown = true;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open) || (intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoUp = false;
              canGoRight = true;
            }
          }
          if (other.rotation == 6) {
            if (intersection(hor, otherDiag1) && intersection(hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoUp=false;
            }
            if (intersection(diag1, otherHor) && intersection(diag1, otherDiag2) && otherHor.open && otherDiag2.open) {
              canGoDown=false;
              canGoLeft=false;
            }
            if (intersection(diag2, otherHor) && intersection(diag2, otherDiag1) && otherHor.open && otherDiag1.open) {
              canGoDown=false;
              canGoRight=false;
            }
            if (intersection(hor, otherDiag1) && intersection(diag2, otherDiag1) && otherDiag1.open) {
              canGoUp = false;
              canGoRight = false;
            }
            if (intersection(diag1, otherHor) && intersection(diag2, otherHor) && otherHor.open) {
              canGoDown=false;
            }
            if (intersection(hor, otherDiag2) && intersection(diag1, otherDiag2) && otherDiag2.open) {
              canGoUp=false;
              canGoLeft = false;
            }
          }

          if (other.rotation == 7) {
            if (((intersection(diag2, otherDiagonal) && otherDiagonal.open) || (intersection(hor, otherDiagonal) && otherDiagonal.open))
              && (corner1.x > other.pos.x+2 && corner2.y < other.pos.y+size.y-2)) {
              canGoLeft = false;
              canGoDown = false;
            } else if (intersection(hor, otherVert) && otherVert.open && corner3.y<other.pos.y+size.y-2) {
              canGoRight= false;
            } else if ((intersection(diag2, otherDiagonal)  && otherDiagonal.open) && corner3.y<other.pos.y) {
              canGoRight= false;
              canGoDown= false;
            } else if ((intersection(hor, otherDiagonal)  && otherDiagonal.open) || (intersection(hor, otherVert)) && otherVert.open) {
              canGoUp= false;
            }
          }
        }

        if (rotation == 7) { //----------------ROTATION7----------------//

          if (other.rotation == 0) {
            if ((intersection(vert, otherDiag2) && otherDiag2.open || intersection(hor, otherDiag2) && otherDiag2.open) ||
              (intersection(diagonal, otherVert) && otherVert.open && intersection(diagonal, otherDiag1) && otherDiag1.open)) {
              canGoUp = false;
              canGoRight = false;
              if (pos.x>other.corner3.x-2) {
                canGoLeft = false;
                canGoUp = true;
                canGoRight = false;
              }
            } else if (intersection(hor, otherDiag1) && otherDiag1.open) {
              canGoDown = false;
              canGoRight = false;
              if (intersection(hor, otherVert) && otherVert.open && pos.x>other.corner2.x-2) {
                canGoDown = true;
              }
              if (pos.y+size.y<other.corner2.y+2) {
                canGoRight = true;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open) || (intersection(diagonal, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoUp = true;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && !(intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoDown = false;
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
            } else if ((intersection(diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(diagonal, otherVert) && otherVert.open)) {
              canGoLeft = false;
              canGoUp = false;
            } 
            if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
              canGoLeft = false;
            } 
            if ((intersection(diagonal, otherVert) && otherVert.open) && !(intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoUp = false;
            }
          }
          if (other.rotation == 2) {
            if (intersection(vert, otherHor) && intersection(diagonal, otherHor) && otherHor.open) {
              canGoUp=false;
            }
            if (intersection(hor, otherDiag2) && intersection(diagonal, otherDiag2) && otherDiag2.open) {
              canGoDown=false;
              canGoRight=false;
            }
            if (intersection(hor, otherDiag1) && intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoDown=false;
              canGoLeft=false;
            }
            if (intersection(vert, otherDiag1) && intersection(vert, otherHor) && otherHor.open && otherDiag1.open) {
              canGoLeft=false;
            }
            if (intersection(hor, otherDiag2) && intersection(hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoDown=false;
            }
            if (intersection(diagonal, otherHor) && intersection(diagonal, otherDiag2) && otherHor.open && otherDiag2.open) {
              canGoRight=false;
              canGoUp=false;
            }
          }
          if (other.rotation == 3) {
            if ((intersection(vert, otherHor) && otherHor.open || intersection(diagonal, otherHor) && otherHor.open) && pos.y+size.y<otherHor.v1.y+2) {
              canGoDown = false;
            }
            if ((intersection(hor, otherVert) && otherVert.open || intersection(diagonal, otherVert) && otherVert.open) && pos.x>otherVert.v1.x-2) {
              canGoLeft = false;
              canGoDown = true;
            }

            if ((intersection(hor, otherDiagonal) && otherDiagonal.open || intersection(vert, otherDiagonal) && otherDiagonal.open) 
              && pos.y+size.y>otherHor.v1.y+2 && pos.x<otherVert.v1.x-2) {
              canGoRight= false;
              canGoUp = false;
            }
          }
          if (other.rotation == 4) {
            if (intersection(vert, otherDiag1) && intersection(vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              canGoLeft=false;
            }
            if (intersection(diagonal, otherVert) && intersection(diagonal, otherDiag1) && otherVert.open && otherDiag1.open) {
              canGoUp=false;
              canGoRight=false;
            }
            if (intersection(hor, otherVert) && intersection(hor, otherDiag2) && otherVert.open && otherDiag2.open) {
              canGoDown=false;
            }
            if (intersection(vert, otherDiag2) && intersection(hor, otherDiag2) && otherDiag2.open) {
              canGoLeft=false;
              canGoDown = false;
            }
            if (intersection(diagonal, otherVert) && intersection(hor, otherVert) && otherVert.open) {
              canGoRight=false;
            }
            if (intersection(diagonal, otherDiag1) && intersection(vert, otherDiag1) && otherDiag1.open) {
              canGoLeft=false;
              canGoUp=false;
            }
          }
          if (other.rotation == 5) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoUp = false;
              if ((intersection(diagonal, otherVert) && otherVert.open)) {
                canGoUp = true;
                canGoLeft = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoLeft = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoLeft = true;
                canGoDown = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open)) {
              canGoRight = false;
              canGoUp = false;
            } else if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
              canGoDown = false;
              canGoRight = false;
              if ((intersection(hor, otherVert) && otherVert.open)) {
                canGoRight = true;
              }
            }
          }
          if (other.rotation == 6) {
            if (((intersection(diagonal, otherDiag2) && otherDiag2.open) || (intersection(diagonal, otherHor) && otherHor.open))
              && (pos.x < other.corner1.x-2 && pos.y+size.y > other.corner2.y+2)) {
              canGoRight = false;
              canGoUp = false;
            } else if (intersection(vert, otherHor) && otherHor.open && pos.y+size.y>other.corner3.y+2) {
              canGoLeft = false;
            } else if ((intersection(diagonal, otherDiag2)  && otherDiag2.open) && pos.y>other.corner3.y) {
              canGoLeft= false;
              canGoUp= false;
            } else if ((intersection(diagonal, otherHor)  && otherHor.open) || (intersection(vert, otherHor)) && otherHor.open) {
              canGoDown= false;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(vert, otherHor) && otherHor.open)) {
              canGoUp = false;
              if ((intersection(vert, otherDiagonal) && otherDiagonal.open)) {
                canGoUp = true;
                canGoLeft = false;
              }
            } else if ((intersection(hor, otherVert) && otherVert.open)) {
              canGoRight = false;
              if ((intersection(hor, otherDiagonal) && otherDiagonal.open)) {
                canGoRight = true;
                canGoDown = false;
              }
            } else if ((intersection(diagonal, otherHor) && otherHor.open) || (intersection(diagonal, otherVert) && otherVert.open)) {
              canGoRight = false;
              canGoUp = false;
            } else if ((intersection(otherDiagonal, vert) && otherDiagonal.open) || (intersection(otherDiagonal, hor) && otherDiagonal.open)) {
              canGoDown = false;
              canGoLeft = false;
            }
          }
        }
      }
    }
  }

  void detectMB() {

    tP.detectMovingBlocks(this);
  }

  void floatBack() {

    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i) != this && (!triBlocks.get(i).movable || !touchingMover)) {
        triBlock other = triBlocks.get(i);
        edge otherHor = triBlocks.get(i).hor;
        edge otherVert = triBlocks.get(i).vert;
        edge otherDiagonal = triBlocks.get(i).diagonal;
        edge otherDiag1 = triBlocks.get(i).diag1;
        edge otherDiag2 = triBlocks.get(i).diag2;
        PVector c1 = triBlocks.get(i).corner1;
        PVector c2 = triBlocks.get(i).corner2;
        PVector c3 = triBlocks.get(i).corner3;

        for (int k=0; k<3; k++) {

          if ((pointLineDistance(corner1.x, corner1.y, other.edges[0].v1.x, other.edges[0].v1.y, other.edges[0].v2.x, other.edges[0].v2.y) > 2
            && pointLineDistance(corner1.x, corner1.y, other.edges[1].v1.x, other.edges[1].v1.y, other.edges[1].v2.x, other.edges[1].v2.y) > 2
            && pointLineDistance(corner1.x, corner1.y, other.edges[2].v1.x, other.edges[2].v1.y, other.edges[2].v2.x, other.edges[2].v2.y) > 2
            && triPointInt(c1.x, c1.y, c2.x, c2.y, c3.x, c3.y, corner1.x, corner1.y))

            || (pointLineDistance(corner2.x, corner2.y, other.edges[0].v1.x, other.edges[0].v1.y, other.edges[0].v2.x, other.edges[0].v2.y) > 2
            && pointLineDistance(corner2.x, corner2.y, other.edges[1].v1.x, other.edges[1].v1.y, other.edges[1].v2.x, other.edges[1].v2.y) > 2
            && pointLineDistance(corner2.x, corner2.y, other.edges[2].v1.x, other.edges[2].v1.y, other.edges[2].v2.x, other.edges[2].v2.y) > 2
            && triPointInt(c1.x, c1.y, c2.x, c2.y, c3.x, c3.y, corner2.x, corner2.y))

            || (pointLineDistance(corner3.x, corner3.y, other.edges[0].v1.x, other.edges[0].v1.y, other.edges[0].v2.x, other.edges[0].v2.y) > 2
            && pointLineDistance(corner3.x, corner3.y, other.edges[1].v1.x, other.edges[1].v1.y, other.edges[1].v2.x, other.edges[1].v2.y) > 2
            && pointLineDistance(corner3.x, corner3.y, other.edges[2].v1.x, other.edges[2].v1.y, other.edges[2].v2.x, other.edges[2].v2.y) > 2
            && triPointInt(c1.x, c1.y, c2.x, c2.y, c3.x, c3.y, corner3.x, corner3.y))) {

            if (intersection(edges[k], otherHor) && otherHor.open) {
              if (other.rotation==6 || other.rotation==1 || other.rotation==3) {
                pos.y-=0.5;
              }
              if (other.rotation==2 || other.rotation==5 || other.rotation==7) {
                pos.y+=0.5;
              }
            }
            if (intersection(edges[k], otherVert) && otherVert.open) {
              if (other.rotation==0 || other.rotation==3 || other.rotation==5) {
                pos.x+=0.5;
              }
              if (other.rotation==4 || other.rotation==1 || other.rotation==7) {
                pos.x-=0.5;
              }
            }
            if (intersection(edges[k], otherDiagonal) && otherDiagonal.open) {
              if (other.rotation==1) {
                pos.x+=0.5;
                pos.y+=0.5;
              }
              if (other.rotation==3) {
                pos.x-=0.5;
                pos.y+=0.5;
              }
              if (other.rotation==5) {
                pos.x-=0.5;
                pos.y-=0.5;
              }
              if (other.rotation==7) {
                pos.x+=0.5;
                pos.y-=0.5;
              }
            }
            if (intersection(edges[k], otherDiag1) && otherDiag1.open) {
              if (other.rotation==0) {
                pos.x-=0.5;
                pos.y-=0.5;
              }
              if (other.rotation==2) {
                pos.x+=0.5;
                pos.y-=0.5;
              }
              if (other.rotation==4) {
                pos.x+=0.5;
                pos.y-=0.5;
              }
              if (other.rotation==6) {
                pos.x+=0.5;
                pos.y+=0.5;
              }
            }
            if (intersection(edges[k], otherDiag2) && otherDiag2.open) {
              if (other.rotation==0) {
                pos.x-=0.5;
                pos.y+=0.5;
              }
              if (other.rotation==2) {
                pos.x-=0.5;
                pos.y-=0.5;
              }
              if (other.rotation==4) {
                pos.x+=0.5;
                pos.y+=0.5;
              }
              if (other.rotation==6) {
                pos.x-=0.5;
                pos.y+=0.5;
              }
            }
          }
        }
      }
    }

    for (int i=0; i<doors.size(); i++) {
      if (!doors.get(i).triggered) {
        door d = doors.get(i);
        edge doorEdge = new edge(d.v1.x, d.v1.y, d.v2.x, d.v2.y);
        PVector center = new PVector(pos.x+(size.x/2), pos.y+(size.y/2));
        PVector mid = midPoint(center, corner1);

        for (int k=0; k<3; k++) {

          if ((pointLineDistance(corner1.x, corner1.y, doorEdge.v1.x, doorEdge.v1.y, doorEdge.v2.x, doorEdge.v2.y) > 2
            && intersection(doorEdge, edges[0]) && intersection(doorEdge, edges[2]))

            || (pointLineDistance(corner2.x, corner2.y, doorEdge.v1.x, doorEdge.v1.y, doorEdge.v2.x, doorEdge.v2.y) > 2
            && intersection(doorEdge, edges[0]) && intersection(doorEdge, edges[1]))

            || (pointLineDistance(corner3.x, corner3.y, doorEdge.v1.x, doorEdge.v1.y, doorEdge.v2.x, doorEdge.v2.y) > 2
            && intersection(doorEdge, edges[1]) && intersection(doorEdge, edges[2]))) {

            if (d.v1.y==d.v2.y) {
              if (mid.x> d.v1.x) {
                pos.x+=0.5;
              } else {
                pos.x-=0.5;
              }
            } else if (d.v1.x==d.v2.x) {

              if (mid.y> d.v1.y) {
                pos.y+=0.5;
              } else {
                pos.y-=0.5;
              }
            } else if (d.v1.y>d.v2.y) {
              if (mid.y+mid.x> d.v1.y+d.v1.x) {
                pos.x+=0.5;
                pos.y+=0.5;
              } else {
                pos.x-=0.5;
                pos.y-=0.5;
              }
            } else {

              if (mid.y-mid.x> d.v1.y-d.v1.x) {
                pos.x-=0.5;
                pos.y+=0.5;
              } else {
                pos.x+=0.5;
                pos.y-=0.5;
              }
            }
          }
        }
      }
    }
  }

  boolean otherGoingRight() {
    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i).movable && triBlocks.get(i) != this && triBlocks.get(i).goingRight) return true;
    }
    return false;
  }

  boolean otherGoingLeft() {
    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i).movable && triBlocks.get(i) != this && triBlocks.get(i).goingLeft) return true;
    }
    return false;
  }

  boolean otherGoingUp() {
    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i).movable && triBlocks.get(i) != this && triBlocks.get(i).goingUp) return true;
    }
    return false;
  }

  boolean otherGoingDown() {
    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i).movable && triBlocks.get(i) != this && triBlocks.get(i).goingDown) return true;
    }
    return false;
  }

  void fluidMoveR(boolean setVel) {
    if (setVel && !otherGoingRight())Mover.vLimitX = Mover.halfvLimit;
    else Mover.vLimitX = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.x>0 && canGoRight) {
      goingRight=true;
      pos.x+=vel.x;
    }
  }
  void fluidMoveD(boolean setVel) {
    if (setVel && !otherGoingDown())Mover.vLimitY = Mover.halfvLimit;
    else Mover.vLimitY = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.y>0 && canGoDown) {
      goingDown=true;
      pos.y+=vel.y;
    }
  }
  void fluidMoveL(boolean setVel) {
    if (setVel && !otherGoingLeft())Mover.vLimitX = Mover.halfvLimit;
    else Mover.vLimitX = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.x<0 && canGoLeft) {
      goingLeft=true;
      pos.x+=vel.x;
    }
  }
  void fluidMoveU(boolean setVel) {
    if (setVel && !otherGoingUp())Mover.vLimitY = Mover.halfvLimit;
    else Mover.vLimitY = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.y<0 && canGoUp) {
      goingUp=true;
      pos.y+=vel.y;
    }
  }
  void fluidMoveUL(boolean setVel) {
    if (setVel && !otherGoingLeft())Mover.vLimitX = Mover.halfvLimit;
    else Mover.vLimitX = Mover.QuartervLimit;
    if (setVel && !otherGoingUp())Mover.vLimitY = Mover.halfvLimit;
    else Mover.vLimitY = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.y<0 && canGoUp) {
      goingUp=true;
      pos.y+=vel.y;
    }
    if (vel.x<0 && canGoLeft) {
      goingLeft=true;
      pos.x+=vel.x;
    }
  }
  void fluidMoveUR(boolean setVel) {
    if (setVel && !otherGoingRight())Mover.vLimitX = Mover.halfvLimit;
    else Mover.vLimitX = Mover.QuartervLimit;
    if (setVel && !otherGoingUp())Mover.vLimitY = Mover.halfvLimit;
    else Mover.vLimitY = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.y<0 && canGoUp) {
      goingUp=true;
      pos.y+=vel.y;
    }
    if (vel.x>0 && canGoRight) {
      goingRight=true;
      pos.x+=vel.x;
    }
  }
  void fluidMoveDL(boolean setVel) {
    if (setVel && !otherGoingLeft())Mover.vLimitX = Mover.halfvLimit;
    else Mover.vLimitX = Mover.QuartervLimit;
    if (setVel && !otherGoingDown())Mover.vLimitY = Mover.halfvLimit;
    else Mover.vLimitY = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.y>0 && canGoDown) {
      goingDown=true;
      pos.y+=vel.y;
    }
    if (vel.x<0 && canGoLeft) {
      goingLeft=true;
      pos.x+=vel.x;
    }
  }
  void fluidMoveDR(boolean setVel) {
    if (setVel && !otherGoingRight())Mover.vLimitX = Mover.halfvLimit;
    else Mover.vLimitX = Mover.QuartervLimit;
    if (setVel && !otherGoingDown())Mover.vLimitY = Mover.halfvLimit;
    else Mover.vLimitY = Mover.QuartervLimit;
    if (setVel)vel.set(Mover.vel);
    if (vel.y>0 && canGoDown) {
      goingDown=true;
      pos.y+=vel.y;
    }
    if (vel.x>0 && canGoRight) {
      goingRight=true;
      pos.x+=vel.x;
    }
  }

  void triFade() {
    if (fadeTime==0) { 
      removed=true;
    } else {
      fadeTime-=1;
    }
  }

  void show() {
    noStroke();
    if (!movable) fill(100, 100, 200);
    else if (!dying) fill(100, 200, 100);
    else fill(100, 200, 100, map(fadeTime, 0, fadeT, 0, 255));
    if (!movable) {
      if (texturesOn) {
      } else {
        fill(100, 100, 200);
        triangle(corner1.x, corner1.y, corner2.x, corner2.y, corner3.x, corner3.y);
      }
    } else { 
      if (!dying)stroke(50, 100, 50);
      else stroke(50, 100, 50, map(fadeTime, 0, fadeT, 0, 255));
      strokeWeight(4);
      strokeJoin(ROUND);
      triangle(corner1.x, corner1.y, corner2.x, corner2.y, corner3.x, corner3.y);
      if (!dying)stroke(200);
      else stroke(200, map(fadeTime, 0, fadeT, 0, 255));
      strokeWeight(5);
      strokeJoin(ROUND);
      line(corner2.x, corner2.y, corner3.x, corner3.y);
    }
  }

  void showStroke() {
    if(texturesOn){
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
    }else stroke(75, 75, 150);
    strokeWeight(4);
    if (!movable) {
      if (edges[0].open == true) line(corner1.x, corner1.y, corner2.x, corner2.y);
      if (edges[1].open == true) line(corner2.x, corner2.y, corner3.x, corner3.y);
      if (edges[2].open == true) line(corner3.x, corner3.y, corner1.x, corner1.y);
    }
  }

  void showMirrors() {
    if (!movable) {
      stroke(200);
      strokeWeight(5);
      if (edges[0].mirror == true) line(corner1.x, corner1.y, corner2.x, corner2.y);
      if (edges[1].mirror == true) line(corner2.x, corner2.y, corner3.x, corner3.y);
      if (edges[2].mirror == true) line(corner3.x, corner3.y, corner1.x, corner1.y);
    }
  }

  void corners() {
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
  } 

  void edges() {
    edges[0] = new edge(corner1.x, corner1.y, corner2.x, corner2.y);
    edges[1] = new edge(corner2.x, corner2.y, corner3.x, corner3.y);
    edges[2] = new edge(corner3.x, corner3.y, corner1.x, corner1.y);
    if (movable)edges[1].mirror = true;
  }

  void horVertEdges() {
    diagonal = edges[1];
    hor = edges[0];
    vert = edges[2];
    diag1 = edges[0];
    diag2 = edges[2];
    if (rotation==1 || rotation==5) {
      diagonal = edges[1];
      hor = edges[0];
      vert = edges[2];
    } else if (rotation==3 || rotation==7) {
      diagonal = edges[1];
      hor = edges[2];
      vert = edges[0];
    } else if (rotation==0 || rotation==4) {
      diag1 = edges[0];
      vert = edges[1];
      diag2 = edges[2];
    } else if (rotation==2 || rotation==6) {
      diag1 = edges[0];
      hor = edges[1];
      diag2 = edges[2];
    }
  }
}
