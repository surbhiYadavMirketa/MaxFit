@isTest
public class eventWebServiceTest {

    @isTest
    static void eventWebServiceTest(){
        List<Event__c> getRecord = new List<Event__c>();
        getRecord.add(new Event__c(Name__c='Surbhi',Start_Date_Time__c=System.now(),Max_Seats__c=500));
        insert getRecord;

        Test.startTest();
        List<Event__c> checkRecord = EventWebServer.getEventRecord();
        Test.stopTest();

        System.assertEquals(1,checkRecord.size());
        
    }
}