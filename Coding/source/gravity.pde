ArrayList<Circle> circles=new ArrayList<Circle>();
Circle c;
int recordtime=0;

class Circle{
  PVector location,velocity,acceleration;
  float G,mass,size;
  
  Circle(int x,int y){
    location=new PVector(x,y);
    velocity=new PVector(0,0);
    acceleration=new PVector(0,0);
    G=0.5;
    mass=random(2,5);
    size=mass;
  }
  
  void applyForce(PVector force){
    PVector f=force;
    f.div(mass);
    acceleration.add(f);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display(){
    noStroke();
    fill(255);
    ellipse(location.x,location.y,size,size);
  }
  
  void link(Circle c){
    stroke(int(random(0,255)),int(random(0,255)),int(random(0,255)));
    PVector dist=PVector.sub(c.location,location);
    if (dist.mag()<150){
      line(location.x,location.y,c.location.x,c.location.y);
    }
  }
  
  PVector attract(Circle c){
    PVector force=PVector.sub(location,c.location);
    float distance=force.mag();
    distance=constrain(distance,20,25);
    force.normalize();
    float strength=(G*mass*c.mass)/(distance*distance);
    force.mult(strength);
    return force;
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
   for(int a=0;a<50;a++){
     c=new Circle(int(random(0,width)),int(random(0,height)));
     circles.add(c);
   }
}

void draw()
{  background(0);
   if (millis()-recordtime>500){
     if(circles.size()>70){
       for(int b=0;b<int(random(10,15));b++){
         circles.remove(b);
       }
     }
   }
   for(int i=0;i<circles.size();i++){
     for(int k=0;k<circles.size();k++){
       if(i!=k){
         PVector f=circles.get(k).attract(circles.get(i));
         circles.get(i).applyForce(f);
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