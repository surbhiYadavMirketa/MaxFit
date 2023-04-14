@RestResource(urlMapping='/Event/*')

global with sharing class EventWebServer {
    @httpGet
    global static List <Event__c> getEventRecord(){

        List<Event__c> details = [Select Id,Name__c,Start_Date_Time__c,Max_Seats__c,Organizer__r.Name,Organizer__r.Email__c from Event__c];
        return details;

    }
}