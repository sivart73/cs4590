import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

SamplePlayer backgroundSound;
SamplePlayer voiceOneSound;
SamplePlayer voiceTwoSound;

ControlP5 p5;
int backgroundColor;
Button voiceOne; 
Button voiceTwo; 
float volume = .5;
Gain overAllGain;
Gain backgroundGain;
Glide backgroundGainGlide;

float backgroundVolume = 1;
float lowbackgroundVolume = .15;


void setup() {
  size(320, 240); //size(width, height) must be the first line in setup()

  //CONTROL P5
  p5 = new ControlP5(this);

  p5.addSlider("volume")
    .setPosition(0, 0)
    .setSize(100, 20)
    .setRange(0, 1)
    .setLabel("Volume")
    ;

  p5.addButton("voiceOne")
    .setPosition(0, 50)
    .setSize(80, 80)
    .setLabel("Voice One")
    ;


  p5.addButton("voiceTwo")
    .setPosition(0, 130)
    .setSize(80, 80)
    .setLabel("Voice Two")
    ;


  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions 
  backgroundGainGlide = new Glide(ac, 1.0, 250);

  voiceOneSound = getSamplePlayer("voiceone.wav"); 
  voiceOneSound.pause(true);

  voiceOneSound.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
       backgroundGainGlide.setValue(backgroundVolume);
      voiceOneSound.setToLoopStart();
      voiceOneSound.pause(true);
    }
  }
  );
  voiceTwoSound = getSamplePlayer("voicetwo.wav"); 
  voiceTwoSound.pause(true);

  voiceTwoSound.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      backgroundGainGlide.setValue(backgroundVolume);
      voiceTwoSound.setToLoopStart();
      voiceTwoSound.pause(true);
    }
  }
  );


  backgroundSound = getSamplePlayer("intermission.wav"); 
  backgroundSound.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);

  overAllGain = new Gain(ac, 3, volume);
  backgroundGain = new Gain(ac, 1, backgroundGainGlide);

  backgroundGain.addInput(backgroundSound);
  overAllGain.addInput(backgroundGain);
  overAllGain.addInput(voiceOneSound);
  overAllGain.addInput(voiceTwoSound);


  ac.out.addInput(overAllGain);
  ac.start();
}

void draw() {
  background(backgroundColor);  //fills the canvas with black (0) each frame
  overAllGain.setGain(volume);


} 



public void voiceOne() {
  voiceTwoSound.pause(true);
  backgroundGainGlide.setValue(lowbackgroundVolume);
  voiceOneSound.setToLoopStart();
  voiceOneSound.start();
}

public void voiceTwo() {
  voiceOneSound.pause(true);
  backgroundGainGlide.setValue(lowbackgroundVolume);
  voiceTwoSound.setToLoopStart();
  voiceTwoSound.start();
}