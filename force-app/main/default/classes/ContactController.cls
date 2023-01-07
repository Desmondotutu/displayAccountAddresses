public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Address__c> getaddresses(String accId) {
        return [
            SELECT Account__c, Id, Name, Address_Type__c, Main__c
            FROM Address__c 
            WHERE Account__c =:accId 
            WITH SECURITY_ENFORCED
        ];
    }

    @AuraEnabled
    public static void updateAddresses(List<Address__c> addressesForUpdate) {
        // Make sure we can update the database before trying to update
        if (!Schema.sObjectType.Address__c.isUpdateable()) {
            throw new SecurityException(
                'Insufficient permissions to update contacts'
            );
        }
        update addressesForUpdate;
    }
    @AuraEnabled
    public static void deladdrRecords(List<String> selectRecords){
        List<Address__c> returnlist=new List<Address__c>();
        for(Address__c addr:[select Id,Name from Address__c where Id in:selectRecords]){
            returnlist.add(addr);

        }
        if(returnlist.size()>0){
            try{
                delete returnlist;
            }
            catch(Exception  e){
           throw new AuraHandledException(e.getMessage());
            }
        }
    }
    
}