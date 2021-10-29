/**
* @author Incapsulate
* @description Helper class to check if the trigger is enabled or disabled and add values to cache
*/ 
global  class TriggerBaseHelper 
{
    public static Boolean isTriggerActive(String objectName)
    {
        List<Trigger_Handler__mdt> trigerMdtList = new List<Trigger_Handler__mdt>();
        Boolean isActive = false;
        trigerMdtList = [ SELECT Id, DeveloperName, MasterLabel, Enabled__c FROM Trigger_Handler__mdt  WHERE MasterLabel =:objectName];
        if(trigerMdtList.size()>0)
        {
            isActive = trigerMdtList[0].Enabled__c;  
        }
        return isActive;
    }
    public static Map<String,String> handlerMap = new Map<String,String>
    {
        'Account' => 'AccountTriggerHandler'
    };

    public static Map<String,Boolean> features = new Map<String,Boolean>();

    /**
    * @description Method that will check the cache availability
    * @param triggerObject current sobject on which the Trigger is fired.
    * @return Map that holds Sobject and BaseIFF_Handler as a key value pair.
    */ 
    public static TriggerBaseHandler getActiveHandler(String triggerObject)
    {
        system.debug('Trigger Object'+triggerObject);
        if(getTriggerEnabled(String.valueOf(triggerObject)))
        {
            system.debug('Trigger Enabled'+triggerObject);
            System.Type t = System.Type.forName(handlerMap.get(triggerObject));
            return (TriggerBaseHandler)t.newInstance();
        }
        return null;
    }

    /**
    * @description Mehtod that will pass values to getFeatureEnabled to check if the trigger is active
    * @param triggerObject current sobject on which the Trigger is fired.
    * @return Boolean value that is returned from getFeatureEnabled method.
    */
    global static Boolean getTriggerEnabled (String triggerObject) 
    {
        system.debug('Trigger Object'+triggerObject);
        return getFeatureEnabled(triggerObject);
    }

    /**
    * @description Mehtod that will check if the trigger is active or inactive.
    * @param triggerObject current sobject on which the Trigger is fired. 
    * @return Boolean that is returned from the custom metadata INSCAP_Trigger_Handler__mdt.
    */    
    global static Boolean getFeatureEnabled(String triggerObject) 
    {
        if(!features.containsKey(triggerObject))
        {
            features = new Map<String, Boolean>();
            for(Trigger_Handler__mdt feature :[SELECT Id, DeveloperName, MasterLabel, Enabled__c FROM Trigger_Handler__mdt])//Should add where clause
            {
                features.put(feature.MasterLabel, feature.Enabled__c);
            }
        }
        system.debug('Trigger features'+features);
        Boolean feature = features.get(triggerObject);
        if (feature != null)
        {
            return feature;
        }
        return false;
    }
    
    /**
    * @description Method that will check the enable status. Default is False
    * @param devName label value of metadata
    * @return Boolean return enabel chackbox value of metadata record. Default is false.
    */ 
    public static Boolean getTriggerStatus(String devName)
    {   
        Trigger_Handler__mdt  triggerHandler = new Trigger_Handler__mdt();
        if(! String.isEmpty(devName))
        {
            triggerHandler = [SELECT Id, DeveloperName, MasterLabel, Enabled__c FROM Trigger_Handler__mdt WHERE DeveloperName =: devName LIMIT 1];            
        }   
        if(triggerHandler != null)
        {
            return triggerHandler.Enabled__c;
        }
        else
        {
            return false;
        }
    }

   
}