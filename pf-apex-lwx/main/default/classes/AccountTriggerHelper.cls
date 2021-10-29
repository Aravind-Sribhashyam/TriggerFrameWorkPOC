/**
 * @author Incapsulate
 * @description Trigger Helper  Class for Intake object to handle the sequence of Sobject Creation , Sobject child parent
 * association and Pushing the data into Entities Objects for the respective sObjects created based on the DML events.
 */
 public without sharing class AccountTriggerHelper 
{
    public static void createContacct(Map<String,String> contactMap)
    {
        Contact contactObject = new Contact(
            AccountId = contactMap.get('accountId'),
            LastName = contactMap.get('lastName'),
            Department = contactMap.get('department'));
        insert contactObject; 
    }
    
    
    public static void updateCaseOrigin(List<Account> accountList)
    {
        List<Case> caseList = [SELECT Id, CaseNumber, Origin FROM Case WHERE AccountId =:accountList[0].Id ];
        for(Case c : caseList){
            c.Origin = 'Email';
        }
        update caseList;
    }
    
}