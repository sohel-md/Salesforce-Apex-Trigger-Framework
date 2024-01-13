public class AccountTriggerHandler {
    
    //Populate Account Description
    public static void beforeInsert(List<Account> newAccounts) {
        for(Account acc: newAccounts){
            acc.Description = 'Test Description populated by AccountTrigger';
        }
    }
    
    //Populate Account Rating based on Account Industry
    public static void beforeInsertBeforeUpdate(List<Account> newAccounts) {
        for(Account acc: newAccounts){ 
            if(String.isNotBlank(acc.Industry)) {
                if(acc.Industry == 'Banking'){
                    acc.Rating = 'Hot';
                }
                else {
                    acc.Rating = 'Cold';
                }
            }
        }
    }
    
    public static void beforeDelete(List<Account> oldAccounts) {
        for(Account acc: oldAccounts){
            if(acc.Active__c == TRUE) {
                acc.addError('Active Account cannot deleted');
            }
        }
    }
    
    public static void afterInsert(List<Account> newAccounts) {
        List<Contact> listContact = new List<Contact>();
        for(Account acc: newAccounts){
            Contact con = new Contact();
            con.LastName = acc.Name + ' Contact';
            con.Description = 'This Contact is created by AccountTrigger';
            con.AccountId = acc.Id;
            listContact.add(con);
        }
        if(!listContact.isEmpty()){
            try{
                Database.insert(listContact, false);
            }
            catch(Exception e){
                System.debug('Exception '+e);
            }
        }
    }
    
    public static void afterUpdate(List<Account> newAccounts) {
        Map <Id, Account> mapAccount = new Map <Id, Account>();
        List <Contact> listContact = new List <Contact>();
        for (Account acct: newAccounts){
            mapAccount.put(acct.Id, acct);
        }
        listContact = [SELECT Description, AccountId FROM Contact 
                       WHERE AccountId IN: mapAccount.keySet()];
        if (!listContact.isEmpty()) {
            for (Contact con: listContact) {
                con.Description = mapAccount.get(con.AccountId).Description;                
            }
            update listContact;
        }
    }
    
    public static void afterDelete(List<Account> oldAccounts) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for (Account acc : oldAccounts) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'your email id'};
                mail.setToAddresses(toAddresses);
            mail.setSubject('Account record is deleted');
            String body = 'Account record is deleted from Salesforce org.';
            mail.setHtmlBody(body);
            mails.add(mail);
        } 
        Messaging.sendEmail(mails);
    }
    
    public static void afterUndelete(List<Account> newAccounts) {
        List<Account> listAccount = new List<Account>();
        for(Account acc : [SELECT ID, Name, Description from Account where Id IN : newAccounts]){ 
            acc.Name = acc.Name + ' - Undeleted';
            acc.Description = 'This Account is updated by Apex Trigger';
            listAccount.add(acc);
        }
        if(!listAccount.isEmpty()){
            try {
                Database.update(listAccount, false);
            }
            catch(Exception ex){
                System.debug('Exception '+ex);
            }
        }
    }
}