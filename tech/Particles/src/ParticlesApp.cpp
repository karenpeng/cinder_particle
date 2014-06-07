#include "cinder/app/AppNative.h"
#include "cinder/gl/gl.h"
#include "cinder/gl/Texture.h"
#include "cinder/ImageIo.h"
#include "cinder/Perlin.h"

#include "Particle.h"
#include "ParticleController.h"

#define NUM_PARTICLES_PER_FRAME 4

using namespace ci;
using namespace ci::app;
using namespace std;

class ParticlesApp : public AppNative {
public:
  void prepareSettings(Settings *settings);
  void setup();
  void mouseMove(MouseEvent event);
  void mouseDrag(MouseEvent event);
  void mouseUp(MouseEvent event);
  void mouseDown(MouseEvent event);
  void update();
  void draw();
private:
  ParticleController *controller;
  
  Perlin mPerlin;
  bool isMouseDown;
  Vec2i mousePosition;
  Vec2i mouseVelocity;
  double mLastTime;
  
  gl::Texture mBackgroundImage;
};

void ParticlesApp::prepareSettings(Settings *settings) {
	settings->setWindowSize(1920	, 1080);
  settings->setFrameRate(60.0f);
}

void ParticlesApp::setup() {
  isMouseDown = false;
  controller = new ParticleController();
  controller->setup();
  mPerlin = Perlin();
  mLastTime = app::getElapsedSeconds();
  
  mBackgroundImage = gl::Texture(loadImage(loadAsset("bg-03.png")));
}

void ParticlesApp::mouseDown(MouseEvent event) {
  isMouseDown = true;
}

void ParticlesApp::mouseUp(MouseEvent event) {
  isMouseDown = false;
}

void ParticlesApp::mouseMove(MouseEvent event) {
  mouseVelocity = event.getPos() - mousePosition;
  mousePosition = event.getPos();
}

void ParticlesApp::mouseDrag(MouseEvent event) {
  mouseMove(event);
}

void ParticlesApp::update() {
  double currentTime = app::getElapsedSeconds();
  double deltaTime = currentTime - mLastTime;
  float delta = (float)app::getFrameRate() / (1.0 / deltaTime);
  
  mLastTime = currentTime;
  
  if (isMouseDown) {
    controller->addParticles(NUM_PARTICLES_PER_FRAME, mousePosition, mouseVelocity);
  }
  
	this->controller->update(delta, mPerlin);
}

void ParticlesApp::draw() {
  // make sure we can draw to background by setting the right flags
  // see https://forum.libcinder.org/topic/draw-image-overtop-of-image
	gl::clear(Color::black(), true);
  gl::disableDepthRead();
  gl::disableDepthWrite();
  gl::enableAlphaBlending();
  gl::color(Color::white());
  
  gl::draw(mBackgroundImage, getWindowBounds());
  
  gl::pushMatrices();
  this->controller->draw();
  gl::popMatrices();
}

CINDER_APP_NATIVE( ParticlesApp, RendererGl )
