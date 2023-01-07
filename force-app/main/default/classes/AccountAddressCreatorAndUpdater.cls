/**
* @description       : This Class Handles the logic of AccountAddressCreatorAndUpdater trigger on Account
* @author            : desmondwangki@HICLTD.com
* @group             : High Initiative Corporation.
* @last modified on  : 03-01-2023
* @last modified by  : desmondwangki@hicorp.com
**/
public with sharing class AccountAddressCreatorAndUpdater {
    //This method automatically create new Address records upon creation of an account
    public static void createAccount(List<Account> accList) { 
            set<id> AccountIds = new set<id>();
            List<Address__c> newAddresses = new List<Address__c>(); 
            
            for(Account acc : accList){
                AccountIds.add(acc.Id);
            }
            
            for(Account acc : [SELECT Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingStreet, BillingState, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingStreet, ShippingState FROM Account WHERE Id IN :AccountIds]){
                if(acc.BillingCity != null && acc.BillingCountry != null && acc.BillingPostalCode != null && acc.BillingState != null && acc.BillingStreet != null){
                    Address__c billingaddress = 
                        new Address__c(
                            Name = acc.Name+' Billing Address', Main__c = TRUE, Account__c = acc.Id, Address_Type__c = 'Billing Address', City__c = acc.BillingCity, Country__c = acc.BillingCountry, State_Province__c = acc.BillingState, Street__c = acc.BillingStreet, Zip_Postal_Code__c = acc.BillingPostalCode);
                    newAddresses.add(billingaddress);    
                    
                } else if (!String.isBlank(acc.BillingCity) || !String.isBlank(acc.BillingCountry) || !String.isBlank(acc.BillingPostalCode) || !String.isBlank(acc.BillingState) || !String.isBlank(acc.BillingStreet)) {
                    Address__c billingaddress =  
                       new Address__c(
                            Name = acc.Name+' Billing Address', Account__c = acc.Id, Address_Type__c = 'Billing Address', City__c = acc.BillingCity, Country__c = acc.BillingCountry, State_Province__c = acc.BillingState, Street__c = acc.BillingStreet, Zip_Postal_Code__c = acc.BillingPostalCode);
                    newAddresses.add(billingaddress);
                }
                
                if (!String.isBlank(acc.ShippingCity) && !String.isBlank(acc.ShippingCountry) && !String.isBlank(acc.ShippingPostalCode) && !String.isBlank(acc.ShippingState) && !String.isBlank(acc.ShippingStreet)) {
                    Address__c shippingaddress = 
                        new Address__c(
                            Name = acc.Name+' Shipping Address', Main__c = TRUE, Account__c = acc.Id, Address_Type__c = 'Shipping Address', City__c = acc.ShippingCity, Country__c = acc.ShippingCountry, State_Province__c = acc.ShippingState, Street__c = acc.ShippingStreet, Zip_Postal_Code__c = acc.ShippingPostalCode
                        );
                    newAddresses.add(shippingaddress);

                } else if (!String.isBlank(acc.ShippingCity) || !String.isBlank(acc.ShippingCountry) || !String.isBlank(acc.ShippingPostalCode) || !String.isBlank(acc.ShippingState) || !String.isBlank(acc.ShippingStreet)) {
                    Address__c shippingaddress = 
                        new Address__c(
                            Name = acc.Name+' Shipping Address', Account__c = acc.Id, Address_Type__c = 'Shipping Address', City__c = acc.ShippingCity, Country__c = acc.ShippingCountry, State_Province__c = acc.ShippingState, Street__c = acc.ShippingStreet, Zip_Postal_Code__c = acc.ShippingPostalCode
                        );
                    newAddresses.add(shippingaddress);
                }
            }
            
            if (!newAddresses.isEmpty()) {
                insert newAddresses;   
            }
        }
    public static void accountAddressUpdate(List<Account> accList,map<id,account> oldAccounts) {
        set<id> AccountIds = new set<id>();
        
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