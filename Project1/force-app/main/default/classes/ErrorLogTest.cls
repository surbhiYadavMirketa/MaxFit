@isTest
private class ErrorLogTest {

    @isTest
    static void ErrorLogTest(){
        String logDetails = 'There is an Error';
        String processName = 'QA';

        Test.startTest();
        ErrorLog.insertErrorLog(logDetails, processName);
        Test.stopTest();

        //Creating a new record list of Error Log 
        List<Error_Log__c> newRecord = [select Id,Log_Date_Time__c,Log_Details__c,Process_Name__c from Error_Log__c where Process_Name__c=:processName];

        //Assertive 
        System.assertEquals(1,newRecord.size());
        System.assertEquals(Datetime.now(),newRecord[0].Log_Date_Time__c);
        System.assertEquals(logDetails,newRecord[0].Log_Details__c);
        System.assertEquals(processName,newRecord[0].Process_Name__c);

    }
}