/**
* @author Incapsulate
* @description Base Helper class to handle the org cache for Template Capsule.
*/ 
public abstract class TriggerBaseHandler 
{                                       
    public abstract void beforeInsert(List<Sobject>newRecordList);
    public abstract void afterInsert(List<Sobject>newRecordList,Map<Id,Sobject>newRecordMap);
    public abstract void beforeUpdate(Map<Id,Sobject>oldRecordMap,Map<Id,Sobject>newRecordMap);
    public abstract void afterUpdate(Map<Id,Sobject>oldRecordMap,Map<Id,Sobject>newRecordMap);
    public abstract void beforeDelete(List<Sobject>oldRecordLis,Map<Id,Sobject>oldRecordMap);
    public abstract void afterDelete(Map<Id,Sobject>oldRecordMap);
    public abstract void afterUndelete(List<Sobject>newRecordLis,Map<Id,Sobject>newRecordMap);
}