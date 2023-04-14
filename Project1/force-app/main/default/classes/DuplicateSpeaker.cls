public class DuplicateSpeaker {
    public static void insertEventSpeaker(List<Event_Speaker__c> lst) {
        List<Id> speakerId = new List<Id>();
        Map<Id,DateTime> request_booking = new Map<Id,DateTime>(); //For event Id and Date Time
        for(Event_Speaker__c es:lst){
            request_booking.put(es.Event__c,null);
            speakerId.add(es.Speaker__c);
        }
        List<Event__c> relatedEvents = [select Id,Start_Date_Time__c,End_Date_Time__c from Event__c where Id in:request_booking.keySet()];
        for(Event__c related_events : relatedEvents){
            request_booking.put(related_events.Id, related_events.Start_Date_Time__c);
        }

        List<Event_Speaker__c> relatedspeaker = [select Id,Speaker__c,Event__c,Event__r.Start_Date_Time__c,Event__r.End_Date_Time__c from Event_Speaker__c where Speaker__c in:speakerId];
        for(Event_Speaker__c es:lst){
            DateTime bookingtime = request_booking.get(es.Event__c);
            for(Event_Speaker__c speaker : relatedspeaker){
                if(speaker.Speaker__c==es.Speaker__c && speaker.Event__r.Start_Date_Time__c<=bookingtime && speaker.Event__r.End_Date_Time__c >= bookingtime){
                    es.addError('Duplicate Booking Found!!!!');
                }

            }
        }

    }
}