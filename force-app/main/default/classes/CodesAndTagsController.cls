public with sharing class CodesAndTagsController {
    @AuraEnabled(cacheable=true)
    public static list<Account> getCodesAndTagsForAccounts(){
        return [SELECT Name, (
                SELECT Id, Name, Parent_Code__r.Name FROM Codes_And_Tags__r) 
                FROM Account];
    }
}