import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import beads.*; 
import org.jaudiolibs.beads.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ClementTravis_ce5 extends PApplet {





SamplePlayer backgroundSound;
SamplePlayer buttonOneSound;


ControlP5 p5;
int backgroundColor;
Button voiceOne;
Button voiceTwo;
float volume = .5f;
Gain g;
Glide backgroundGainGlide;
float backgroundVolume = 1;

public void setup() {
   //size(width, height) must be the first line in setup()

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
      backgroundSound.setPosition(0.0f);
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

public void draw() {
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
      backgroundGainGlide.setValue(-1.5f);
  }
    buttonOneSound.pause(false);

}

public void FastForward() {
    buttonOneSound.pause(false);

  backgroundSound.pause(false);

  backgroundGainGlide.setValue(1.75f);
}
public void Reset() {
  backgroundSound.pause(true);
  backgroundGainGlide.setValue(1.0f);
  backgroundSound.setToLoopStart();
    buttonOneSound.pause(false);


  System.out.println("reset");
}
//helper functions
AudioContext ac; //needed here because getSamplePlayer() uses it below

public Sample getSample(String fileName) {
 return SampleManager.sample(dataPath(fileName)); 
}

public SamplePlayer getSamplePlayer(String fileName, Boolean killOnEnd) {
  SamplePlayer player = null;
  try {
    player = new SamplePlayer(ac, getSample(fileName));
    player.setKillOnEnd(killOnEnd);
    player.setName(fileName);
  }
  catch(Exception e) {
    println("Exception while attempting to load sample: " + fileName);
    e.printStackTrace();
    exit();
  }
  
  return player;
}

public SamplePlayer getSamplePlayer(String fileName) {
  return getSamplePlayer(fileName, false);
}
  public void settings() {  size(648, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ClementTravis_ce5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
