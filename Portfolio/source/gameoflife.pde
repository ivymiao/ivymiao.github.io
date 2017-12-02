/**
 * Press SPACE BAR to pause and change the cell's values with the mouse
 * On pause, click to activate/deactivate cells
 * Press R to randomly reset the cells' grid
 * Press C to clear the cells' grid
 * Press F/S to increase/decrease the time interval
 * Press P to see some unique patterns
 *
 * The original Game of Life was created by John Conway in 1970.
 */

// Size of cells
int cellSize = 10;

// How likely for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 15;

// Variables for timer
int interval = 200;
int lastRecordedTime = 0;

// Colors for active/inactive cells
color alive = color(255,182,193);
color dead = color(0);
color everalive = color(54,0,0);

// Array of cells
int[][] cells; 
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 

// Pause
boolean pause = false;

void setup() {
  size (1280, 720);

  // Instantiate arrays 
  cells = new int[width/cellSize][height/cellSize];
  cellsBuffer = new int[width/cellSize][height/cellSize];

  // This stroke will draw the background grid color
  stroke(48);

  noSmooth();

  // Initialization of cells
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      float state = random (100);
      if (state > probabilityOfAliveAtStart) { 
        state = 0;
      }
      else {
        state = 1;
      }
      cells[x][y] = int(state); // Save state of each cell
    }
  }
  background(0); // Fill in black in case cells don't cover all the windows
}


void draw() {

  //Draw grid
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      if (cells[x][y]==1) {
        fill(alive); // If alive
      }
      else if (cells[x][y]==0){
        fill(dead); // If dead
      }
      else{
        fill(everalive);
      }
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  } //<>//
  // Iterate if timer ticks
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      iteration();
      lastRecordedTime = millis();
    }
  }

  // Create  new cells manually on pause
  if (pause && mousePressed) {
    // Map and avoid out of bound errors
    int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));
    xCellOver = constrain(xCellOver, 0, width/cellSize-1);
    int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));
    yCellOver = constrain(yCellOver, 0, height/cellSize-1);

    // Check against cells in buffer
    if (cellsBuffer[xCellOver][yCellOver]==1) { // Cell is alive
      cells[xCellOver][yCellOver]=0; // Kill
      fill(dead); // Fill with kill color
    }
    else { // Cell is dead
      cells[xCellOver][yCellOver]=1; // Make alive
      fill(alive); // Fill alive color
    }
  } 
  else if (pause && !mousePressed) { // And then save to buffer once mouse goes up
    // Save cells to buffer (so we opeate with one array keeping the other intact)
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }
  }
}



void iteration() { // When the clock ticks
  // Save cells to buffer (so we opeate with one array keeping the other intact)
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // Visit each cell:
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      // And visit all the neighbours of each cell
      int neighbours = 0; // We'll count the neighbours
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {  
          if (((xx>=0)&&(xx<width/cellSize))&&((yy>=0)&&(yy<height/cellSize))) { // Make sure you are not out of bounds
            if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
              if (cellsBuffer[xx][yy]==1){
                neighbours ++; // Check alive neighbours and count them
              }
            } // End of if
          } // End of if
        } // End of yy loop
      } //End of xx loop
      // We've checked the neigbours: apply rules!
      if (cellsBuffer[x][y]==1) { // The cell is alive: kill it if necessary
        if (neighbours < 2 || neighbours > 3) {
          cells[x][y] = 2; // Die unless it has 2 or 3 neighbours
        }
      } 
      else { // The cell is dead: make it live if necessary      
        if (neighbours == 3 ) {
          cells[x][y] = 1; // Only if it has 3 neighbours
        }
      } // End of if
    } // End of y loop
  } // End of x loop
} // End of function

void keyPressed() {
  if (key=='r' || key == 'R') {
    // Restart: reinitialization of cells
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        float state = random (100);
        if (state > probabilityOfAliveAtStart) {
          state = 0;
        }
        else {
          state = 1;
        }
        cells[x][y] = int(state); // Save state of each cell
      }
    }
  }
  if (key==' ') { // On/off of pause
    pause = !pause;
  }
  if (key=='c' || key == 'C') { // Clear all
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
  if (key=='p' || key=='P'){
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
    cells[34][10]=1;cells[35][10]=1;cells[39][10]=1;cells[40][10]=1;cells[43][10]=1;cells[47][10]=1;
    cells[33][11]=1;cells[38][11]=1;cells[41][11]=1;cells[43][11]=1;cells[44][11]=1;cells[46][11]=1;cells[47][11]=1;
    cells[33][12]=1;cells[35][12]=1;cells[36][12]=1;cells[38][12]=1;cells[39][12]=1;cells[40][12]=1;cells[41][12]=1;
    cells[33][13]=1;cells[36][13]=1;cells[38][13]=1;cells[41][13]=1;cells[43][13]=1;cells[47][13]=1;
    cells[34][14]=1;cells[35][14]=1;cells[38][14]=1;cells[41][14]=1;cells[43][14]=1;cells[47][14]=1;
    cells[43][12]=1;cells[45][12]=1;cells[47][12]=1;
    cells[49][10]=1;cells[50][10]=1;cells[51][10]=1;cells[49][11]=1;cells[49][12]=1;cells[50][12]=1;
    cells[49][13]=1;cells[49][14]=1;cells[50][14]=1;cells[51][14]=1;
    cells[54][11]=1;cells[54][12]=1;cells[54][13]=1;
    cells[55][10]=1;cells[55][14]=1;cells[56][10]=1;cells[56][14]=1;cells[57][11]=1;cells[57][12]=1;cells[57][13]=1;
    cells[59][10]=1;cells[59][11]=1;cells[59][12]=1;cells[59][13]=1;cells[59][14]=1;cells[60][10]=1;cells[60][12]=1;
    cells[61][10]=1;cells[64][10]=1;cells[64][11]=1;cells[64][12]=1;cells[64][13]=1;cells[64][14]=1;cells[65][14]=1;
    cells[66][14]=1;cells[68][10]=1;cells[68][11]=1;cells[68][12]=1;cells[68][13]=1;cells[68][14]=1;cells[70][10]=1;
    cells[70][11]=1;cells[70][12]=1;cells[70][13]=1;cells[70][14]=1;cells[71][10]=1;cells[71][12]=1;cells[72][10]=1;
    cells[74][10]=1;cells[74][11]=1;cells[74][12]=1;cells[74][13]=1;cells[74][14]=1;cells[75][10]=1;cells[75][12]=1;
    cells[75][14]=1;cells[76][10]=1;cells[76][14]=1;
    
    cells[34][40]=1;cells[35][40]=1;cells[34][41]=1;cells[35][41]=1;
    cells[44][40]=1;cells[44][41]=1;cells[44][42]=1;cells[45][39]=1;cells[45][43]=1;
    cells[46][38]=1;cells[46][44]=1;cells[47][38]=1;cells[47][44]=1;cells[48][41]=1;
    cells[49][39]=1;cells[49][43]=1;cells[50][40]=1;cells[50][41]=1;cells[50][42]=1;
    cells[51][41]=1;cells[54][38]=1;cells[54][39]=1;cells[54][40]=1;
    cells[55][38]=1;cells[55][39]=1;cells[55][40]=1;cells[56][37]=1;cells[56][41]=1;
    cells[58][36]=1;cells[58][37]=1;cells[58][41]=1;cells[58][42]=1;
    cells[68][38]=1;cells[68][39]=1;cells[69][38]=1;cells[69][39]=1;
  }
  if ((key=='F'||key=='f') && interval>200){
    interval=interval/2;
  }
  if ((key=='S'||key=='s') && interval<2000){
    interval=interval*2;
  }
}