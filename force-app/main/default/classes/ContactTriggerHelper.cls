public class ContactTriggerHelper {
	
    public static void checkDuplicate( List<Contact> contactList) {
        Set<String> newEmailSet = new Set<String>();
        Set<String> existingEmailSet = new Set<String>();
        for ( Contact con : contactList ) {
            if ( con.Email != null ) {
                newEmailSet.add( con.Email );
            }
        }
        List<Contact> existingContactList = [Select Id, Email From Contact 
                                             Where Email IN: newEmailSet];
        for (Contact con : existingContactList ) {
            existingEmailSet.add( con.Email );
        }
        
        for ( Contact con : contactList ) { 
            if ( existingEmailSet.contains( con.Email ) ) {
                con.Email.AddError('Duplicate Email is not Allowed ');
            } else {
                existingEmailSet.add(con.Email);
            }
        }
    }
}