
class MyListener implements NotificationListener {
  
  
  //this method must be implemented to receive notifications
  public void notificationReceived(Notification notification) { 
    println("<Example> " + notification.getType().toString() + " notification received at " 
    + Integer.toString(notification.getTimestamp()) + "millis.");

    String debugOutput = "";


    switch (notification.getType()) {
      case Email:

        debugOutput += "New email from ";

           if ((int)events.getArrayValue()[0] == 1) {
              currentContext.handleEmail(notification);
           }
        break;

      case MissedCall:
        debugOutput += "Missed call from ";
        if ((int)events.getArrayValue()[1] == 1) {
           currentContext.handleMissedCall(notification);
        }
        break;

      case TextMessage:
        debugOutput += "New message from ";
        if ((int)events.getArrayValue()[2] == 1) {
             currentContext.handleText(notification);

        }
        break;

     case Tweet:
        debugOutput += "New tweet from ";
        if ((int)events.getArrayValue()[3] == 1) {
         currentContext.handleTweet(notification);
        }
        break;

      case VoiceMail:
        debugOutput += "New voicemail from ";
         if ((int)events.getArrayValue()[4] == 1) {
            currentContext.handleVoiceMail(notification);
         }
        break;
   }
    debugOutput += notification.getSender() + ", " + notification.getMessage();
    
    //println(debugOutput);
    
  }
}
