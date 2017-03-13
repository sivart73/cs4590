import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import beads.*; 
import org.jaudiolibs.beads.*; 
import java.util.Comparator; 
import java.util.PriorityQueue; 
import java.util.Comparator; 
import java.util.Calendar; 
import java.util.Date; 
import java.util.Timer; 
import java.util.TimerTask; 
import com.sun.speech.freetts.FreeTTS; 
import com.sun.speech.freetts.Voice; 
import com.sun.speech.freetts.VoiceManager; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ClementTravis_Homework extends PApplet {








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
PriorityQueue<Notification> notifyqueue ;


Context currentContext = new Context();

public void setup() {
    
 ac = new AudioContext(); 
 ttsMaker = new TextToSpeechMaker();
 notifycompar = new NotificationComparator();
 notifyqueue = new PriorityQueue<Notification>(10, notifycompar);

 buttons();
 
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

c = new Compressor(ac, 1);
c.setAttack(100);
c.setDecay(10);
c.setRatio(4.0f);
c.setThreshold(0.6f);

  heart = new WavePlayer(ac, 125, Buffer.SINE);

  heart.pause(true);
  c.addInput(heart);
  g = new Gain(ac, 1, .5f);


  heartgain = new Gain(ac, 1, .5f);

  alertgain = new Gain(ac, 5, 2);


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
  ac.out.addInput(heartgain);

  ac.out.addInput(alertgain);

  ac.out.addInput(g);
  ac.start();


   //START NotificationServer setup
  server = new NotificationServer();
  
  //instantiating a custom class (seen below) and registering it as a listener to the server

  mylistener = new MyListener();
  server.addListener(mylistener);
  
  //loading the event stream, which also starts the timer serving events
  server.loadEventStream(eventDataJSON1);
  
  //END NotificationServer setup

}


public void draw() {
  //this method must be present (even if empty) to process events such as keyPressed()  
}


public void Walking() {


  walking.pause(false);
  walking.setToLoopStart();

  workout.pause(true);
  workout.setToLoopStart();

  socializing.pause(true);
  socializing.setToLoopStart();


  presenting.pause(true);
  presenting.setToLoopStart();

  currentContext = new Walking();



while (notifyqueue.peek() != null) {
println(notifyqueue.poll());


}
}

public void WorkingOut() {

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
    notifyqueue.clear();  // clean out priority queue - things get sort of weird if you don't
    server.loadEventStream(eventDataJSON);
    println("**** New event stream loaded: " + eventDataJSON + " ****");
}




public void playBackgroundSound(String background) {
}


// void controlEvent(ControlEvent theEvent) {
//   if (theEvent.isFrom(events)) {
//     currentContext.playEmail = (int) events.getArrayValue()[0];
//     currentContext.playPhone = (int) events.getArrayValue()[1];
//     currentContext.playText = (int) events.getArrayValue()[2];
//     currentContext.playTweet = (int) events.getArrayValue()[3];
//     currentContext.playVM = (int) events.getArrayValue()[4];


//   }

ControlP5 p5;

public void buttons() {


  p5 = new ControlP5(this);



 p5.addButton("WorkingOut")
    .setPosition(0, 50)
    .setSize(80, 80)
    .setLabel("Working Out")
    ;


  p5.addButton("Walking")
    .setPosition(80, 50)
    .setSize(80, 80)
    .setLabel("Walking")
    ;

  p5.addButton("Socializing")
    .setPosition(160, 50)
    .setSize(80, 80)
    .setLabel("Socializing")
    ;


  p5.addButton("Presenting")
    .setPosition(240, 50)
    .setSize(80, 80)
    .setLabel("Presenting")
    ;

//// Event buttons and other
 p5.addButton("Heartbeat")
    .setPosition(0, 150)
    .setSize(80, 80)
    .setLabel("Heart Beat")
    ;


  p5.addButton("Data1")
    .setPosition(80, 150)
    .setSize(80, 80)
    .setLabel("Stream \nExampleData_1")
    ;

  p5.addButton("Data2")
    .setPosition(160, 150)
    .setSize(80, 80)
    .setLabel("Stream \n ExampleData_2")
    ;


  p5.addButton("Debug")
    .setPosition(240, 150)
    .setSize(80, 80)
    .setLabel("Framework \ndebug_data")
    ;

  events = p5.addCheckBox("Events")
                .setPosition(400, 50)
                .setColorForeground(color(120))
                .setColorActive(color(255))
                .setColorLabel(color(0))
                .setSize(40, 40)
                .setItemsPerRow(1)
                .setSpacingColumn(30)
                .addItem("Email", 0)
                .addItem("Phone Call", 0)
                .addItem("Text", 0)
                .addItem("Twitter", 0)
                .addItem("Voice Mail", 0)
                ;
}
 
class Context {
int minTweetPriority = 0;
int minPhonePriority = 0;
int minVmPriority = 0;
int minEmailPriority = 0;
int minTextPriority = 0;	

    public boolean shouldIPlay(Notification notification) {
    	return notification.getPriorityLevel() >= this.minPhonePriority ;
    		
    	}
   
	
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

//in your own custom class, you will implement the NotificationListener interface 
//(with the notificationReceived() method) to receive Notification events as they come in
class MyListener implements NotificationListener {
  
  
  //this method must be implemented to receive notifications
  public void notificationReceived(Notification notification) { 
    println("<Example> " + notification.getType().toString() + " notification received at " 
    + Integer.toString(notification.getTimestamp()) + "millis.");
      notifyqueue.add(notification);

    String debugOutput = "";
    switch (notification.getType()) {
      case Email:
        debugOutput += "New email from ";
           if (events.getArrayValue()[0] == 1 && 
                notification.getPriorityLevel() >= currentContext.minEmailPriority) {

              mail.reTrigger(); 
           }
        break;

      case MissedCall:
        debugOutput += "Missed call from ";
        if (events.getArrayValue()[1] == 1 && 
                        currentContext.shouldIPlay(notification)) {

        phone.reTrigger();
      }
        break;
      case TextMessage:
        debugOutput += "New message from ";
        if (events.getArrayValue()[2] == 1 && 
            notification.getPriorityLevel() >= currentContext.minTextPriority) {
            text.reTrigger();
           }
      
        break;

     case Tweet:
        debugOutput += "New tweet from ";

        if (events.getArrayValue()[3] == 1 && 
                        notification.getPriorityLevel() >= currentContext.minTweetPriority)
        { 
        if (notification.getRetweets() > 10) {
         String tweetSpeech = "Tweet from" + notification.getSender().substring(1) +
                                       " message" + notification.getMessage();

                  ttsExamplePlayback(tweetSpeech);
                  } else {
                  tweet.reTrigger();
                 }
        }

        break;
      case VoiceMail:
        debugOutput += "New voicemail from ";
                   if (events.getArrayValue()[4] == 1 && 
                        notification.getPriorityLevel() >= currentContext.minVmPriority){

        vm.reTrigger();
      }
        break;
   }
    debugOutput += notification.getSender() + ", " + notification.getMessage();
    
    println(debugOutput);
    
  }
}
enum NotificationType { Tweet, Email, TextMessage, MissedCall, VoiceMail }

class Notification {
   
  int timestamp;
  NotificationType type; //Tweet, Email, TextMessage, MissedCall, VoiceMail
  String message; //NOT used by MissedCall
  String sender;
  int priority;
  int contentSummary; //NOT used by Tweet or MissedCall
  int retweets; //used by Tweet only
  int favorites; //used by Tweet only
  
  public Notification(JSONObject json) {
    this.timestamp = json.getInt("timestamp");
    //time in milliseconds for playback from sketch start
    
    String typeString = json.getString("type");
    
    try {
      this.type = NotificationType.valueOf(typeString);
    }
    catch (IllegalArgumentException e) {
      throw new RuntimeException(typeString + " is not a valid value for enum NotificationType.");
    }
    
    
    if (json.isNull("message")) {
      this.message = "";
    }
    else {
      this.message = json.getString("message");
    }
    
    if (json.isNull("sender")) {
      this.sender = "";
    }
    else {
      this.sender = json.getString("sender");      
    }
    
    this.priority = json.getInt("priority");
    //1-4 levels (1 is lowest, 4 is highest)
    
    if (json.isNull("contentSummary")) {
      this.contentSummary = 0;
      //0 == not applicable to this notification type
    }
    else {
      this.contentSummary = json.getInt("contentSummary");
      //1 = negative, 2 = neutral, 3 = positive
    }
     
    if (json.isNull("retweets")) {
      this.retweets = 0;
    }
    else {
      this.retweets = json.getInt("retweets");      
    }
    
    if (json.isNull("favorites")) {
      this.favorites = 0;
    }
    else {
      this.favorites = json.getInt("favorites");      
    }
                             
  }
  
  public int getTimestamp() { return timestamp; }
  public NotificationType getType() { return type; }
  public String getMessage() { return message; }
  public String getSender() { return sender; }
  public int getPriorityLevel() { return priority; }
  public int getContentSummary() { return contentSummary; }
  public int getRetweets() { return retweets; }
  public int getFavorites() { return favorites; }
  
  public String toString() {
      String output = getType().toString() + ": ";
      output += "(" + getSender() + ")";
      output += " " + getMessage();
      output += " " + getPriorityLevel();

      return output;
    }
}


public class NotificationComparator implements Comparator<Notification>
{
    @Override
    public int compare(Notification a, Notification b)
    {

    if (b.getPriorityLevel() - a.getPriorityLevel() > 0) {
    	return 1;
    	} else if (b.getPriorityLevel() - a.getPriorityLevel() == 0) {
    		return  a.timestamp - b.timestamp;
    	 }	else {
    			return -1;
    		}

    	}
        
    
}

interface NotificationListener {
  public void notificationReceived(Notification notification);
}





class NotificationServer {
  
  Boolean debugMode = true; //set this to false to turn off the println statements on each Notification below
  
  Timer timer;
  Calendar calendar;
  private ArrayList<NotificationListener> listeners;
  private ArrayList<Notification> currentNotifications;

  public NotificationServer() {
    timer = new Timer();
    listeners = new ArrayList<NotificationListener>();
    calendar = Calendar.getInstance();
  }
  
  //loads and schedules all tasks
  //you should register all listeners before calling this method
  public void loadEventStream(String eventDataJSON) {
    currentNotifications = this.getNotificationDataFromJSON(loadJSONArray(eventDataJSON));
    
    //Starting the NotificationServer (scheduling tasks) 
    for (int i = 0; i < currentNotifications.size(); i++) {
      this.scheduleTask(currentNotifications.get(i));
    }
    
  }
  
  public void stopEventStream() {
    if (timer != null)
      timer.cancel(); //stop all currently scheduled tasks
    timer = new Timer();  //create a new Timer for future scheduling
  }
  
  public ArrayList<Notification> getCurrentNotifications() {
    return currentNotifications;
  }
  
  public ArrayList<Notification> getNotificationDataFromJSON(JSONArray values) {
    ArrayList<Notification> notifications = new ArrayList<Notification>();
    for (int i = 0; i < values.size(); i++) {
      notifications.add(new Notification(values.getJSONObject(i)));
    }
    return notifications;
  }

  public void scheduleTask(Notification notification) {
    timer.schedule(new NotificationTask(this, notification), notification.getTimestamp());
  }
  
  public void addListener(NotificationListener listenerToAdd) {
    listeners.add(listenerToAdd);
  }
  
  public void notifyListeners(Notification notification) {
    if (debugMode)
      println("<NotificationServer> " + notification.toString());
    for (int i=0; i < listeners.size(); i++) {
      listeners.get(i).notificationReceived(notification);
    }
  }
 } 

  class NotificationTask extends TimerTask {
    
    NotificationServer server;
    Notification notification;
    
    public NotificationTask(NotificationServer server, Notification notification) {
      super();
      this.server = server;
      this.notification = notification;
    }
    
    public void run() {
      server.notifyListeners(notification);
    }
    
  }
class Presenting extends Context {
	


      public Presenting() {
      	    super();

			minTweetPriority = 4;
			minPhonePriority = 4;
			minVmPriority = 4;
			minEmailPriority = 4;
			minTextPriority = 4;
      } 



}
class Socializing extends Context{


      public Socializing() {
      	     super();

			minTweetPriority = 2;
			minPhonePriority = 2;
			minVmPriority = 2;
			minEmailPriority = 2 ;
			minTextPriority = 2;
      } 

}
//IMPORTANT:
//to use this you must import 'ttslib' into Processing, as this code uses the included FreeTTS library
//e.g. from the Menu Bar select Sketch -> Import Library... -> ttslib





class TextToSpeechMaker {

  final String TTS_FILE_DIRECTORY_NAME = "tts_samples";
  final String TTS_FILE_PREFIX = "tts";
  
  File ttsDir;
  boolean isSetup = false;
  
  int fileID = 0;
  
  FreeTTS freeTTS;
  
  private Voice voice;
    
  public TextToSpeechMaker() {
    
    VoiceManager voiceManager = VoiceManager.getInstance();
    voice = voiceManager.getVoice("kevin16");
    //using other voices is not supported (unfortunately), so you are stuck with Kevin16
    
    //find our tts_sample directory and clean it out if it has files from a previous running of this sketch
    findTTSDirectory();
    cleanTTSDirectory();
    
    freeTTS = new FreeTTS(voice);
    freeTTS.setMultiAudio(true);
    freeTTS.setAudioFile(getTTSFilePath() + "/" + TTS_FILE_PREFIX + ".wav");
    
    freeTTS.startup();
    voice.allocate();
  }
  
  //creates a WAV file of the input speech and returns the path to that file 
  public String createTTSWavFile(String input) {
    String filePath = TTS_FILE_DIRECTORY_NAME + "/" + TTS_FILE_PREFIX + Integer.toString(fileID) + ".wav";
    fileID++;
    voice.speak(input);
    return filePath; //you will need to use dataPath(filePath) if you need the full path to this file, see Example
  }
  
  //cleans up voice and FreeTTS object, use this if you are going to destroy the TextToSpeechServer object
  public void cleanup() {
    voice.deallocate();
    freeTTS.shutdown();
  }
  
  public String getTTSFilePath() {
    return dataPath(TTS_FILE_DIRECTORY_NAME);
  }
  
  //finds the tts file directory under the data path and creates it if it does not exist
  public void findTTSDirectory() {
    File dataDir = new File(dataPath(""));
    if (!dataDir.exists()) {
      try {
        dataDir.mkdir();
      }
      catch(SecurityException se) {
        println("Data directory not present, and could not be automatically created.");
      }
    }
    
    ttsDir = new File(getTTSFilePath());
    boolean directoryExists = ttsDir.exists();
    if (!directoryExists) {
      try {
        ttsDir.mkdir();
        directoryExists = true;
      }
      catch(SecurityException se) {
        println("Error creating tts file directory '" + TTS_FILE_DIRECTORY_NAME + "' in the data directory.");
      }
    }
  }
  
  //deletes ALL files in the tts file directory found/created by this object ('tts_samples')
  public void cleanTTSDirectory() {
    //delete existing files
    if (ttsDir.exists()) {
      for (File file: ttsDir.listFiles()) {
        if (!file.isDirectory())
          file.delete();
      }
    }
  }
  
}


TextToSpeechMaker ttsMaker; 


public void ttsExamplePlayback(String inputSpeech) {
 //create TTS file and play it back immediately
 //the SamplePlayer will remove itself when it is finished in this case
  
 String ttsFilePath = ttsMaker.createTTSWavFile(inputSpeech);
 println("File created at " + ttsFilePath);
  
  
 SamplePlayer textToSpeech = getSamplePlayer(ttsFilePath, true); 
 //true means it will delete itself when it is finished playing
 //you may or may not want this behavior!
  
 ac.out.addInput(textToSpeech);
 textToSpeech.setToLoopStart();
 textToSpeech.start();
}

class Walking extends Context {
	



      public Walking() {
      	    super();

			minTweetPriority = 1;
			minPhonePriority = 1;
			minVmPriority = 1;
			minEmailPriority = 1 ;
			minTextPriority = 1;
      } 



}
class Workout extends Context {
	



      public Workout() {
      	    super();
			minTweetPriority = 1;
			minPhonePriority = 1;
			minVmPriority = 1;
			minEmailPriority = 1 ;
			minTextPriority = 1;
      } 

}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ClementTravis_Homework" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
