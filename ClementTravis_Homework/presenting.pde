class Presenting extends Context {
	


      public Presenting() {
      	    super();

			minTweetPriority = 4;
			minPhonePriority = 4;
			minVmPriority = 4;
			minEmailPriority = 5;
			minTextPriority = 4;
      } 

	void handleEmail(Notification notification) {

		int priority = notification.getPriorityLevel();
		int contentSummary = notification.getContentSummary();
		setFriendOrFoe(notification);

		if (priority >= 4 && contentSummary == 3) {
			mailHigh.reTrigger(); 
		}
		else if (priority >= currentContext.minEmailPriority) {
			emailQueue.add(notification);
		}
	}

}