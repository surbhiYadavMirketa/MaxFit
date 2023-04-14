public class createProductRecord {
    public static HTTPResponse createProductRecord() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://fakestoreapi.com/products');
        req.setMethod('GET');

        Http http =new Http();
        HTTPResponse res = http.send(req);
        
        if(res.getStatusCode() == 200){
            String response = res.getBody();

            List<Object> productList = (List<Object>)JSON.deserializeUntyped(response);


            //Lists to Insert 
            List<Product2> proList = new List<Product2>();
            List<PricebookEntry> entryList = new List<PricebookEntry>();
            List<PricebookEntry> entryList2 = new List<PricebookEntry>();
            Pricebook2 standardPb = new Pricebook2();
            if(Test.isRunningTest()){
                ID abc = Test.getStandardPricebookId();
                standardPb.Id = abc;
            }
            else{
               standardPb = [select id from Pricebook2 where isStandard = true];

            }
            //Creation of Custom Pricebook of our name
            Pricebook2 pb = new Pricebook2(Name = 'surbhi-pricebook',Description = 'Price Book',IsActive = true);
            insert pb;

            //Standard Pricebook
            

            for(Object product : productList){
                Map<String,Object> productMap = (Map<String,Object>) product;

                String title = (String)JSON.serialize(productMap.get('title'));
                title = title.subString(1,title.length()-1);

                String descript = (String)JSON.serialize(productMap.get('description'));
                descript = descript.subString(1,descript.length()-1);

                Product2 pro = new Product2(
                    ProductCode = (String)JSON.serialize(productMap.get('id')),
                    Name = title,
                    Description = descript

                );
                proList.add(pro);

            }
            insert proList;


            for(integer i=0; i<productList.size();i++){
                Object product = productList.get(i);
                Id productId = proList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;
                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));

                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = standardPb.Id,
                    Product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );
                entryList.add(entry);

                
            }
            insert entryList;


            for(integer i=0;i<productList.size();i++){
                Object product = productList.get(i);
                Id productId = proList.get(i).Id;

                Map<String,Object> productMap = (Map<String,Object>) product;
                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));

                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = pb.Id,
                    Product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );
                entryList2.add(entry);
            }
            insert entryList2;


        }
        return res;





    }
}