// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


Mover[] movers = new Mover[10];

Attractor a;

Mover[] movers2 = new Mover[10];

Attractor b;

ArrayList<Attractor>attractors = new ArrayList<Attractor>();
ArrayList<Mover[]>moverss = new ArrayList<Mover[]>();

float angle = 0;

void setup() {
  size(1200, 600, P3D);
  colorMode(HSB,255);
  background(0,0,0);
  //  for (int i = 0; i < movers.length; i++) {
  //    movers[i] = new Mover(random(0.1, 2), random(width/4, width/2), random(-height/8, height/8), random(-10, 10));
  //  }
  for (int i =0; i<4;i++) {
    float ran = random(0, 1);
    a = new Attractor(-0.6, 0, 0, ran, ran);
    attractors.add(a);
    //moverss.add(movers);
  }
}

void keyDown(){
  
}

void draw() {
  background(0);

  //  if (frameCount % 220 == 0) {
  //    float ran = random(0,1);
  //    b = new Attractor(-0.6,0,0,ran,ran);
  //    attractors.add(b);
  //  }
  sphereDetail(8);
  lights();
  translate(width/2, height/2);
  //rotateY(angle);

  for (int i=0;i<attractors.size();i++) {
    a = attractors.get(i);
    if (a.die()) {
      attractors.remove(i);
    }
    else {
      a.update();
      a.display();
      a.applyAttractionToMovers();
    }
  }
  //  for (Mover[] movers: moverss) {
  //    for (int i = 0; i < movers.length; i++) {
  //      PVector force = a.attract(movers[i]);
  //      movers[i].applyForce(force);
  //
  //      movers[i].update();
  //      movers[i].display();
  //    }
  //  }
  angle += 0.003;

  //z
  stroke(100, 255, 200);
  line(0, 0, 0, 0, 0, 1000);
  //x(left and right)
  stroke(200, 255, 200);
  line(0, 0, 0, 1000, 0, 0);
  //y(up and down)
  stroke(50, 255, 200);
  line(0, 0, 0, 0, 1000, 0);
}






