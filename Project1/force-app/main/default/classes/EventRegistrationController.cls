public class EventRegistrationController {
    public Event_Organizer__c eorganizer{get;set;}
    public Event__c event{get;set;}
    public Locations__c locations{get;set;}
    
    public EventRegistrationController(){
        Id id = ApexPages.currentPage().getParameters().get('id');
        eorganizer=(id==null) ? new Event_Organizer__c():
        [Select Name,Email__c,Alternative_Email__c,Phone__c,Alternative_Phone__c from Event_Organizer__c where Id=:id];
            
        event=(id==null) ? new Event__c():
        [Select Name__c,Organizer__c,Start_Date_Time__c,End_Date_Time__c from Event__c where Id=:id];
            
       	locations=(id==null) ? new Locations__c():
        [Select Street__c,City__c,State__c from Locations__c where Id=:id];
        
    }
    
    public void addEventOrganizer(){
        try{
            insert locations;
            event.Organizer__c = eorganizer.Id;
            insert eorganizer;
            if(event.Event_Type__c != 'Virtual')
            {
                event.Locations__c = locations.Id;
            }
            insert event;

            eorganizer = new Event_Organizer__c();
            event = new Event__c();
            locations = new Locations__c();
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }

}