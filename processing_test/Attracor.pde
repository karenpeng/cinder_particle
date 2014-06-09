// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Attraction

// A class for a draggable attractive body in our world

class Attractor {
  float mass;         // Mass, tied to size
  PVector location;   // Location
  float g;
  ArrayList<PVector>pastLoc = new ArrayList<PVector>();
  float counter = 0.0;
  float minDis = 2.0;
  float maxDis = 10.0;
  Mover[] movers = new Mover[10];
  color c;
  int life;
  float xSpeed, ySpeed, zSpeed;
  float ySinWeight, zSinWeight;

  Attractor(float _xSpeed, float _ySpeed, float _zSpeed, float _ySinWeight, float _zSinWeight) {
    location = new PVector(width/2, -60, 0);
    mass = 20;
    g = 0.4;
    for (int i = 0; i < movers.length; i++) {
      movers[i] = new Mover(random(0.1, 2), random(width/4, width/2), random(-height/8, height/8), random(-10, 10));
    }
    c = color(random(255), 255,255);
    life = 2000;
    xSpeed = _xSpeed;
    ySpeed = _ySpeed;
    zSpeed = _zSpeed;
    ySinWeight = _ySinWeight;
    zSinWeight = _zSinWeight;
  }

  void update() {
    location.add(new PVector(xSpeed, ySinWeight*sin(counter), zSinWeight*cos(counter)));
    //location.add(new PVector(-0.6, 0, 0));
    counter += 0.01;
    pastLoc.add(location.get());
    if (pastLoc.size()>1000) {
      pastLoc.remove(0);
    }
    life--;
  }

  boolean die() {
    return life <= 0;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, minDis, maxDis);                     // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }

  void applyAttractionToMovers() {
    for (int i = 0; i < movers.length; i++) {
      PVector force = this.attract(movers[i]);
      movers[i].applyForce(force);

      movers[i].update();
    }
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
    stroke(hue(c),100,255);
    for (PVector l: pastLoc) {
      point(l.x, l.y, l.z);
    }

    for (int i=0;i<movers.length;i++) {
      movers[i].display(color(hue(c),255,200));
    }
  }
}

