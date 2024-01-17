trigger ContactTrigger on Contact (before insert, before update, before delete, 
                                    after insert, after update, after undelete, after delete) {
    
    TriggerDispatcher.run( new ContactTriggerHandler() , Trigger.OperationType );
    
}