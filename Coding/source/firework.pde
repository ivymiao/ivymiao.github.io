ArrayList<Circle> circles=new ArrayList<Circle>();

class Circle{
  PVector location;
  float size;
  
  Circle(float x,float y){
    location=new PVector(x,y);
    size=100;
  }
  
  void update(){
    int labelx=int((location.x-mouseX)/abs(location.x-mouseX));
    int labely=int((location.y-mouseY)/abs(location.y-mouseY));
    location.add(labelx*random(-10,25),labely*random(-10,25));
    size /=random(1.05,1.12);
  }
  
  void display(){
    noStroke();
    fill(random(200,255),random(0,255),0);
    ellipse(location.x,location.y,size,size);
  }
  
  void check(){
    if(location.x<size/2){
      location.x=size/2;
      size=0.5;
      }
      else if(location.x>width-size/2){
        location.x=width-size/2;
        size=0.5;
      }
      if(location.y<size/2){
      location.y=size/2;
      size=0.5;
      }
      else if(location.y>height-size/2){
        location.y=height-size/2;
        size=0.5;
      }
  }
}

void setup(){
  size(1000,800);
  frameRate(40);
}

void draw(){
  background(0);
  float x=mouseX+random(-15,15);
  float y=mouseY+random(-15,15);
  Circle c=new Circle(x,y);
  circles.add(c);
  for(int i=0;i<circles.size();i++){
    if(circles.get(i).size<1){
      circles.remove(i);
    }
    circles.get(i).display();
    circles.get(i).update();
    circles.get(i).check();
  }  
}


    