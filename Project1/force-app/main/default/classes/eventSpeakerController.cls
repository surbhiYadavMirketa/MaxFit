public class eventSpeakerController{
    public String MstrId{get;set;}
    public Event__c event{get;set;}
    public List<Event_Speaker__c> eventspeaker{get;set;}

    public eventSpeakerController(){
        MstrId = ApexPages.currentPage().getParameters().get('id');
        if(MstrId != null){
        event = [select Id,Name__c,Organizer__r.Name,Locations__r.Name,Start_Date_Time__c from Event__c where id=:MstrId LIMIT 1];
        eventspeaker = [select Id,Event__r.Name__c,Speaker__r.Name,Speaker__r.Profile_URL__c,Speaker__r.About_Me__c from Event_Speaker__c WHERE Event__c = :MstrId];
        }
    }

        public PageReference saveAsAttendee(){
            return new PageReference('/apex/AttendeePage?param1='+ MstrId).setRedirect(true);

        }

        public PageReference saveAsSpeaker(){
            return new PageReference('/apex/SpeakerRegistration?param1='+ MstrId).setRedirect(true);
        }
    
}