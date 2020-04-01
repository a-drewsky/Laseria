class grid{
  PVector[][] positions;
  int[] Xs;
  int[] Ys;
  PVector gridSize;
  int Xiteration;
  int Yiteration;
  int x;
  int y;
  
 grid(int Gx, int Gy){
   x = Gx; y = Gy;
   gridSize = new PVector(Gx,Gy);
   Xs = new int[(int)gridSize.x];
   Ys = new int[(int)gridSize.y];
   positions = new PVector[(int)gridSize.x][(int)gridSize.y];
   Xiteration = width / (int)gridSize.x;
   Yiteration = (height-35) / (int)gridSize.y;
   
   for(int i=0; i<(int)gridSize.x; i++){
     Xs[i] = Xiteration * i;
   }
   for(int i=0; i<(int)gridSize.y; i++){
     Ys[i] = Yiteration * i + 35;
   }
   for(int i=0; i<(int)gridSize.x; i++){
     for(int j=0; j<(int)gridSize.y; j++){
       positions[i][j] = new PVector(Xs[i],Ys[j]);
     }
   }
 }
 
 void showDots(){
   strokeWeight(2);
   stroke(0,0,0,25);
   for(int i=0; i<(int)gridSize.x; i++){
     line(Xiteration*i,35, Xiteration*i, height);
   }
   for(int j=0; j<(int)gridSize.y; j++){
       line(0,Yiteration*j+35, width, Yiteration*j+35);
     }
 }
 
}
