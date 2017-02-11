import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

SamplePlayer backgroundSound;
SamplePlayer buttonOneSound;


ControlP5 p5;
int backgroundColor;
Button voiceOne;
Button voiceTwo;
float volume = .5;
Gain g;
Glide backgroundGainGlide;
float backgroundVolume = 1;

void setup() {
  size(648, 480); //size(width, height) must be the first line in setup()

  //CONTROL P5
  p5 = new ControlP5(this);


  p5.addButton("Play")
    .setPosition(0, 50)
    .setSize(80, 80)
    .setLabel("Play")
    ;


  p5.addButton("Stop")
    .setPosition(80, 50)
    .setSize(80, 80)
    .setLabel("Stop")
    ;

  p5.addButton("FastForward")
    .setPosition(160, 50)
    .setSize(80, 80)
    .setLabel("FF")
    ;


  p5.addButton("Rewind")
    .setPosition(240, 50)
    .setSize(80, 80)
    .setLabel("Rewind")
    ;


  p5.addButton("Reset")
    .setPosition(320, 50)
    .setSize(80, 80)
    .setLabel("Reset")
    ;
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions


  backgroundSound = getSamplePlayer("cassette.wav");
  backgroundSound.pause(true);
  backgroundGainGlide = new Glide(ac, 1,0);
  backgroundSound.setRate(backgroundGainGlide);

  buttonOneSound = getSamplePlayer("button1sounds.wav");
  buttonOneSound.pause(true);

  buttonOneSound.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      buttonOneSound.setToLoopStart();
      buttonOneSound.pause(true);
    }
  }
  );

  backgroundSound.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      backgroundSound.setPosition(0.0);
      backgroundGainGlide.setValue(1);
      backgroundSound.pause(true);
    }
  }
  );


  g = new Gain(ac, 3, volume);

  g.addInput(backgroundSound);
  g.addInput(buttonOneSound);

  ac.out.addInput(g);
  ac.start();
}

void draw() {
  background(backgroundColor);  //fills the canvas with black (0) each frame
System.out.println(backgroundSound.getPosition());

}



public void Play() {
  backgroundSound.pause(false);
    buttonOneSound.pause(false);

}

public void Stop() {
  backgroundSound.pause(true);
  buttonOneSound.pause(false);
  backgroundGainGlide.setValue(1);

}


public void Rewind() {
  if (backgroundSound.getPosition() > 0) {
      backgroundSound.pause(false);
      backgroundGainGlide.setValue(-1.5);
  }
    buttonOneSound.pause(false);

}

public void FastForward() {
    buttonOneSound.pause(false);

  backgroundSound.pause(false);

  backgroundGainGlide.setValue(1.75);
}
public void Reset() {
  backgroundSound.pause(true);
  backgroundGainGlide.setValue(1.0);
  backgroundSound.setToLoopStart();
    buttonOneSound.pause(false);


  System.out.println("reset");
}
