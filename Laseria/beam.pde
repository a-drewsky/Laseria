class beam {

  PVector initialPos;
  int direction;
  ArrayList <PVector>intersections;
  ArrayList<PVector> curInts;
  ArrayList<Integer> curMirs;
  ArrayList<Integer> curTrigs;
  float it = Grid.Xiteration;
  float gap = 2;
  int frequency;
  color c;
  
  
  

  beam(float Xp, float Yp, int dir, int freq) {
    c=freqColors[freq-1];
    frequency = freq;
    initialPos = new PVector(Xp, Yp);
    direction = dir;
    intersections = new ArrayList<PVector>();
    curInts = new ArrayList<PVector>();
    curMirs = new ArrayList<Integer>();
    curTrigs = new ArrayList<Integer>();
    intersections.add(new PVector(initialPos.x, initialPos.y));
    getIntersections(initialPos.x, initialPos.y, dir, 5);
  }

  void show() {
    for (int i=1; i<intersections.size(); i++) {
      PVector inter0 = intersections.get(i-1);
      PVector inter1 = intersections.get(i);
      stroke(c);
      strokeWeight(4);
      line(inter0.x, inter0.y, inter1.x, inter1.y);
    }
    
  }
  
  

  void getIntersections(float x, float y, int dir, float d) {
    edge e= new edge(0, 0, 0, 0);
    float dist = d;
    if (dir == 0) e = new edge(x, y, x, y-dist-5);
    if (dir == 1) e = new edge(x, y, x+dist+5, y-dist-5);
    if (dir == 2) e = new edge(x, y, x+dist+5, y);
    if (dir == 3) e = new edge(x, y, x+dist+5, y+dist+5);
    if (dir == 4) e = new edge(x, y, x, y+dist+5);
    if (dir == 5) e = new edge(x, y, x-dist-5, y+dist+5);
    if (dir == 6) e = new edge(x, y, x-dist-5, y);
    if (dir == 7) e = new edge(x, y, x-dist-5, y-dist-5);
    Intersections(e, x, y, dir, dist);
  }

  void Intersections (edge e, float x, float y, int dir, float d) {
    edge topE = new edge (0, 0, width, 0); //screen edges
    edge bottomE = new edge (0, height, width, height);
    edge leftE = new edge (0, 0, 0, height);
    edge rightE = new edge (width, 0, width, height);

    curInts.clear();
    curMirs.clear();
    curTrigs.clear();

    if (intersection(e, topE)) { //collision with screen edges *****
      PVector inter = intersectionPoint(e, topE);
      curInts.add(inter);
      curMirs.add(-1);
      curTrigs.add(-1);
      //intersections.add(inter);
      //return;
    }
    if (intersection(e, bottomE)) {
      PVector inter = intersectionPoint(e, bottomE);
      curInts.add(inter);
      curMirs.add(-1);
      curTrigs.add(-1);
      //intersections.add(inter);
      //return;
    }
    if (intersection(e, leftE)) {
      PVector inter = intersectionPoint(e, leftE);
      curInts.add(inter);
      curMirs.add(-1);
      curTrigs.add(-1);
      //intersections.add(inter);
      //return;
    }
    if (intersection(e, rightE)) {
      PVector inter = intersectionPoint(e, rightE);
      curInts.add(inter);
      curMirs.add(-1);
      curTrigs.add(-1);
      //intersections.add(inter);
      //return;
    }

    for (int i=0; i<doors.size(); i++) { //collision with doors *****
      door dor = doors.get(i);
      edge dorE = new edge(dor.v1.x,dor.v1.y,dor.v2.x,dor.v2.y);
      if (intersection(e, dorE) && !dor.triggered) {
        PVector inter = intersectionPoint(e, dorE);
        curInts.add(inter);
        curMirs.add(-1);
      curTrigs.add(-1);
      }
    }

    for (int i=0; i<lasers.size(); i++) { //collision with lasers *****
      laser l = lasers.get(i);
      PVector lPos = new PVector(l.pos.x, l.pos.y);
      if (lineCircleInt(e, lPos, l.r)) {
        PVector inter = new PVector();
        ArrayList<PVector> points = CircleLineIntersectionPoints(e.v1, e.v2, lPos, l.r);
        if(points.size()==1){
        inter = points.get(0);
        }else{
          if(dist(e.v1.x,e.v1.y,points.get(0).x,points.get(0).y) < dist(e.v1.x,e.v1.y,points.get(1).x,points.get(1).y)){
            inter = points.get(0);
          }else{
            inter = points.get(1);
          }
        }
        curInts.add(inter);
        curMirs.add(-1);
      curTrigs.add(-1);
      }
    }
    
    
    
    



    /*for (int i=0; i<endZones.size(); i++) { //collision with endZones *****
      edge bTop = endZones.get(i).edges[0];
      edge bRight = endZones.get(i).edges[1];
      edge bBottom = endZones.get(i).edges[2];
      edge bLeft = endZones.get(i).edges[3];

      if ((intersection(e, bTop))) {
        PVector inter = intersectionPoint(e, bTop);
        curInts.add(inter);
        curMirs.add(-1);
        //intersections.add(inter);
        //return;
      }
      if ((intersection(e, bLeft))) {
        PVector inter = intersectionPoint(e, bLeft);
        curInts.add(inter);
        curMirs.add(-1);
        //intersections.add(inter);
        //return;
      }
      if ((intersection(e, bBottom))) {
        PVector inter = intersectionPoint(e, bBottom);
        curInts.add(inter);
        curMirs.add(-1);
        //intersections.add(inter);
        //return;
      }
      if ((intersection(e, bRight))) {
        PVector inter = intersectionPoint(e, bRight);
        curInts.add(inter);
        curMirs.add(-1);
        //intersections.add(inter);
        //return;
      }
    }*/

    for (int j=0; j<blocks.size(); j++) { //collision with blocks *****
      edge bTop = blocks.get(j).edges[0];
      edge bRight = blocks.get(j).edges[1];
      edge bBottom = blocks.get(j).edges[2];
      edge bLeft = blocks.get(j).edges[3];

      if ((intersection(e, bTop))) {
        PVector inter = intersectionPoint(e, bTop);
        curInts.add(inter);
      curTrigs.add(-1);
        //intersections.add(inter);

        if (dir==5 && bTop.mirror) {
          curMirs.add(7);
          //getIntersections(inter.x-gap, inter.y-gap, 7, 2);
        } else if (dir==3 && bTop.mirror) {
          curMirs.add(1);
          //getIntersections(inter.x+gap, inter.y-gap, 1, 2);
        } else {
          curMirs.add(-1);
        }
        //return;
      }
      if ((intersection(e, bLeft))) {
        PVector inter = intersectionPoint(e, bLeft);
        curInts.add(inter);
      curTrigs.add(-1);
        if (dir==1 && bLeft.mirror) {
          curMirs.add(7);
          //getIntersections(inter.x-gap, inter.y-gap, 7, 2);
        } else if (dir==3 && bLeft.mirror) {
          curMirs.add(5);
          //getIntersections(inter.x-gap, inter.y+gap, 5, 2);
        } else {
          curMirs.add(-1);
        }
        //return;
      }
      if ((intersection(e, bBottom))) {
        PVector inter = intersectionPoint(e, bBottom);
        curInts.add(inter);
      curTrigs.add(-1);
        if (dir==1 && bBottom.mirror) {
          curMirs.add(3);
          //getIntersections(inter.x+gap, inter.y+gap, 3, 2);
        } else if (dir==7 && bBottom.mirror) {
          curMirs.add(5);
          //getIntersections(inter.x-gap, inter.y+gap, 5, 2);
        } else {
          curMirs.add(-1);
        }
        //return;
      }
      if ((intersection(e, bRight))) {
        PVector inter = intersectionPoint(e, bRight);
        curInts.add(inter);
      curTrigs.add(-1);
        if (dir==5 && bRight.mirror) {
          curMirs.add(3);
          //getIntersections(inter.x+gap, inter.y+gap, 3, 2);
        } else if (dir==7 && bRight.mirror) {
          curMirs.add(1);
          //getIntersections(inter.x+gap, inter.y-gap, 1, 2);
        } else {
          curMirs.add(-1);
        }
        //return;
      }
    }

    for (int i=0; i<triBlocks.size(); i++) { //collision with triblocks *****
      int rotation = triBlocks.get(i).rotation;
      edge mirror = triBlocks.get(i).edges[1];

      if (rotation == 0) {
        edge diag1 = triBlocks.get(i).edges[0]; 
        edge diag2 = triBlocks.get(i).edges[2];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==5 && mirror.mirror) {
            curMirs.add(3);
            //getIntersections(inter.x+gap, inter.y+gap, 3, 2);
          } else if (dir==7 && mirror.mirror) {
            curMirs.add(1);
            //getIntersections(inter.x+gap, inter.y-gap, 1, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, diag1) && diag1.open)) {
          PVector inter = intersectionPoint(e, diag1);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, diag2) && diag2.open)) {
          PVector inter = intersectionPoint(e, diag2);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 1) {
        edge hor = triBlocks.get(i).edges[0]; 
        edge vert = triBlocks.get(i).edges[2];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==6 && mirror.mirror) {
            curMirs.add(4);
            //getIntersections(inter.x, inter.y+gap, 4, 2);
          } else if (dir==0 && mirror.mirror) {
            curMirs.add(2);
            //getIntersections(inter.x+gap, inter.y, 2, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, hor) && hor.open)) {
          PVector inter = intersectionPoint(e, hor);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, vert) && vert.open)) {
          PVector inter = intersectionPoint(e, vert);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 2) {
        edge diag1 = triBlocks.get(i).edges[0]; 
        edge diag2 = triBlocks.get(i).edges[2];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==1 && mirror.mirror) {
            curMirs.add(3);
            //getIntersections(inter.x+gap, inter.y+gap, 3, 2);
          } else if (dir==7 && mirror.mirror) {
            curMirs.add(5);
            //getIntersections(inter.x-gap, inter.y+gap, 5, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, diag1) && diag1.open)) {
          PVector inter = intersectionPoint(e, diag1);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, diag2) && diag2.open)) {
          PVector inter = intersectionPoint(e, diag2);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 3) {
        edge hor = triBlocks.get(i).edges[2]; 
        edge vert = triBlocks.get(i).edges[0];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==0 && mirror.mirror) {
            curMirs.add(6);
            //getIntersections(inter.x-gap, inter.y, 6, 2);
          } else if (dir==2 && mirror.mirror) {
            curMirs.add(4);
            //getIntersections(inter.x, inter.y+gap, 4, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, hor) && hor.open)) {
          PVector inter = intersectionPoint(e, hor);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, vert) && vert.open)) {
          PVector inter = intersectionPoint(e, vert);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 4) {
        edge diag1 = triBlocks.get(i).edges[0]; 
        edge diag2 = triBlocks.get(i).edges[2];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==1 && mirror.mirror) {
            curMirs.add(7);
            //getIntersections(inter.x-gap, inter.y-gap, 7, 2);
          } else if (dir==3 && mirror.mirror) {
            curMirs.add(5);
            //getIntersections(inter.x-gap, inter.y+gap, 5, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, diag1) && diag1.open)) {
          PVector inter = intersectionPoint(e, diag1);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, diag2) && diag2.open)) {
          PVector inter = intersectionPoint(e, diag2);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 5) {
        edge hor = triBlocks.get(i).edges[0]; 
        edge vert = triBlocks.get(i).edges[2];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==2 && mirror.mirror) {
            curMirs.add(0);
            //getIntersections(inter.x, inter.y-gap, 0, 2);
          } else if (dir==4 && mirror.mirror) {
            curMirs.add(6);
            // getIntersections(inter.x-gap, inter.y, 6, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, hor) && hor.open)) {
          PVector inter = intersectionPoint(e, hor);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, vert) && vert.open)) {
          PVector inter = intersectionPoint(e, vert);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 6) {
        edge diag1 = triBlocks.get(i).edges[0]; 
        edge diag2 = triBlocks.get(i).edges[2];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==5 && mirror.mirror) {
            curMirs.add(7);
            // getIntersections(inter.x-gap, inter.y-gap, 7, 2);
          } else if (dir==3 && mirror.mirror) {
            curMirs.add(1);
            //getIntersections(inter.x+gap, inter.y-gap, 1, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, diag1) && diag1.open)) {
          PVector inter = intersectionPoint(e, diag1);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, diag2) && diag2.open)) {
          PVector inter = intersectionPoint(e, diag2);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }

      if (rotation == 7) {
        edge hor = triBlocks.get(i).edges[2]; 
        edge vert = triBlocks.get(i).edges[0];
        if ((intersection(e, mirror) && mirror.open)) {
          PVector inter = intersectionPoint(e, mirror);
          curInts.add(inter);
      curTrigs.add(-1);
          if (dir==4 && triBlocks.get(i).edges[1].mirror) {
            curMirs.add(2);
            //getIntersections(inter.x+gap, inter.y, 2, 2);
          } else if (dir==6 && triBlocks.get(i).edges[1].mirror) { 
            curMirs.add(0);
            //getIntersections(inter.x, inter.y-gap, 0, 2);
          } else {
            curMirs.add(-1);
          }
          //return;
        }
        if ((intersection(e, hor) && hor.open)) {
          PVector inter = intersectionPoint(e, hor);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
        if ((intersection(e, vert) && vert.open)) {
          PVector inter = intersectionPoint(e, vert);
          curInts.add(inter);
      curTrigs.add(-1);
          curMirs.add(-1);
          //return;
        }
      }
    }
    
    for (int i=0; i<triggers.size(); i++) { //collision with triggers *****
      trigger t = triggers.get(i);
      PVector tPos = new PVector(t.pos.x, t.pos.y);
      if (lineCircleInt(e, tPos, t.r)) {
        PVector inter = new PVector();
        ArrayList<PVector> points = CircleLineIntersectionPoints(e.v1, e.v2, tPos, t.r+4);
        if(points.size()==1){
        inter = points.get(0);
        }else{
          if(dist(e.v1.x,e.v1.y,points.get(0).x,points.get(0).y) < dist(e.v1.x,e.v1.y,points.get(1).x,points.get(1).y)){
            inter = points.get(0);
          }else{
            inter = points.get(1);
          }
        }
        curInts.add(inter);
        curMirs.add(-1);
      curTrigs.add(i);
        
        if(curInts.size()==1)t.triggered(frequency);
      }
    }
    
    
    
    if (curInts.size()==0) {
      getIntersections(x, y, dir, d+500); //recurssion *****
    } else {
      PVector newInt = curInts.get(0);
      int newMir = curMirs.get(0);
      int newTrig = curTrigs.get(0);
      if (curInts.size()>1) {
        for (int i=1; i<curInts.size(); i++) {
          if (pointPointDist(curInts.get(i), intersections.get(intersections.size()-1))<=pointPointDist(newInt, intersections.get(intersections.size()-1))) {
            newInt = curInts.get(i);
            newMir = curMirs.get(i);
            newTrig = curTrigs.get(i);
          }
        }
      }
      
      if(newTrig!=-1){
       triggers.get(newTrig).triggered=true; 
      }
      
      for (int i=0; i<4; i++) { //collision with Mover *****
      PVector lPoint = intersections.get(intersections.size()-1);
      if (intersection(e, Mover.edges[i])){
        PVector ints = intersectionPoint(e, Mover.edges[i]);
      if(pointPointDist(ints,lPoint)<=pointPointDist(newInt, lPoint)) {
        boolean doorTouch=false;
        for(int j=0; j<doors.size(); j++){
          door dor = doors.get(j);
          if(pointLineDistance(ints.x, ints.y, dor.v1.x, dor.v1.y, dor.v2.x, dor.v2.y) < 4) doorTouch=true;
        }
        if (!Mover.dead && !doorTouch)death();
      }
      }
    }

      
      
      for (int i=0; i<enemyArrays.size(); i++) { //collision with enemies *****
      enemy eA = enemyArrays.get(i);
      for (int j=0; j<eA.enemies.length; j++) {
        if (!eA.gaps.contains(j)) {
          PVector ePos = new PVector(eA.enemies[j].x, eA.enemies[j].y);
          if (lineCircleInt(e, ePos, enemySize/2) && eA.frequencies[j]==frequency) {
            if (enemyArrays.get(i).dying[j]==false &&
            pointPointDist(ePos, intersections.get(intersections.size()-1))<=pointPointDist(newInt, intersections.get(intersections.size()-1))) {
              enemyArrays.get(i).fadeTimes[j] = fadeT;
              eA.dying[j] = true;
              if(enemyDeathTimer<=0){
                if(soundOn) enemyDeathSound.play();
                enemyDeathTimer=5; 
              }
            }
            //eA.gaps.add(j);
          }
        }
      }
    }

    for (int i=0; i<radialEnemies.size(); i++) { //collision with radialEnemies *****
      radialEnemy rE = radialEnemies.get(i);
      for (int j=0; j<rE.enemyPositions.length; j++) {
        if (!rE.gaps.hasValue(j)) {
          PVector ePos = PVector.add(rE.center, rE.enemyPositions[j]);
          if (lineCircleInt(e, ePos, enemySize/2) && rE.frequencies[j]==frequency &&
          pointPointDist(ePos, intersections.get(intersections.size()-1))<=pointPointDist(newInt, intersections.get(intersections.size()-1))) {
            if (radialEnemies.get(i).dying[j]==false) {
              radialEnemies.get(i).fadeTimes[j] = fadeT;
              rE.dying[j] = true;
              if(soundOn) enemyDeathSound.play();
            }
            //rE.gaps.append(j);
          }
        }
      }
    }
      
      
      intersections.add(newInt);
      if (newMir==-1) {
        curInts.clear();
        curMirs.clear();
        return;
      }
      if (newMir==0) {
        getIntersections(newInt.x, newInt.y-gap, 0, 2); 
        return;
      }
      if (newMir==1) {
        getIntersections(newInt.x+gap, newInt.y-gap, 1, 2);
        return;
      }
      if (newMir==2) {
        getIntersections(newInt.x+gap, newInt.y, 2, 2);
        return;
      }
      if (newMir==3) {
        getIntersections(newInt.x+gap, newInt.y+gap, 3, 2);
        return;
      }
      if (newMir==4) {
        getIntersections(newInt.x, newInt.y+gap, 4, 2);
        return;
      }
      if (newMir==5) {
        getIntersections(newInt.x-gap, newInt.y+gap, 5, 2);
        return;
      }
      if (newMir==6) {
        getIntersections(newInt.x-gap, newInt.y, 6, 2);
        return;
      }
      if (newMir==7) {
        getIntersections(newInt.x-gap, newInt.y-gap, 7, 2);
        return;
      }
    }
  }

  boolean intersection(edge e1, edge e2) { //test for intersections
    float x1 = e1.v1.x; 
    float x2 = e1.v2.x;
    float x3 = e2.v1.x; 
    float x4 = e2.v2.x;
    float y1 = e1.v1.y; 
    float y2 = e1.v2.y;
    float y3 = e2.v1.y; 
    float y4 = e2.v2.y;

    float aN =((x4-x3)*(y1-y3))-((y4-y3)*(x1-x3));
    float bN = ((x2-x1)*(y1-y3))-((y2-y1)*(x1-x3));
    float d = ((y4-y3)*(x2-x1))-((x4-x3)*(y2-y1));

    if (d==0) {
      return false;
    }
    if (aN/d<0 || aN/d>1  ||  bN/d<0 || bN/d>1) return false;
    else return true;
  }

  PVector intersectionPoint(edge e1, edge e2) { //test for intersections
    float x1 = e1.v1.x; 
    float x2 = e1.v2.x;
    float x3 = e2.v1.x; 
    float x4 = e2.v2.x;
    float y1 = e1.v1.y; 
    float y2 = e1.v2.y;
    float y3 = e2.v1.y; 
    float y4 = e2.v2.y;

    float aN =((x4-x3)*(y1-y3))-((y4-y3)*(x1-x3));
    float bN = ((x2-x1)*(y1-y3))-((y2-y1)*(x1-x3));
    float d = ((y4-y3)*(x2-x1))-((x4-x3)*(y2-y1));

    float a = aN/d;
    float x = x1+(a*(x2-x1));
    float y = y1+(a*(y2-y1));
    return new PVector(x, y);
  }

  PVector circleIntersectionLocation(PVector p, PVector c, float r) {
    PVector v = new PVector(p.x-c.x, p.y-c.y);
    float magV = sqrt(v.x*v.x+v.y*v.y);
    PVector intP = new PVector(c.x+v.x/magV*r, c.y+v.y/magV*r);
    return intP;
  }
}
