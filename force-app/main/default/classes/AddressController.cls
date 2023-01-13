public with sharing class AddressController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountAddresses() {
        return [select Name, (select Address_type__c, main__c from Addresses__r) from Account WITH SECURITY_ENFORCED];
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