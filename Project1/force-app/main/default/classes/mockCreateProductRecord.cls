@isTest
global class mockCreateProductRecord implements HttpCalloutMock{
    global HTTPResponse respond (HTTPRequest request) {
        HTTPResponse response = new HTTPResponse();
        
        response.setHeader('Content-Type','application/json');
        response.setBody('[{"id":1,"Name":"Surbhi","description":"Book","price":546.98}]');
        response.setStatusCode(200);
        return response;
        


    }
}