@isTest
public with sharing class testCreateProductRecord {
    @isTest
    static void testCreateProductRecord() {
        Test.setMock(HttpCalloutMock.class, new mockCreateProductRecord());
        HTTPResponse response = createProductRecord.createProductRecord();
        Product2 product = [select Id,Name from Product2 where Name='Surbhi'];
        System.assertEquals(product.Name,'Surbhi');

        Pricebook2 pricebook = [select Id,Name from Pricebook2 where Name='surbhi-pricebook'];
        System.assertEquals(pricebook.Name,'surbhi-pricebook');

        List<PricebookEntry> entryList2 = [select Id from PricebookEntry where Pricebook2Id=:pricebook.Id AND Product2Id=:product.Id];
        System.assertEquals(1,entryList2.size());


    }
}