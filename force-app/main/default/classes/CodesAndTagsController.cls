public with sharing class CodesAndTagsController {
    @AuraEnabled(cacheable=true)
    public static List<Codes_And_Tags__c> getCodesAndTags() {
       return [select id, name, Codes_And_Tags__c.Parent_Code__r.Name, allocation__c from Codes_And_Tags__c];
    }
}