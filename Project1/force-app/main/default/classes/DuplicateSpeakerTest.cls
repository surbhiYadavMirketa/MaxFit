@isTest
private class DuplicateSpeakerTest {
    @isTest
    static void duplicateSpeakerRecordTest() {
        Event__c event1 = new Event__c(
            Name__c = 'Cultural Fest',
            Start_Date_Time__c = System.now(),
            End_Date_Time__c = System.now().addDays(3),
            Event_Type__c = 'Virtual',
            Frequency__c = 'Daily',
            Live__c = true,
            Recurring__c = true,
            Max_Seats__c = 200
        );
        insert event1;

        Event__c event2 = new Event__c(
            Name__c = 'Night Fest',
            Start_Date_Time__c= System.now(),
            End_Date_Time__c = System.now().addDays(3),
            Event_Type__c = 'Virtual',
            Frequency__c = 'Weekly',
            Live__c = true,
            Recurring__c = true,
            Max_Seats__c = 100

        );
        insert event2;

        Speaker__c speaker = new Speaker__c(
            Name = 'Richa'
        );
        insert speaker;

        Test.startTest();
        try {
            Event_Speaker__c es1 = new Event_Speaker__c(
                Event__c=event1.Id,
                Speaker__c = speaker.Id
            );
            insert es1;

            Event_Speaker__c es2 = new Event_Speaker__c(
                Event__c=event2.Id,
                Speaker__c=speaker.Id
            );
            insert es2;

            List<Event_Speaker__c> lst1 = [select Id,Event__c,Speaker__c from Event_Speaker__c where id =: es1.Id];
            DuplicateSpeaker.insertEventSpeaker(lst1);

            List<Event_Speaker__c> lst2 = [select Id,Event__c,Speaker__c from Event_Speaker__c where id =: es2.Id];
            DuplicateSpeaker.insertEventSpeaker(lst2);

        } catch (Exception e) {
            Boolean checkError = e.getMessage().contains('Duplicate Booking Found!!!!') ? true:false;
            System.assertEquals(checkError,true);
        }

        Test.stopTest();

    }
}