int emailTimes = 1;
int phoneTimes = 1;
int vmTimes = 1;
int textTimes = 1;
int tweetTimes = 1;    


int numEmail = 0;
int numPhone = 0;
int numVm = 0;
int numText = 0;
int numtweet = 0;  

    void sonify() {
      sonifyEmail();
      sonifyVM();
      sonifyText();
      sonifyTweet();
      sonifyPhone();

    }


    void sonifyEmail() {
      int delay = 0;
      int period = 20000; 

      timer.scheduleAtFixedRate(new TimerTask() {
        public void run() {

         while (otherSamplePlaying()) {
          try {
            Thread.sleep(2000);
          } catch(InterruptedException ex) {
           Thread.currentThread().interrupt();
         }
       }
     
       if (emailQueue.peek() != null) {
         if (emailTimes == 3) {
            emailTimes = 1;
         
              if (emailQueue.size() > 2) {
                  mailHigh.reTrigger(); 

              } else {
                  mail.reTrigger(); 

              }
          emailQueue.clear();

         } else {
          emailTimes++;

            while(emailQueue.peek() != null && emailQueue.peek().getPriorityLevel() >= 3) {
              emailQueue.poll();
              numEmail++;
            }
              if (numEmail > 2) {
                  mailHigh.reTrigger(); 
              } else  if (numEmail >= 1) {
                  mail.reTrigger(); 
              }
              numEmail = 0;
      }
    }
  }
  }, delay, period);

    }

    void sonifyVM() {
      int delay = 10000;
      int period = 5000; 

      timer.scheduleAtFixedRate(new TimerTask() {
        public void run() {

         while (otherSamplePlaying()) {
          try {
            Thread.sleep(2000);
          } catch(InterruptedException ex) {
            Thread.currentThread().interrupt();
          }
        }
 
   if (voiceMailQueue.peek() != null) {
         if (vmTimes == 3) {
            vmTimes = 1;

            vm.reTrigger();
            voiceMailQueue.clear();
              
         } else {
          vmTimes++;

            while(voiceMailQueue.peek() != null && voiceMailQueue.peek().getPriorityLevel() >= 3) {
              voiceMailQueue.poll();
              numVm++;
            }
            if (numVm >= 1) {
            vm.reTrigger();
          }
          numVm = 0;
          }
      }
    }
 
   }, delay, period);

    }


    void sonifyText() {
      int delay = 12000;
      int period = 20000; 

      timer.scheduleAtFixedRate(new TimerTask() {
        public void run() {

         while (otherSamplePlaying()) {
          try {
            Thread.sleep(2000);
          } catch(InterruptedException ex) {
            Thread.currentThread().interrupt();
          }
        }
    

       if (textQueue.peek() != null) {
          if (textTimes == 3) {
              textTimes = 1;
  
               if (textQueue.size() > 2) {
                textHigh.reTrigger(); 
              } else {
                 text.reTrigger();
              }
            textQueue.clear();
         } else {
           textTimes++;

              while(textQueue.peek() != null && textQueue.peek().getPriorityLevel() >= 3) {
                textQueue.poll();
                numText++;
              }
                if (numText > 2) {
                  textHigh.reTrigger(); 
                } else if (numText >= 1) {
                  text.reTrigger();
                }
               numText = 0; 
         }
       }
  }


      
    }, delay, period);

    }


    void sonifyTweet() {
      int delay = 4000;
      int period = 5000; 

      timer.scheduleAtFixedRate(new TimerTask() {
        public void run() {


         while (otherSamplePlaying()) {
          try {
            Thread.sleep(2000);
          } catch(InterruptedException ex) {
            Thread.currentThread().interrupt();
          }
        }

    if (tweetQueue.peek() != null) {
          if (tweetTimes == 3) {
              tweetTimes = 1;
  
               if (tweetQueue.size() > 2) {
                tweetMany.reTrigger();
                } else {
                 tweet.reTrigger();
              }
           tweetQueue.clear();

         } else {
           tweetTimes++;

              while(tweetQueue.peek() != null && tweetQueue.peek().getPriorityLevel() >= 3) {
                tweetQueue.poll();
                numtweet++;
              }
                if (numtweet > 2) {
                  tweetMany.reTrigger(); 
                } else if (numtweet >= 1) {
                  tweet.reTrigger();
                }

                numtweet++;
         }
       }



      }
    }, delay, period);

    }


    void sonifyPhone() {
      int delay = 6000;
      int period = 10000; 

      timer.scheduleAtFixedRate(new TimerTask() {
        public void run() {

         while (otherSamplePlaying()) {
          try {
            Thread.sleep(2000);
          } catch(InterruptedException ex) {
            Thread.currentThread().interrupt();
          }
        }
 


        if (missedCallQueue.peek() != null) {
         if (phoneTimes == 3) {
            phoneTimes = 1;

            phone.reTrigger();
            missedCallQueue.clear();
              
         } else {
          phoneTimes++;

            while(missedCallQueue.peek() != null && missedCallQueue.peek().getPriorityLevel() >= 3) {
              missedCallQueue.poll();
              numPhone++;
            }
            if (numPhone >= 1) {
            phone.reTrigger();
          }
          }
      }
      }
    }, delay, period);

    }


    Boolean otherSamplePlaying() {

  // System.out.println("TWEET IS PAUSED" + tweet.isPaused());
  // System.out.println("VM IS PAUSED" + vm.isPaused());
  // System.out.println("Mail IS PAUSED" + mail.isPaused());

  // System.out.println("text IS PAUSED" + text.isPaused());
  // System.out.println("phone IS PAUSED" + phone.isPaused());

  if (tweet.isPaused() && phone.isPaused() && vm.isPaused() && mail.isPaused() && text.isPaused())  {
   return false;
 }
 return true;
}



