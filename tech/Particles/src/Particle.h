//
//  Particle.h
//  Particles
//
//  Created by Benjamin Bojko on 5/29/14.
//
//

#pragma once

#include "cinder/gl/gl.h"
#include "cinder/Vector.h"
#include "cinder/Rand.h"
#include "cinder/Perlin.h"

#include <iostream>
#include <list>

using namespace ci;
using namespace std;

class Particle {
public:
  
  Particle();
  ~Particle();
  
  enum Shape {
    TRIANGLE,
    SQUARE,
    HEXAGON,
    CIRCLE
  };
  static const Color Colors[];
  static const Shape Shapes[];
  
  void setup(const Vec2f &position, const Vec2f &velocity);
  void update(float delta, Perlin &perlin);
  void draw();
  
  Vec3f mPosition;
  Vec3f mVelocity;
  
  float mRadius;
  float mVecolityDecay;
  list<Color> mColors;
  
  int mLifespan;
  int mAge;
  int mFlapLifespan;
  bool mIsDead;
  
  Color mColorA;
  Color mColorB;
  
  void drawArc(const Vec2f &center, const float radius, const float start, const float stop, const int numSegments);
  
  Shape mShape;
  
private:
  static Color colorFromInt(const uint32_t rgb);
};

