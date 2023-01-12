public with sharing class AddressController {

    @AuraEnabled(cacheable=true)
    public static List<Address__c> getAccountAddresses(String accId) {
        return [select id, Name, Address__c.Account__r.Name, main__c, Address_type__c from Address__c WITH SECURITY_ENFORCED];
    }
    @AuraEnabled
    public static string updateAddresses(Object data) {
        List<Address__c> AddressesForUpdate = (List<Address__c>) JSON.deserialize(
            JSON.serialize(data),
            List<Address__c>.class
        );
        try {
            update AddressesForUpdate;
            return 'Success: Addresses updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}