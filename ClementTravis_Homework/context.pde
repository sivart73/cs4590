class Context {
	int minTweetPriority = 0;
	int minPhonePriority = 0;
	int minVmPriority = 0;
	int minEmailPriority = 0;
	int minTextPriority = 0;	


	
	void handleEmail(Notification notification) {

		int priority = notification.getPriorityLevel();
		int contentSummary = notification.getContentSummary();
		setFriendOrFoe(notification);
        if (expectedEmailSender.contains(notification.getSender())){
        	     String emailSpeech = "Email from" + notification.getSender();

    		 ttsExamplePlayback(emailSpeech);
        } else if (priority >= 4 && contentSummary == 3 || 
			expectedEmailSender.contains(notification.getSender())) {

			mailHigh.reTrigger(); 
		}
		else if (priority >= currentContext.minEmailPriority) {
			emailQueue.add(notification);
		}
	}


	void handleText(Notification notification) {

		int priority = notification.getPriorityLevel();
		int contentSummary = notification.getContentSummary();
		setFriendOrFoe(notification);
		if (priority >= 4 && contentSummary == 3) {
			textHigh.reTrigger(); 
		} else if (notification.getPriorityLevel() >= currentContext.minTextPriority) {
			setFriendOrFoe(notification);
			textQueue.add(notification);
            //text.reTrigger();
        }
    }


    void handleVoiceMail(Notification notification){

    	int priority = notification.getPriorityLevel();
    	int contentSummary = notification.getContentSummary();
    	setFriendOrFoe(notification);
    	if (priority >= 4 && contentSummary == 3) {
    		vm.reTrigger(); 
    	} else if (notification.getPriorityLevel() >= currentContext.minVmPriority) {
    		voiceMailQueue.add(notification);

        //vm.reTrigger();
    }
}


void handleMissedCall(Notification notification) {
	setFriendOrFoe(notification);
	if (notification.getPriorityLevel() >= currentContext.minPhonePriority) {
		missedCallQueue.add(notification);

    }
}

void handleTweet(Notification notification) {
	setFriendOrFoe(notification);

	if (notification.getPriorityLevel() >= currentContext.minTweetPriority) {
		tweetQueue.add(notification);
	}

}

void setFriendOrFoe(Notification notification) {

	if (friends.contains(notification.getSender())) {
		notification.priority++;
	}
	if (foes.contains(notification.getSender())) {
		notification.priority--;

	}
}
}
