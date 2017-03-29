class Workout extends Context {
	



  public Workout() {
   super();
   minTweetPriority = 1;
   minPhonePriority = 1;
   minVmPriority = 1;
   minEmailPriority = 1 ;
   minTextPriority = 1;
 } 


 @Override
 void handleTweet(Notification notification) {
   if (notification.getPriorityLevel() >= currentContext.minTweetPriority)
   { 
    if (notification.getRetweets() > 10 && useTTS) {
     String tweetSpeech = "Tweet from" + notification.getSender().substring(1) +
     " message" + notification.getMessage();

     ttsExamplePlayback(tweetSpeech);
   } else {
                  //tweet.reTrigger();
      tweetQueue.add(notification);
     }
   }
}
}
        