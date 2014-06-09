// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


Attractor a;

ArrayList<Attractor>attractors = new ArrayList<Attractor>();

float angle = 0;
float offSetAngle = 0;
float offSetY = 0;

void setup() {
  size(1200, 600, P3D);
  colorMode(HSB, 255);
  background(0, 0, 0);

  for (int i =0; i<10;i++) {
    float ran = random(0, 1);
    a = new Attractor(width/4+offSetY, -10, -0.4, 100, 10, offSetAngle, 1, 0.01, 0.01);
    attractors.add(a);
    offSetAngle +=0.4;
    offSetY -=10;
  }
}

void keyDown() {
}

void draw() {
  background(0);

  if (frameCount % 100 == 0) {
    for (int i =0; i<10;i++) {
      float ran = random(0, 1);
      a = new Attractor(width/4+offSetY, -10, -0.4, 100, 10, offSetAngle, 1, 0.01, 0.01);
      attractors.add(a);
      offSetAngle +=0.4;
      offSetY -=10;
    }
  }

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
    }
  }

  angle += 0.003;

  //z
  stroke(100, 255, 200);
  line(0, 0, 0, 0, 0, 1000);
  //x(left and right)
  stroke(200, 255, 200);
  line(-1000, 0, 0, 1000, 0, 0);
  //y(up and down)
  stroke(50, 255, 200);
  line(0, 0, 0, 0, 1000, 0);

  text(frameRate, -width/2+10, -height/2+10);
}

