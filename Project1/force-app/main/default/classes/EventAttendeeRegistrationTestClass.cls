@isTest
private class EventAttendeeRegistrationTestClass {

    @isTest
    static void insertData(){
        Event_Organizer__c eo = new Event_Organizer__c(
            Name='Surbhi',
            Email__c='surbhi.yadav@mirketa.com',
            Phone__c='7874667845'
        );
        insert eo;

        Event__c ec = new Event__c(
            Name__c='Cultural Fest',
            Start_Date_Time__c=System.now(),
            End_Date_Time__c = System.now().addDays(3),
            Event_Type__c = 'Virtual',
            Frequency__c = 'Weekly',
            Live__c = true,
            Recurring__c = true,
            Max_Seats__c = 200

        );
        insert ec;

        Attendees__c ac = new Attendees__c(
            Name = 'Sanidhya',
            Email__c = 'surbhiyadav1511@gmail.com',
            Phone__c = '548484654'
        );
        insert ac;

        Event_Attendee__c evAtt = new Event_Attendee__c(
            Attendees__c = ac.Id,
            Event__c = ec.Id
        );
        insert evAtt;

        List<Event_Attendee__c> eat = [select Id,Event__c,Attendees__c from Event_Attendee__c where Id=:evAtt.Id];

        Test.startTest();
        EventAttendeeRegistration.eventAttendeeRegistration(eat);
        Test.stopTest();

        Integer invoc = Limits.getEmailInvocations(); //where limits ---> class and getEmailInvocation is the static method
        System.assertEquals(1,invoc,'An email has been sent');


    }
}