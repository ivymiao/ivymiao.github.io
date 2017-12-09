
int R=300;
void setup(){
  size(800,800);
  background(0);
  noFill();
}

void draw(){
  background(0);
  for(int i=0;i<26;i++){
    stroke(i*10,i*10,255-i*10);
    strokeWeight(1+0.1*i);
    float x=(width/2-mouseX)*i/25;
    float y=(width/2-mouseY)*i/25;
    PVector loc= new PVector(width/2-mouseX,height/2-mouseY);
    x=constrain(x,-R*abs(loc.x)/loc.mag()*i/25,R*abs(loc.x)/loc.mag()*i/25);
    y=constrain(y,-R*abs(loc.y)/loc.mag()*i/25,R*abs(loc.y)/loc.mag()*i/25);
    x=x+mouseX;
    y=y+mouseY;
    ellipse(x,y,width*0.8*i/25,width*0.8*i/25);
  }

}