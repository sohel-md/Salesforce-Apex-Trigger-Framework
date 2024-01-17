/* An interface is like a class that does not have any of its methods implemented. 
Each method’s body is empty; all that is present are the method signatures. */

public interface TriggerInterface {
    
    void beforeInsert(List<sObject> newRecordsList);

    void beforeUpdate(Map<Id, sObject> newRecordsMap, Map<Id, sObject> oldRecordsMap);

    void beforeDelete(List<sObject> oldRecordsList , Map<Id, sObject> oldRecordsMap);

    void afterInsert(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap);
    
    void afterUpdate(Map<Id, sObject> newRecordsMap,  Map<Id, sObject> oldRecordsMap);

    void afterDelete(Map<Id, sObject> oldRecordsMap);
    
    void afterUnDelete(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap);
    
}