public with sharing class displayAccountAddresses {
    @AuraEnabled(cacheable=true)
    public static List<Account> displayAccounts(String accId){
        return [select id, Name, (select name, Account__c, Address_Type__c, Main__c 
                from Addresses__r)
                from Account where Id =:accId];
    }
    @AuraEnabled
    public static List<Account> displayAccountAddress(List<String> accList){
        List<Address__c> deleteAddresses = [select name, Account__c from Address__c where Account__c IN :accList];
        List<Address__c> holdAddresstodelete = new List<Address__c>();
        for(Address__c addr :deleteAddresses){
            holdAddresstodelete.add(addr);
        }

        if (holdAddresstodelete.size()>0) {
            try{
                delete holdAddresstodelete;
            } catch(Exception e){
                throw new AuraHandledException('Cannot delete Addresses ' +e.getMessage());
            }
            
        }
        return [select id, Name, (select name, Account__c, Address_Type__c, Main__c 
        from Addresses__r)
        from Account];
   }

}