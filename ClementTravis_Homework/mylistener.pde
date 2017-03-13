
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
                        notification.getPriorityLevel() >= currentContext.minPhonePriority) {

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
