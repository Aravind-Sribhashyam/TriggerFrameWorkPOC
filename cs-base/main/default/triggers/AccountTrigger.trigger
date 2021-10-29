/**
* @author Incapsulate
* @description Trigger on Response.
* @param need to pass object name and handler*/
trigger AccountTrigger on Account (before insert,after insert,before update,after update,after delete ,before delete) 
{
    TriggerDispatcher.run('Account');
}