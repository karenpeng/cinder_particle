// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Attraction

// A class for a draggable attractive body in our world

class Attractor {
  float mass;         // Mass, tied to size
  PVector location;   // Location
  float g;
  float counter;
  float minDis = 2.0;
  float maxDis = 10.0;
  color c;
  int life;
  float xSpeed, ySpeed, zSpeed;
  float ySinWeight, zSinWeight;
  float yAngleSeed, zAngleSeed;
  float yAngleIncrease, zAngleIncrease;

  Attractor(float _x, float _y,float _xSpeed, float _ySinWeight, float _zSinWeight, float _yAngleSeed, float _zAngleSeed, float _yAngleIncrease, float _zAngleIncrease) {
    location = new PVector(_x,_y, 0);
    mass = 20;
    g = 0.4;
    c = color(random(255), 255, 255);
    life = 2000;
    xSpeed = _xSpeed;
    ySinWeight = _ySinWeight;
    zSinWeight = _zSinWeight;
    yAngleSeed = _yAngleSeed;
    zAngleSeed = _zAngleSeed;
    yAngleIncrease = _yAngleIncrease;
    zAngleIncrease = _zAngleIncrease;
  }

  void update() {
    //location.add(new PVector(xSpeed, ySinWeight*sin(counter), zSinWeight*cos(counter)));
    location.add(new PVector(-0.6, 0, 0));
    location.y = ySinWeight*sin(yAngleSeed);
    location.z = zSinWeight*cos(zAngleSeed);
    yAngleSeed += yAngleIncrease;
    zAngleSeed += zAngleIncrease;
    life--;
  }

  boolean die() {
    return life <= 0;
  }

  // Method to display
  void display() {
    stroke(c);
    noFill();
    pushMatrix();
    translate(location.x, location.y, location.z);
    //sphere(mass*2);
    sphere(mass*0.2);
    popMatrix();
    stroke(hue(c), 100, 255);


  }
}

