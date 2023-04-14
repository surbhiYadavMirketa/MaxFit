public class AttendeeController {
    public Attendees__c attendee{get;set;}
    public Locations__c location{get;set;}
    public Event_Attendee__c eventattendee{get;set;}

    public AttendeeController() {
        attendee = new Attendees__c();
        location = new Locations__c();
        eventattendee = new Event_Attendee__c();

    }
    public void addRecord(){
        insert location;
        attendee.Address__c = location.Id;
        insert attendee;
        eventattendee.Attendees__c = attendee.Id;
        insert eventattendee;

        attendee = new Attendees__c();
        location = new Locations__c();
        eventattendee = new Event_Attendee__c();
    }
}