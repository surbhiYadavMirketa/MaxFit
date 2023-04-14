@isTest
private class BatchApexEmailTestClass {

    @TestSetup
    static void testBatchApex() {
        List<Event__c> listOfRecords = new List<Event__c>();

        for(Integer i=0;i<200;i++){
            Event__c newEvent = new Event__c(
                Name__c = 'Birthday' + i,
                Event_Type__c = 'Virtual',
                Frequency__c = 'Daily',
                Max_Seats__c = 200,
                Recurring__c = true,
                Live__c = true,
                Start_Date_Time__c = Datetime.now().addMonths(-3),
                End_Date_Time__c = Datetime.now().addMonths(-3).addDays(4)
                
            );
            listOfRecords.add(newEvent);    
        }
        insert listOfRecords;
    }

    @isTest
    static void eventDeleteBatchTestMethod(){
        Test.startTest();
        BatchApexEmail batch1 = new BatchApexEmail();
        Database.executeBatch(batch1);
        Test.stopTest();

        List<Event__c> deletedEventsRecord = [Select Id,Name__c from Event__c];
        System.assertEquals(0, deletedEventsRecord.size(),'All events record which are occur two months before should delete');
    }
}