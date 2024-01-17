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
}