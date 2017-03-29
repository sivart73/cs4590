import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;
import java.util.Comparator;
import java.util.PriorityQueue;
import java.util.*;


int numberEventStreams = 0;
boolean useTTS = false;
Set<String> friends = new HashSet<String>();
Set<String> foes = new HashSet<String>();
Set<String> expectedEmailSender = new HashSet<String>();

Timer timer;

SamplePlayer workout;
SamplePlayer walking;
SamplePlayer presenting;
SamplePlayer socializing;

CheckBox events;


SamplePlayer tweet;
SamplePlayer phone;
SamplePlayer vm;
SamplePlayer mail;
SamplePlayer text;


SamplePlayer tweetMany;
SamplePlayer mailHigh;
SamplePlayer textHigh;

SamplePlayer textToSpeech; 
WavePlayer heart;
WavePlayer heart2;

Compressor c;
Gain g;
Gain alertgain;
Gain heartgain;
//to use this, copy notification.pde, notification_listener.pde and notification_server.pde from this sketch to yours.
//Example usage below.

//name of a file to load from the data directory
String eventDataJSON1 = "ExampleData_1.json";
String eventDataJSON2 = "ExampleData_2.json";
String frameWorkDebugJSON = "framework_debug_data.json";

NotificationServer server;
ArrayList<Notification> notifications;

NotificationListener mylistener;
Comparator<Notification> notifycompar ;
PriorityQueue<Notification> emailQueue ;
PriorityQueue<Notification> tweetQueue ;
PriorityQueue<Notification> voiceMailQueue ;
PriorityQueue<Notification> missedCallQueue ;
PriorityQueue<Notification> textQueue ;


Context currentContext = new Context();

void setup() {
  size(640, 480);
  ac = new AudioContext(); 
  ttsMaker = new TextToSpeechMaker();
  notifycompar = new NotificationComparator();
  emailQueue = new PriorityQueue<Notification>(10, notifycompar);
  tweetQueue = new PriorityQueue<Notification>(10, notifycompar);
  voiceMailQueue = new PriorityQueue<Notification>(10, notifycompar);
  missedCallQueue = new PriorityQueue<Notification>(10, notifycompar);
  textQueue = new PriorityQueue<Notification>(10, notifycompar);

  buttons();

  textToSpeech = getSamplePlayer("tts-sample.wav");
  textToSpeech.pause(true);


  walking = getSamplePlayer("walking.wav");
  walking.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  walking.pause(true);

  workout = getSamplePlayer("workout.wav");
  workout.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  workout.pause(true);
  
  socializing = getSamplePlayer("socializing.mp3");
  socializing.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  socializing.pause(true);

  presenting = getSamplePlayer("presenting.mp3");
  presenting.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  presenting.pause(true);

  mail = getSamplePlayer("email.wav");
  mail.pause(true);

  phone = getSamplePlayer("phone.wav");
  phone.pause(true);
  
  text = getSamplePlayer("text.wav");
  text.pause(true);

  vm = getSamplePlayer("voicemail.wav");
  vm.pause(true);

  tweet = getSamplePlayer("tweet.wav");
  tweet.pause(true);


  mailHigh = getSamplePlayer("emailHighPriority.wav");
  mailHigh.pause(true);

  
  textHigh = getSamplePlayer("textHighPriority.wav");
  textHigh.pause(true);


  tweetMany = getSamplePlayer("tweetsMany.wav");
  tweetMany.pause(true);
  c = new Compressor(ac, 1);
  c.setAttack(100);
  c.setDecay(10);
  c.setRatio(4.0);
  c.setThreshold(0.6);

  heart = new WavePlayer(ac, 125, Buffer.SINE);

  heart.pause(true);
  c.addInput(heart);
  g = new Gain(ac, 1, .5);


  heartgain = new Gain(ac, 1, .8);

  alertgain = new Gain(ac, 5, 1);


  heartgain.addInput(c);

  g.addInput(walking);
  g.addInput(workout);
  g.addInput(socializing);
  g.addInput(presenting);

  alertgain.addInput(mail);
  alertgain.addInput(text);
  alertgain.addInput(phone);
  alertgain.addInput(vm);
  alertgain.addInput(tweet);


  alertgain.addInput(mailHigh);
  alertgain.addInput(textHigh);

  alertgain.addInput(tweetMany);
  ac.out.addInput(heartgain);

  ac.out.addInput(alertgain);

  ac.out.addInput(g);
  ac.start();


  addFriendsFoe();
  addEmailHotList();
  endListen();


   //START NotificationServer setup
   server = new NotificationServer();
   
  //instantiating a custom class (seen below) and registering it as a listener to the server

  mylistener = new MyListener();
  server.addListener(mylistener);
  
  //loading the event stream, which also starts the timer serving events
  server.loadEventStream(eventDataJSON1);
  
  //END NotificationServer setup
  //sonify();

}


void draw() {

  //this method must be present (even if empty) to process events such as keyPressed()  
}


public void Walking() {
alertgain.setGain(1);


  walking.pause(false);
  walking.setToLoopStart();

  workout.pause(true);
  workout.setToLoopStart();

  socializing.pause(true);
  socializing.setToLoopStart();


  presenting.pause(true);
  presenting.setToLoopStart();

  currentContext = new Walking();


}

public void WorkingOut() {
alertgain.setGain(1);

  walking.pause(true);
  walking.setToLoopStart();

  workout.pause(false);
  workout.setToLoopStart();

  socializing.pause(true);
  socializing.setToLoopStart();

  presenting.pause(true);
  presenting.setToLoopStart();

  currentContext = new Workout();



}


public void Socializing() {
alertgain.setGain(2);
  walking.pause(true);
  walking.setToLoopStart();

  workout.pause(true);
  workout.setToLoopStart();

  socializing.pause(false);
  socializing.setToLoopStart();

  presenting.pause(true);
  presenting.setToLoopStart();

  currentContext = new Socializing();



}

public void Presenting() {
alertgain.setGain(.5);

  walking.pause(true);
  walking.setToLoopStart();

  workout.pause(true);
  workout.setToLoopStart();

  socializing.pause(true);
  socializing.setToLoopStart();

  presenting.pause(false);
  presenting.setToLoopStart();


  currentContext = new Presenting();


}

public void Heartbeat() {
  if (heart.isPaused()) {
    heart.pause(false);
  } else {
    heart.pause(true);
  }
}


public void Data1() {
  changeEventStream(eventDataJSON1);

}

public void Data2() {
  changeEventStream(eventDataJSON2);
}


public void Debug() {
 changeEventStream(frameWorkDebugJSON);
}


public void changeEventStream(String eventDataJSON) {
    server.stopEventStream(); //always call this before loading a new stream
    cleanQueues();  // clean out priority queue - things get sort of weird if you don't
    server.loadEventStream(eventDataJSON);
    println("**** New event stream loaded: " + eventDataJSON + " ****");
  }



  public void cleanQueues() {
   emailQueue.clear();  
   tweetQueue.clear();  
   voiceMailQueue.clear();  
   missedCallQueue.clear();  
   textQueue.clear();  

 }



 public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(events)) {
    int numberEventStreams = 0;
    for (int i=0;i<events.getArrayValue().length;i++) {
      println ((int)events.getArrayValue()[i]);
      int n = (int)events.getArrayValue()[i];
      if(n==1) {
        numberEventStreams++;
      }
    }


    if ((int)events.getArrayValue()[0] == 0){
             emailQueue.clear();

}

    if ((int)events.getArrayValue()[1] == 0){
            missedCallQueue.clear();

}

    if ((int)events.getArrayValue()[2] == 0){
            textQueue.clear();

}

 if ((int)events.getArrayValue()[3] == 0){
            tweetQueue.clear();

}
    if ((int)events.getArrayValue()[4] == 0){
            voiceMailQueue.clear();

}
    if (numberEventStreams <= 2) {
      useTTS = true;
    } else {
      useTTS = false;
    }
    println(numberEventStreams);    
  }
}




