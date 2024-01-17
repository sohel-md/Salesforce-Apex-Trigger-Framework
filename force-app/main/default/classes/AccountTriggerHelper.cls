public with sharing class AccountTriggerHelper {
    
    //Update Account Rating based on Account Industry
    public static void updateAccount(List<Account> newAccounts) {
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
    
    //Create Contact when Account is created.
    public static void createContact(List<Account> listAcc){
        
        List<Contact> listContact = new List<Contact>();
        for(Account acc: listAcc){
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            con.Description = 'Test Description.';
            listContact.add(con);
        }
        if(!listContact.isEmpty()){
            try{
                Database.SaveResult[] srList = Database.insert(listContact, false);
                for(Database.SaveResult sr : srList){
                    if(sr.isSuccess()){
                        System.debug('Account inserted successfully. Account Id: '+sr.getId());
                    }
                    else {
                        for(Database.Error err : sr.getErrors()){
                            System.debug('Error '+err.getMessage());
                        }
                    }
                }
            }
            catch(Exception ex){
                System.debug('Exception occurred '+ex);
            }
        }
    }
    
    //Update Contact when Account is updated.
    public static void updateContact(List<Account> listAcc){ 
        Map < Id, Account > mapAccount = new Map < Id, Account > ();
        List < Contact > listContact = new List < Contact > ();
        
        for (Account acct: listAcc)
            mapAccount.put(acct.Id, acct);
        
        listContact = [SELECT MailingStreet, MailingCity, AccountId FROM Contact
                       WHERE AccountId IN: mapAccount.keySet()
                      ];
        
        if (listContact.size() > 0) {
            for (Contact con: listContact) {
                con.MailingStreet = mapAccount.get(con.AccountId).BillingStreet;
                con.MailingCity = mapAccount.get(con.AccountId).BillingCity;
            }
            if(!listContact.isEmpty()){
                try {
                    Database.update(listContact, false);
                }   
                catch(Exception exception) {
                    System.debug('Exception occurred. '+exception.getMessage());
                }
            }
        }
        
    }
    
}