/**
* @author Incapsulate
* @description Handler Class for Account object to handle the sequence of helper functions based on the DML events.
*/ 
public with sharing class AccountTriggerHandler extends TriggerBaseHandler
{
    
    public static Map<String,Boolean> triggerContextMap = new Map<String,Boolean>{
        'isExecuteBeforeInsert'=>true,
        'isExecuteAfterInsert'=>true,
        'isExecuteBeforeUpdate'=>true,
        'isExecuteAfterUpdate'=>true,
        'isExecuteBeforeDelete'=>true,
        'isExecuteAfterDelete'=>true,
        'isExecuteAfterUnDelete'=>true};
    
    public override void beforeInsert(List<Sobject> newRecordList)
    {
        if(triggerContextMap.get('isExecuteBeforeInsert'))
        {
            List<Account> accountList = newRecordList;
            for(Account accountRecord : accountList)
            {
                accountRecord.Name = accountRecord.Name + ' beforeInsert';
            }
            triggerContextMap.put('isExecuteBeforeInsert',false);
        }
    }
   
    public override void afterInsert(List<Sobject>newRecordList,Map<Id,Sobject>newRecordMap)
    {
        if(triggerContextMap.get('isExecuteAfterInsert'))
        {
            List<Account> accountList = newRecordList;
            AccountTriggerHelper.createContacct(new Map<String,String>{
                'accountId'=>accountList[0].Id,
                'department'=>'afterInsertDepartment',
                'lastName'=>accountList[0].Name});
            triggerContextMap.put('isExecuteAfterInsert',false);
        }
        
    }
    public override void beforeUpdate(Map<Id,Sobject>oldRecordMap,Map<Id,Sobject>newRecordMap)
    {
        if(triggerContextMap.get('isExecuteBeforeUpdate'))
        {
            List<Account> accountList = newRecordMap.values();
             for(Account a : accountList){
                a.Description = 'Account Before update';
            }
            triggerContextMap.put('isExecuteBeforeUpdate',false);
        }

    }
    public override void afterUpdate(Map<Id,Sobject>oldRecordMap,Map<Id,Sobject>newRecordMap)
    {
        if(triggerContextMap.get('isExecuteAfterUpdate'))
        {
            List<Account> accountList = newRecordMap.values();
            AccountTriggerHelper.updateCaseOrigin(accountList);
            triggerContextMap.put('isExecuteAfterUpdate',false);
        }
    }
    public override void beforeDelete(List<Sobject>oldRecordLis,Map<Id,Sobject>oldRecordMap)
    {
        if(triggerContextMap.get('isExecuteBeforeDelete'))
        {
            triggerContextMap.put('isExecuteBeforeDelete',false);
        }
    }
    public override void afterDelete(Map<Id,Sobject>oldRecordMap)
    {
        if(triggerContextMap.get('isExecuteAfterDelete'))
        {
            triggerContextMap.put('isExecuteAfterDelete',false);
        }
    }
    public override void afterUndelete(List<Sobject>newRecordLis,Map<Id,Sobject>newRecordMap)
    {
        if(triggerContextMap.get('isExecuteAfterUnDelete'))
        { 
            triggerContextMap.put('isExecuteAfterUnDelete',false);
        }
    }
    
}