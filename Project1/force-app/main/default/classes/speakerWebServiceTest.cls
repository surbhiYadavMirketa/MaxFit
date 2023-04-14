@isTest
public class speakerWebServiceTest {

    @isTest
    static void speakerWebServiceTest() {
        //List<Speaker__c> sp = new Speaker();
        Test.startTest();
        RestContext.response = new RestResponse();
        String spkRecord1 = speakerWebService.doPost('TestSpeaker3','testSpeaker3@gmail.com','9883763','Infyos');
        String spkRecord2 = speakerWebService.doPost('TestSpeaker4','testSpeaker3@gmail.com','9883763','Infyos');
        List <Speaker__c> speaker = [Select Id, Name From Speaker__c Where Name= 'TestSpeaker3'];
        System.assertEquals(1,speaker.size());
        System.assertEquals(400,RestContext.response.statusCode);
        Test.stopTest();

    }
}