import java.util.Comparator;

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

