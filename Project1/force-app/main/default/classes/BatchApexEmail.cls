public class BatchApexEmail implements Database.Batchable<Sobject> {
    public Database.QueryLocator start(Database.BatchableContext context){
        Date twoMonthsAgo = Date.today().addMonths(-2);
        return Database.getQueryLocator([Select Id from Event__c where End_Date_Time__c < :twoMonthsAgo AND Live__c = true]);
    }
    public void execute(Database.BatchableContext context,List<Event__c> events){
        delete events;
    }
    public void finish(Database.BatchableContext context){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :context.getJobId()];
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String body = 'The event Delete batch has finished processing.\n\n' + 'Number of records processed: ' + job.JobItemsProcessed;
        email.setSubject('Event Delete Batch Execution Complete');
        email.setPlainTextBody(body);
        email.setToAddresses(new List<String>{'surbhi.yadav@mirketa.com'});
        emails.add(email);
        Messaging.sendEmail(emails);
    }
        

}