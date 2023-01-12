public with sharing class AccountDemoController {
    public AccountDemoController() {

    }

    @AuraEnabled (cacheable=true)
    public static List<Account> displayAccntRecords(){
        List<Account> accList=[SELECT Id,Name,Phone,Industry FROM Account LIMIT 5];
        return accList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> displayConRecords(String accId){
        
            List<Contact> conlist=new List<Contact>(); 
        for(Contact con:[SELECT Id,Firstname,LastName,Email,Phone,AccountId FROM Contact WHERE AccountId=:accId]){
                conlist.add(con);
        }
        return conlist;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData() {
        return [SELECT Id,Name,(Select Id,Name,Email,Phone from Contacts) from Account];
    }
    @AuraEnabled(cacheable=true)
    public static List<Codes_And_Tags__c> getCodesAndTags() {
       return [select name, Parent_Code__c, allocation__c, RecordTypeId from Codes_And_Tags__c];
    }
    

}