class Context {
int minTweetPriority = 0;
int minPhonePriority = 0;
int minVmPriority = 0;
int minEmailPriority = 0;
int minTextPriority = 0;	

    boolean shouldIPlay(Notification notification) {
    	return notification.getPriorityLevel() >= this.minPhonePriority ;
    		
    	}
   
	
}
