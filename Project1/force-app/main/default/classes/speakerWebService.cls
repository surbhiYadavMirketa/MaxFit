@RestResource(urlMapping='/Speaker/*')

global with sharing class speakerWebService {
    
    @HttpPost
    global static String doPost(String name, String email, String phone, String company){

        Speaker__c sp = new Speaker__c();
        sp.Name = name;
        sp.Email__c = email;
        sp.Phone__c = phone;
        sp.Company__c = company;

        //insert sp;
        //return sp.id;

        try {
            RestResponse res = RestContext.response;
            res.statusCode = 200;
            insert sp;
            return 'Success';

        } catch (Exception e) {
            RestResponse res = RestContext.response;
            res.statusCode = 400;
            return 'Failed';
            
        }
        
    }
}