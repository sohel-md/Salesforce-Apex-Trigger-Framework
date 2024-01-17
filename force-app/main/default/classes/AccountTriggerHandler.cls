public class AccountTriggerHandler implements TriggerInterface {
    
    public static void beforeInsert(List<sObject> newRecordsList){
        AccountTriggerHelper.updateAccount((List<Account>)newRecordsList);
    }
    
    public static void afterInsert(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap){
        AccountTriggerHelper.createContact((List<Account>)newRecordsList);
    }
    
    public static void beforeUpdate(Map<Id, sObject> newRecordsMap, Map<Id, sObject> oldRecordsMap){
        AccountTriggerHandler.updateAccount ((List<Account>)newRecordsMap.values());
    }
    
    public static void afterUpdate(Map<Id, sObject> newRecordsMap,  Map<Id, sObject> oldRecordsMap){
    }
    
    public static void beforeDelete(List<sObject> oldRecordsList , Map<Id, sObject> oldRecordsMap){
    }
    
    public static void afterDelete(Map<Id, sObject> oldRecordsMap){
    }
    
    public static void afterUnDelete(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap) {
    }
}