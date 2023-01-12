public with sharing class CodesAndTagsController {
    public static List<Codes_And_Tags__c> getCodesAndTags() {
        List<Codes_And_Tags__c> catList = [select name, Parent_Code__c, allocation__c, RecordTypeId from Codes_And_Tags__c];
        return catList;

    }
}