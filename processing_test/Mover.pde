// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  ArrayList<PVector>pastLoc = new ArrayList<PVector>();

  Mover(float m, float x, float y, float z) {
    mass = m;
    location = new PVector(x,y,z);
    velocity = new PVector(0,0,0);
    acceleration = new PVector(0,0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    pastLoc.add(location.get());
    if(pastLoc.size()>1000){
      pastLoc.remove(0);
    }
  }

  void display(color c) {
    noStroke();
    fill(c);
    pushMatrix();
    translate(location.x,location.y,location.z);
    rotate(angle);
    box(mass*4);
    popMatrix();
    stroke(255);
    for(PVector l: pastLoc){
      //point(l.x,l.y,l.z);
    }
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}


