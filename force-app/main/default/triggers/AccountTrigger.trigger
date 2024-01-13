trigger AccountTrigger on Account(before insert, before update, before delete, 
                                  after insert, after update, after delete, after undelete) 
{
    
    switch on Trigger.operationType {
        
        when BEFORE_INSERT {
            //Invoke before insert trigger handler
            AccountTriggerHandler.beforeInsert(Trigger.new);
            AccountTriggerHandler.beforeInsertBeforeUpdate(Trigger.new);
        }
        when BEFORE_UPDATE {
            //Invoke before update trigger handler
            AccountTriggerHandler.beforeInsertBeforeUpdate(Trigger.new);
        }
        when BEFORE_DELETE {
            //Invoke before delete trigger handler
            AccountTriggerHandler.beforeDelete(Trigger.old);
        }
        when AFTER_INSERT {
            //Invoke after insert trigger handler
            AccountTriggerHandler.afterInsert(Trigger.new);
        }
        
        when AFTER_UPDATE {
            //Invoke after update trigger handler
            AccountTriggerHandler.afterUpdate(Trigger.new);
        }
        when AFTER_DELETE {
            //Invoke after delete trigger handler
            AccountTriggerHandler.afterDelete(Trigger.old);
        }
        when AFTER_UNDELETE {
            //Invoke after undelete trigger handler
            AccountTriggerHandler.afterUndelete(Trigger.new);
        }
    }
}