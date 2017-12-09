ArrayList<Circle> circles=new ArrayList<Circle>();
Circle c;
int recordtime=0;

class Circle{
  PVector location,velocity;
  float size=random(2,5);
  
  Circle(int x,int y){
    location=new PVector(x,y);
    velocity=new PVector(0.5,0.5);
  }
  
  void update(){
    PVector a;
    if(velocity.x>3 && velocity.y>3){
      a= new PVector(random(-3,0),random(-3,0));
    }
    else if(velocity.x<-3 && velocity.y<-3){
      a= new PVector(random(0,3),random(0,3));
    }
    else{
      a =new PVector(random(-0.3,0.3),random(-0.3,0.3));
    }
    velocity.add(a);
    location.add(velocity);
  }
  
  void display(){
    noStroke();
    fill(255);
    ellipse(location.x,location.y,size,size);
  }
  
  void link(Circle c){
    stroke(int(random(0,255)),0,int(random(0,255)));
    PVector dist=PVector.sub(c.location,location);
    if (dist.mag()<70){
      line(location.x,location.y,c.location.x,c.location.y);
      fill(255,50);
      ellipse(location.x,location.y,size+5,size+5);
    }
  }

  void checkEdges(){
    if(location.x<size/2){
      location.x=size/2;
      velocity.x*=-1;
    }else if(location.x>width-size/2){
      location.x=width-size/2;
      velocity.x*=-1;
    }
    
    if(location.y<size/2){
      location.y=size/2;
      velocity.y*=-1;
    }else if(location.y>height-size/2){
      location.y=height-size/2;
      velocity.y*=-1;
    }
  }
}

void setup()
{  size(1000,600);
   for(int a=0;a<100;a++){
     c=new Circle(int(random(0,width)),int(random(0,height)));
     circles.add(c);
   }
}

void draw()
{  background(0);
   if (millis()-recordtime>500){
     if(circles.size()>130){
       for(int b=0;b<int(random(10,15));b++){
         circles.remove(b);
       }
     }
   }
   for(int i=0;i<circles.size();i++){
     for(int k=0;k<circles.size();k++){
       if(i!=k){
         circles.get(i).link(circles.get(k));
       }
     }
     circles.get(i).update();
     circles.get(i).display();
     circles.get(i).checkEdges();
   }
}

void mouseClicked()
{  c=new Circle(mouseX,mouseY);
   circles.add(c);
}
void mouseDragged()
{  c=new Circle(mouseX,mouseY);
   circles.add(c);
}