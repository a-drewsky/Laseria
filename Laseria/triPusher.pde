class triPusher {


  void detectMovingBlocks(triBlock t) {
    for (int i=0; i<triBlocks.size(); i++) {
      if (triBlocks.get(i).movable && !triBlocks.get(i).touchingMover && triBlocks.get(i)!=t) {
        triBlock other = triBlocks.get(i);
        edge otherHor = triBlocks.get(i).hor;
        edge otherVert = triBlocks.get(i).vert;
        edge otherDiagonal = triBlocks.get(i).diagonal;
        edge otherDiag1 = triBlocks.get(i).diag1;
        edge otherDiag2 = triBlocks.get(i).diag2;


        if (t.rotation == 0) { //----------------ROTATION0----------------//

          if (other.rotation == 0) {
            if (intersection(t.vert, otherDiag1) && intersection(t.vert, otherDiag2)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diag1, otherVert) && intersection(t.diag1, otherDiag2)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diag2, otherVert) && intersection(t.diag2, otherDiag1)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.vert, otherDiag1) && intersection(t.diag2, otherDiag1)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diag1, otherVert) && intersection(t.diag2, otherVert)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.diag1, otherDiag2)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
                
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 1) {
            if (((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) || (intersection(t.vert, otherDiagonal) && otherDiagonal.open))
              && (t.corner1.y > other.pos.y+2 && t.corner2.x > other.pos.x+2)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open && t.corner3.x>other.pos.x+2) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.diag2, otherDiagonal)  && otherDiagonal.open) && t.corner3.x>other.pos.x) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.vert, otherDiagonal)  && otherDiagonal.open) || (intersection(t.vert, otherHor)) && otherHor.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
          if (other.rotation == 2) {
            if (intersection(t.vert, otherDiag2) && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if ((intersection(t.diag1, otherDiag1) && otherDiag1.open) || (intersection(t.vert, otherDiag1) && otherDiag1.open) ) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (t.pos.y<other.pos.y) {
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            }
            if (intersection(t.diag2, otherDiag2) && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
          if (other.rotation == 3) {
            if ((intersection(t.diag2, otherHor) && otherHor.open) && (intersection(t.diag2, otherVert) && otherVert.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.vert, otherHor) && otherHor.open) && (intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diag1, otherVert) && otherVert.open) && (intersection(t.diag1, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.vert, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }
          if (other.rotation == 4) {
            if (((intersection(t.diag1, otherVert) && otherVert.open) || (intersection(t.diag2, otherVert) && otherVert.open)) && t.pos.x<other.pos.x+2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else {
              if (((intersection(t.diag1, otherDiag2) && otherDiag2.open) || (intersection(t.diag1, otherVert) && otherVert.open))
                && t.corner1.y>other.corner1.y) {
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
              if (((intersection(t.diag2, otherDiag1) && otherDiag1.open) || (intersection(t.diag2, otherVert) && otherVert.open))
                && t.corner1.y<other.corner1.y) {
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            }
          }
          if (other.rotation == 5) {
            if ((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) && (intersection(t.diag2, otherVert) && otherVert.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.vert, otherHor) && otherHor.open) && (intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diag1, otherVert) && otherVert.open) && (intersection(t.diag1, otherHor) && otherHor.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.vert, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }
          if (other.rotation == 6) {
            if (intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diag2, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if ((intersection(t.diag2, otherDiag2) && otherDiag2.open) || (intersection(t.vert, otherDiag2) && otherDiag2.open) ) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (t.pos.y>other.pos.y) {
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            }
            if (intersection(t.diag1, otherDiag1) && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(t.diag2, otherHor) && otherHor.open || intersection(t.diag2, otherVert) && otherVert.open)
              && other.pos.x<t.corner2.x-2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (intersection(t.vert, otherHor) && otherHor.open) {
                t.canGoLeft = true;
              }
            } else if ((intersection(t.vert, otherHor) && otherHor.open) || (intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              t.canGoDown = true;
            }
          }
        }

        if (t.rotation == 1) { //----------------ROTATION1----------------//

          if (other.rotation == 0) {
            if (((intersection(t.diagonal, otherDiag2) && otherDiag2.open) || (intersection(t.diagonal, otherVert) && otherVert.open))
              && (t.pos.y < other.corner1.y-2 && t.pos.x < other.corner2.x-2)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open && t.pos.x<other.corner3.x-2) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.diagonal, otherDiag2)  && otherDiag2.open) && t.pos.x<other.corner3.x) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diagonal, otherVert)  && otherVert.open) || (intersection(t.hor, otherVert)) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(t.vert, otherHor)) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
                t.canGoDown = true;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoRight = true;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open) || (intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(otherDiagonal, t.vert) && otherDiagonal.open) || (intersection(otherDiagonal, t.hor) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 2) {
            if ((intersection(t.hor, otherDiag2) && otherDiag2.open || intersection(t.vert, otherDiag2) && otherDiag2.open) ||
              (intersection(t.diagonal, otherHor) && otherHor.open && intersection(t.diagonal, otherDiag1) && otherDiag1.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (t.pos.y>other.corner3.y-2) {
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
                t.canGoRight = true;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            } else if (intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (intersection(t.vert, otherHor) && otherHor.open && t.pos.y>other.corner2.y-2) {
                t.canGoLeft = true;
              }
              if (t.pos.x>other.corner2.x-2) {
                t.canGoDown = true;
              }
            } else if ((intersection(t.vert, otherHor) && otherHor.open) || (intersection(t.diagonal, otherHor) && otherHor.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              t.canGoRight = true;
            }
          }

          if (other.rotation == 3) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if ((intersection(t.diagonal, otherVert) && otherVert.open)) {
                t.canGoDown = true;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoLeft = true;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if ((intersection(t.hor, otherVert) && otherVert.open)) {
                t.canGoRight = true;
              }
            }
          }

          if (other.rotation == 4) {
            if (intersection(t.hor, otherVert) && intersection(t.diagonal, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.diagonal, otherDiag2) && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.vert, otherDiag1) && intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.hor, otherDiag1) && intersection(t.hor, otherVert) && otherVert.open && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diagonal, otherVert) && intersection(t.diagonal, otherDiag2) && otherVert.open && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }

          if (other.rotation == 5) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && t.pos.y>otherHor.v1.y-2) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if ((intersection(t.hor, otherVert) && otherVert.open || intersection(t.diagonal, otherVert) && otherVert.open) && t.pos.x>otherVert.v1.x-2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              t.canGoUp = true;
            }

            if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open || intersection(t.vert, otherDiagonal) && otherDiagonal.open) 
              && t.pos.y<otherHor.v1.y-2 && t.pos.x<otherVert.v1.x-2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }

          if (other.rotation == 6) {
            if (intersection(t.hor, otherDiag1) && intersection(t.hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diagonal, otherHor) && intersection(t.diagonal, otherDiag1) && otherHor.open && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.vert, otherHor) && intersection(t.vert, otherDiag2) && otherHor.open && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.vert, otherDiag2) && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diagonal, otherHor) && intersection(t.vert, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diagonal, otherDiag1) && intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }

          if (other.rotation == 7) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && !(intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } 
            if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } 
            if ((intersection(t.diagonal, otherVert) && otherVert.open) && !(intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
        }

        if (t.rotation == 2) { //----------------ROTATION2----------------//

          if (other.rotation == 0) {
            if (intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diag2, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if ((intersection(t.diag2, otherDiag2) && otherDiag2.open) || (intersection(t.hor, otherDiag2) && otherDiag2.open) ) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false; 
              if (t.pos.x<other.pos.x) {
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            }
            if (intersection(t.diag1, otherDiag1) && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(t.diag1, otherDiagonal) && otherDiagonal.open || intersection(t.hor, otherDiagonal) && otherDiagonal.open)
              && other.pos.y<t.corner2.y-2 && other.pos.x+other.size.x>t.corner3.x+2 && other.pos.x<t.corner1.x-2) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (intersection(t.hor, otherVert) && otherVert.open) {
                t.canGoUp = true;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open) || (intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              t.canGoLeft = true;
            }
          }

          if (other.rotation == 2) {
            if (intersection(t.hor, otherDiag1) && intersection(t.hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diag1, otherHor) && intersection(t.diag1, otherDiag2) && otherHor.open && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diag2, otherHor) && intersection(t.diag2, otherDiag1) && otherHor.open && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.hor, otherDiag1) && intersection(t.diag2, otherDiag1) && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diag1, otherHor) && intersection(t.diag2, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.diag1, otherDiag2) && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }

          if (other.rotation == 3) {
            if (((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) || (intersection(t.hor, otherDiagonal) && otherDiagonal.open))
              && (t.corner1.x < other.pos.x+t.size.x-2 && t.corner2.y > other.pos.y+2)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open && t.corner3.y>other.pos.y+2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diag2, otherDiagonal)  && otherDiagonal.open) && t.corner3.y>other.pos.y) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherDiagonal)  && otherDiagonal.open) || (intersection(t.hor, otherVert)) && otherVert.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }

          if (other.rotation == 4) {
            if (intersection(t.hor, otherDiag2) && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if ((intersection(t.diag1, otherDiag1) && otherDiag1.open) || (intersection(t.hor, otherDiag1) && otherDiag1.open) ) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (t.pos.x>other.pos.x) {
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            }
            if (intersection(t.diag2, otherDiag2) && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 5) {
            if ((intersection(t.diag2, otherVert) && otherVert.open) && (intersection(t.diag2, otherHor) && otherHor.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open) && (intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.diag1, otherHor) && otherHor.open) && (intersection(t.diag1, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.hor, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }

          if (other.rotation == 6) {
            if (((intersection(t.diag1, otherHor) && otherHor.open) || (intersection(t.diag2, otherHor) && otherHor.open)) && t.pos.y<other.pos.y+2) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else {
              if (((intersection(t.diag1, otherDiag2) && otherDiag2.open) || (intersection(t.diag1, otherHor) && otherHor.open))
                && t.corner1.x<other.corner1.x) {
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
              if (((intersection(t.diag2, otherDiag1) && otherDiag1.open) || (intersection(t.diag2, otherHor) && otherHor.open))
                && t.corner1.x>other.corner1.x) {
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            }
          }
          if (other.rotation == 7) {
            if ((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) && (intersection(t.diag2, otherHor) && otherHor.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open) && (intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.diag1, otherHor) && otherHor.open) && (intersection(t.diag1, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.hor, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
        }

        if (t.rotation == 3) { //----------------ROTATION3----------------//

          if (other.rotation == 0) {
            if (intersection(t.vert, otherDiag1) && intersection(t.vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diagonal, otherVert) && intersection(t.diagonal, otherDiag1) && otherVert.open && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.hor, otherVert) && intersection(t.hor, otherDiag2) && otherVert.open && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.hor, otherDiag2) && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diagonal, otherVert) && intersection(t.hor, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diagonal, otherDiag1) && intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if ((intersection(t.diagonal, otherVert) && otherVert.open)) {
                t.canGoDown = true;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoRight = true;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if ((intersection(t.hor, otherVert) && otherVert.open)) {
                t.canGoLeft = true;
              }
            }
          }

          if (other.rotation == 2) {
            if (((intersection(t.diagonal, otherDiag2) && otherDiag2.open) || (intersection(t.diagonal, otherHor) && otherHor.open))
              && (t.pos.x+t.size.x > other.corner1.x+2 && t.pos.y < other.corner2.y-2)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open && t.pos.y<other.corner3.y-2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diagonal, otherDiag2)  && otherDiag2.open) && t.pos.y<other.corner3.y) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.diagonal, otherHor)  && otherHor.open) || (intersection(t.vert, otherHor)) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 3) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
                t.canGoDown = true;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoLeft = true;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open) || (intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(otherDiagonal, t.vert) && otherDiagonal.open) || (intersection(otherDiagonal, t.hor) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
          if (other.rotation == 4) {
            if ((intersection(t.vert, otherDiag2) && otherDiag2.open || intersection(t.hor, otherDiag2) && otherDiag2.open) ||
              (intersection(t.diagonal, otherVert) && otherVert.open && intersection(t.diagonal, otherDiag1) && otherDiag1.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (t.pos.x+t.size.x<other.corner3.x+2) {
                t.canGoDown = true;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            } else if (intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (intersection(t.hor, otherVert) && otherVert.open && t.pos.x+t.size.x<other.corner2.x+2) {
                t.canGoUp = true;
              }
              if (t.pos.y>other.corner2.y-2) {
                t.canGoLeft = true;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open) || (intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              t.canGoDown = true;
            }
          }
          if (other.rotation == 5) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && !(intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } 
            if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } 
            if ((intersection(t.diagonal, otherVert) && otherVert.open) && !(intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
          if (other.rotation == 6) {
            if (intersection(t.vert, otherHor) && intersection(t.diagonal, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.diagonal, otherDiag2) && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.hor, otherDiag1) && intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.vert, otherDiag1) && intersection(t.vert, otherHor) && otherHor.open && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diagonal, otherHor) && intersection(t.diagonal, otherDiag2) && otherHor.open && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && t.pos.y>otherHor.v1.y-2) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if ((intersection(t.hor, otherVert) && otherVert.open || intersection(t.diagonal, otherVert) && otherVert.open) && t.pos.x+t.size.x<otherVert.v1.x+2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              t.canGoUp = true;
            }

            if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open || intersection(t.vert, otherDiagonal) && otherDiagonal.open) 
              && t.pos.y<otherHor.v1.y-2 && t.pos.x+t.size.x>otherVert.v1.x+2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
        }

        if (t.rotation == 4) { //----------------ROTATION4----------------//

          if (other.rotation == 0) {
            if (((intersection(t.diag1, otherVert) && otherVert.open) || (intersection(t.diag2, otherVert) && otherVert.open)) && t.pos.x>other.pos.x-2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else {
              if (((intersection(t.diag1, otherDiag2) && otherDiag2.open) || (intersection(t.diag1, otherVert) && otherVert.open))
                && t.corner1.y<other.corner1.y) {
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
              if (((intersection(t.diag2, otherDiag1) && otherDiag1.open) || (intersection(t.diag2, otherVert) && otherVert.open))
                && t.corner1.y>other.corner1.y) {
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            }
          }
          if (other.rotation == 1) {
            if ((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) && (intersection(t.diag2, otherVert) && otherVert.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.vert, otherHor) && otherHor.open) && (intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diag1, otherVert) && otherVert.open) && (intersection(t.diag1, otherHor) && otherHor.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.vert, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
          if (other.rotation == 2) {
            if (intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diag2, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if ((intersection(t.diag2, otherDiag2) && otherDiag2.open) || (intersection(t.vert, otherDiag2) && otherDiag2.open) ) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (t.pos.y<other.pos.y) {
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            }
            if (intersection(t.diag1, otherDiag1) && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }

          if (other.rotation == 3) {
            if ((intersection(t.diag1, otherDiagonal) && otherDiagonal.open || intersection(t.vert, otherDiagonal) && otherDiagonal.open)
              && other.pos.x+t.size.x>t.corner2.x+2 && other.pos.y+other.size.y>t.corner3.y+2 && other.pos.y<t.corner1.y-2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (intersection(t.vert, otherHor) && otherHor.open) {
                t.canGoRight = true;
              }
            } else if ((intersection(t.vert, otherHor) && otherHor.open) || (intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              t.canGoUp = true;
            }
          }
          if (other.rotation == 4) {
            if (intersection(t.vert, otherDiag1) && intersection(t.vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diag1, otherVert) && intersection(t.diag1, otherDiag2) && otherVert.open && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diag2, otherVert) && intersection(t.diag2, otherDiag1) && otherVert.open && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.vert, otherDiag1) && intersection(t.diag2, otherDiag1) && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diag1, otherVert) && intersection(t.diag2, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.diag1, otherDiag2) && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }

          if (other.rotation == 5) {
            if (((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) || (intersection(t.vert, otherDiagonal) && otherDiagonal.open))
              && (t.corner1.y < other.pos.y+t.size.y-2 && t.corner2.x < other.pos.x+t.size.x-2)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open && t.corner3.x<other.pos.x+t.size.x-2) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.diag2, otherDiagonal)  && otherDiagonal.open) && t.corner3.x<other.pos.x) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.vert, otherDiagonal)  && otherDiagonal.open) || (intersection(t.vert, otherHor)) && otherHor.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }
          if (other.rotation == 6) {
            if (intersection(t.vert, otherDiag2) && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if ((intersection(t.diag1, otherDiag1) && otherDiag1.open) || (intersection(t.vert, otherDiag1) && otherDiag1.open) ) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (t.pos.y>other.pos.y) {
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            }
            if (intersection(t.diag2, otherDiag2) && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }

          if (other.rotation == 7) {
            if ((intersection(t.diag2, otherHor) && otherHor.open) && (intersection(t.diag2, otherVert) && otherVert.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.vert, otherHor) && otherHor.open) && (intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diag1, otherVert) && otherVert.open) && (intersection(t.diag1, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.vert, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
        }

        if (t.rotation == 5) { //----------------ROTATION5----------------//

          if (other.rotation == 0) {
            if (intersection(t.hor, otherVert) && intersection(t.diagonal, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.diagonal, otherDiag2) && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.vert, otherDiag1) && intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.hor, otherDiag1) && intersection(t.hor, otherVert) && otherVert.open && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diagonal, otherVert) && intersection(t.diagonal, otherDiag2) && otherVert.open && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && t.pos.y+t.size.y<otherHor.v1.y+2) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if ((intersection(t.hor, otherVert) && otherVert.open || intersection(t.diagonal, otherVert) && otherVert.open) && t.pos.x+t.size.x<otherVert.v1.x+2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              t.canGoDown = true;
            }

            if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open || intersection(t.vert, otherDiagonal) && otherDiagonal.open) 
              && t.pos.y+t.size.y>otherHor.v1.y+2 && t.pos.x+t.size.x>otherVert.v1.x+2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }

          if (other.rotation == 2) {
            if (intersection(t.hor, otherDiag1) && intersection(t.hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diagonal, otherHor) && intersection(t.diagonal, otherDiag1) && otherHor.open && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.vert, otherHor) && intersection(t.vert, otherDiag2) && otherHor.open && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.vert, otherDiag2) && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diagonal, otherHor) && intersection(t.vert, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diagonal, otherDiag1) && intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 3) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && !(intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } 
            if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } 
            if ((intersection(t.diagonal, otherVert) && otherVert.open) && !(intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 4) {
            if (((intersection(t.diagonal, otherDiag2) && otherDiag2.open) || (intersection(t.diagonal, otherVert) && otherVert.open))
              && (t.pos.y+t.size.y > other.corner1.y+2 && t.pos.x+t.size.x > other.corner2.x+2)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open && t.pos.x+t.size.x>other.corner3.x+2) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.diagonal, otherDiag2)  && otherDiag2.open) && t.pos.x>other.corner3.x) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diagonal, otherVert)  && otherVert.open) || (intersection(t.hor, otherVert)) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
          if (other.rotation == 5) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
                t.canGoUp = true;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoLeft = true;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open) || (intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(otherDiagonal, t.vert) && otherDiagonal.open) || (intersection(otherDiagonal, t.hor) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
          if (other.rotation == 6) {
            if ((intersection(t.hor, otherDiag2) && otherDiag2.open || intersection(t.vert, otherDiag2) && otherDiag2.open) ||
              (intersection(t.diagonal, otherHor) && otherHor.open && intersection(t.diagonal, otherDiag1) && otherDiag1.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (t.pos.y+t.size.y<other.corner3.y+2) {
                t.canGoLeft = true;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
                if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              }
            } else if (intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (intersection(t.vert, otherHor) && otherHor.open && t.pos.y+t.size.y<other.corner2.y+2) {
                t.canGoRight = true;
              }
              if (t.pos.x+t.size.x<other.corner2.x+2) {
                t.canGoUp = true;
              }
            } else if ((intersection(t.vert, otherHor) && otherHor.open) || (intersection(t.diagonal, otherHor) && otherHor.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              t.canGoLeft = true;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if ((intersection(t.diagonal, otherVert) && otherVert.open)) {
                t.canGoUp = true;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoRight = true;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if ((intersection(t.hor, otherVert) && otherVert.open)) {
                t.canGoLeft = true;
              }
            }
          }
        }

        if (t.rotation == 6) { //----------------ROTATION6----------------//

          if (other.rotation == 0) {
            if (intersection(t.hor, otherDiag2) && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if ((intersection(t.diag1, otherDiag1) && otherDiag1.open) || (intersection(t.hor, otherDiag1) && otherDiag1.open) ) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (t.pos.x<other.pos.x) {
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            }
            if (intersection(t.diag2, otherDiag2) && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
          }
          if (other.rotation == 1) {
            if ((intersection(t.diag2, otherVert) && otherVert.open) && (intersection(t.diag2, otherHor) && otherHor.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open) && (intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.diag1, otherHor) && otherHor.open) && (intersection(t.diag1, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.hor, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
          if (other.rotation == 2) {
            if (((intersection(t.diag1, otherHor) && otherHor.open) || (intersection(t.diag2, otherHor) && otherHor.open)) && t.pos.y>other.pos.y-2) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else {
              if (((intersection(t.diag1, otherDiag2) && otherDiag2.open) || (intersection(t.diag1, otherHor) && otherHor.open))
                && t.corner1.x>other.corner1.x) {
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
              if (((intersection(t.diag2, otherDiag1) && otherDiag1.open) || (intersection(t.diag2, otherHor) && otherHor.open))
                && t.corner1.x<other.corner1.x) {
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            }
          }
          if (other.rotation == 3) {
            if ((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) && (intersection(t.diag2, otherHor) && otherHor.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open) && (intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.diag1, otherHor) && otherHor.open) && (intersection(t.diag1, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.hor, otherDiagonal) && otherDiagonal.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if (intersection(t.diag1, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
          if (other.rotation == 4) {

            if (intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diag2, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if ((intersection(t.diag2, otherDiag2) && otherDiag2.open) || (intersection(t.hor, otherDiag2) && otherDiag2.open) ) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (t.pos.x>other.pos.x) {
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            }
            if (intersection(t.diag1, otherDiag1) && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 5) {
            if ((intersection(t.diag1, otherDiagonal) && otherDiagonal.open || intersection(t.hor, otherDiagonal) && otherDiagonal.open)
              && other.pos.y+t.size.y>t.corner2.y+2 && other.pos.x<t.corner3.x-2 && other.pos.x+other.size.x>t.corner1.x+2) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if (intersection(t.diag1, otherVert) && otherVert.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (intersection(t.hor, otherVert) && otherVert.open) {
                t.canGoDown = true;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open) || (intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              t.canGoRight = true;
            }
          }
          if (other.rotation == 6) {
            if (intersection(t.hor, otherDiag1) && intersection(t.hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.diag1, otherHor) && intersection(t.diag1, otherDiag2) && otherHor.open && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diag2, otherHor) && intersection(t.diag2, otherDiag1) && otherHor.open && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.hor, otherDiag1) && intersection(t.diag2, otherDiag1) && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diag1, otherHor) && intersection(t.diag2, otherHor) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.diag1, otherDiag2) && otherDiag2.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }

          if (other.rotation == 7) {
            if (((intersection(t.diag2, otherDiagonal) && otherDiagonal.open) || (intersection(t.hor, otherDiagonal) && otherDiagonal.open))
              && (t.corner1.x > other.pos.x+2 && t.corner2.y < other.pos.y+t.size.y-2)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if (intersection(t.hor, otherVert) && otherVert.open && t.corner3.y<other.pos.y+t.size.y-2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diag2, otherDiagonal)  && otherDiagonal.open) && t.corner3.y<other.pos.y) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherDiagonal)  && otherDiagonal.open) || (intersection(t.hor, otherVert)) && otherVert.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
        }

        if (t.rotation == 7) { //----------------ROTATION7----------------//

          if (other.rotation == 0) {
            if ((intersection(t.vert, otherDiag2) && otherDiag2.open || intersection(t.hor, otherDiag2) && otherDiag2.open) ||
              (intersection(t.diagonal, otherVert) && otherVert.open && intersection(t.diagonal, otherDiag1) && otherDiag1.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (t.pos.x>other.corner3.x-2) {
                t.canGoUp = true;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
                if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              }
            } else if (intersection(t.hor, otherDiag1) && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (intersection(t.hor, otherVert) && otherVert.open && t.pos.x>other.corner2.x-2) {
                t.canGoDown = true;
              }
              if (t.pos.y+t.size.y<other.corner2.y+2) {
                t.canGoRight = true;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open) || (intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              t.canGoUp = true;
            }
          }

          if (other.rotation == 1) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && !(intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            } else if ((intersection(t.diagonal, otherDiagonal) && otherDiagonal.open) && !(intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } 
            if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } 
            if ((intersection(t.diagonal, otherVert) && otherVert.open) && !(intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 2) {
            if (intersection(t.vert, otherHor) && intersection(t.diagonal, otherHor) && otherHor.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.diagonal, otherDiag2) && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.hor, otherDiag1) && intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.vert, otherDiag1) && intersection(t.vert, otherHor) && otherHor.open && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.hor, otherDiag2) && intersection(t.hor, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diagonal, otherHor) && intersection(t.diagonal, otherDiag2) && otherHor.open && otherDiag2.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 3) {
            if ((intersection(t.vert, otherHor) && otherHor.open || intersection(t.diagonal, otherHor) && otherHor.open) && t.pos.y+t.size.y<otherHor.v1.y+2) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if ((intersection(t.hor, otherVert) && otherVert.open || intersection(t.diagonal, otherVert) && otherVert.open) && t.pos.x>otherVert.v1.x-2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              t.canGoDown = true;
            }

            if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open || intersection(t.vert, otherDiagonal) && otherDiagonal.open) 
              && t.pos.y+t.size.y>otherHor.v1.y+2 && t.pos.x<otherVert.v1.x-2) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 4) {
            if (intersection(t.vert, otherDiag1) && intersection(t.vert, otherDiag2) && otherDiag1.open && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
            if (intersection(t.diagonal, otherVert) && intersection(t.diagonal, otherDiag1) && otherVert.open && otherDiag1.open) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.hor, otherVert) && intersection(t.hor, otherDiag2) && otherVert.open && otherDiag2.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.vert, otherDiag2) && intersection(t.hor, otherDiag2) && otherDiag2.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
            if (intersection(t.diagonal, otherVert) && intersection(t.hor, otherVert) && otherVert.open) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
            }
            if (intersection(t.diagonal, otherDiag1) && intersection(t.vert, otherDiag1) && otherDiag1.open) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            }
          }
          if (other.rotation == 5) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if ((intersection(t.diagonal, otherVert) && otherVert.open)) {
                t.canGoUp = true;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoLeft = true;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if ((intersection(t.hor, otherVert) && otherVert.open)) {
                t.canGoRight = true;
              }
            }
          }
          if (other.rotation == 6) {
            if (((intersection(t.diagonal, otherDiag2) && otherDiag2.open) || (intersection(t.diagonal, otherHor) && otherHor.open))
              && (t.pos.x < other.corner1.x-2 && t.pos.y+t.size.y > other.corner2.y+2)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if (intersection(t.vert, otherHor) && otherHor.open && t.pos.y+t.size.y>other.corner3.y+2) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            } else if ((intersection(t.diagonal, otherDiag2)  && otherDiag2.open) && t.pos.y>other.corner3.y) {
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(t.diagonal, otherHor)  && otherHor.open) || (intersection(t.vert, otherHor)) && otherHor.open) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
            }
          }
          if (other.rotation == 7) {
            if ((intersection(t.vert, otherHor) && otherHor.open)) {
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
              if ((intersection(t.vert, otherDiagonal) && otherDiagonal.open)) {
                t.canGoUp = true;
                if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
              }
            } else if ((intersection(t.hor, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if ((intersection(t.hor, otherDiagonal) && otherDiagonal.open)) {
                t.canGoRight = true;
                if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              }
            } else if ((intersection(t.diagonal, otherHor) && otherHor.open) || (intersection(t.diagonal, otherVert) && otherVert.open)) {
              if (other.canGoRight && t.goingRight && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveR(false);
                } else t.canGoRight = false;
              if (other.canGoUp && t.goingUp && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveU(false);
                } else t.canGoUp = false;
            } else if ((intersection(otherDiagonal, t.vert) && otherDiagonal.open) || (intersection(otherDiagonal, t.hor) && otherDiagonal.open)) {
              if (other.canGoDown && t.goingDown && t.touchingMover) {
                  other.vel = t.vel;
                  other.fluidMoveD(false);
                } else t.canGoDown = false;
              if (other.canGoLeft && t.goingLeft && t.touchingMover) {
                    other.vel = t.vel;
                    other.fluidMoveL(false);
                  } else t.canGoLeft = false;
            }
          }
        }
      }
    }
  }
}
