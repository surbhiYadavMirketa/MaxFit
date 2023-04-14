public class SpeakerRegistrationController {
    public Speaker__c speaker{get;set;}
    public Event_Speaker__c eventSpeaker{get;set;}


    public SpeakerRegistrationController() {
        //Id id = ApexPages.currentPage().getParameters.get('id');

        speaker=new Speaker__c();
        //[Select Id,Name,Email__c,Phone__c,Company__c from Speaker__c where Id =: id];

        eventSpeaker=new Event_Speaker__c();
        //[Select Id,Name,Event__c,Speaker__c from Event_Speaker__c where Id =: id];

    }
        public void addDetails(){
            try {
                insert speaker;
                eventSpeaker.Speaker__c = speaker.Id;
                insert eventSpeaker;

                speaker = new Speaker__c();
                eventSpeaker = new Event_Speaker__c();
            } catch (Exception e) {
                System.debug(e.getMessage());
            }
        }
}