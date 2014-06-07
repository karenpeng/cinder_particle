//
//  ParticleController.h
//  Particles
//
//  Created by Benjamin Bojko on 5/29/14.
//
//

#pragma once

#include "cinder/Perlin.h"
#include "Particle.h"
#include <list>

using namespace ci;
using namespace std;

class ParticleController {
public:
  void setup();
  void update(float delta, Perlin &perlin);
  void draw();
  void addParticles(int amt, const Vec2i &position, const Vec2i &velocity);
  void removeParticles(int amt);
  
  list<Particle*> mParticles;
};