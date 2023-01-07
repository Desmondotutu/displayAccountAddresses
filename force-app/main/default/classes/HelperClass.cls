public class HelperClass {
    Public static void accountAddressUpdate(List<Account> accList) {
        set<id> AccountIds = new set<id>();
        map<id, Account> oldAccounts = new map<id, Account>([SELECT Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingStreet, BillingState, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingStreet, ShippingState, (SELECT Id, Address_Type__c FROM Addresses__r WHERE Main__c = TRUE) FROM Account WHERE Id IN :Trigger.old]);
        List<Address__c> addressToUpdate = new List<Address__c>(); 
        for(Account acc : accList){
            AccountIds.add(acc.Id);
        }
        
        for(Account a : [SELECT Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingStreet, BillingState, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingStreet, ShippingState, (SELECT Id, Address_Type__c FROM Addresses__r WHERE Main__c = TRUE) FROM Account WHERE Id IN :AccountIds]){
            
            Account oldAccount = oldAccounts.get(a.Id);
            
            if ( (a.BillingState != oldAccount.BillingState && a.BillingState != null ) || a.BillingCountry!=oldAccount.BillingCountry || a.BillingCity != oldAccount.BillingCity || a.BillingStreet != oldAccount.BillingStreet ||
                a.ShippingState != oldAccount.ShippingState || a.ShippingCity != oldAccount.ShippingCity || a.ShippingCountry != oldAccount.ShippingCountry) {
                    if (!a.Addresses__r.isEmpty()) {
                        for (Address__c addr : a.Addresses__r) {
                            if (addr.Address_Type__c == 'Billing Address') {
                                addr.City__c = a.BillingCity;
                                addr.Country__c = a.BillingCountry;
                                addr.Zip_Postal_Code__c = a.BillingPostalCode;
                                addr.Street__c = a.BillingStreet;
                                addr.State_Province__c = a.BillingState;
                                addressToUpdate.add(addr);
                            } 
                            else if (addr.Address_Type__c == 'Shipping Address') {
                                addr.City__c = a.ShippingCity;
                                addr.Country__c = a.ShippingCountry;
                                addr.Zip_Postal_Code__c = a.ShippingPostalCode;
                                addr.Street__c = a.ShippingStreet;
                                addr.State_Province__c = a.ShippingState;
                                addressToUpdate.add(addr);
                            }
                        }    
                    }
                }
        }
        if (!addressToUpdate.isEmpty()) {
            update addressToUpdate;   
        }
        
    }
    

}