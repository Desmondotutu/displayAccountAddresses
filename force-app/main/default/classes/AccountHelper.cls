public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountAddresses(String accId){
        return [select id, Name, (select name, Account__c, Address_Type__c, Main__c 
                from Addresses__r)
                from Account where Id =:accId];
    }
}