trigger EventSpeakerTrigger on Event_Speaker__c(before insert) {
    try {
        DuplicateSpeaker.insertEventSpeaker(trigger.new);
    } catch (DMLException e) {
       System.debug(e.getMessage());
        
    }

}