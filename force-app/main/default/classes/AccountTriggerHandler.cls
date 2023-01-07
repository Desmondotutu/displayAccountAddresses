/**
 * @description         : Create Account Address Trigger Helper
 * @author              : Dwangki@HIC
 * test class           : AccountAddress_HelperTest
 * @created date        : 28/12/2022
 * @last Modified by    : Dwangki@HIC | 03/01/2023
 */
public with sharing class AccountTriggerHandler {
    public static void createAccountBillingAddress(List<Account> accList){
        Map<Id, Account> mpacc = new Map<Id, Account>();
        List<Address__c> blAddressList = new List<Address__c>();
        for(Account acc: Trigger.new){
            mpacc.put(acc.Id, acc);
        }
        if(!mpacc.isEmpty()){

            for(Account acc: mpacc.values()){
                Address__c addr = new Address__c();

                //Verifying that account has all the values of Billing Address
                if((acc.BillingStreet != Null && acc.BillingCity != Null &&
                    acc.BillingCountry != Null && acc.BillingPostalCode != Null
                    && acc.BillingState != Null) || (acc.ShippingStreet != Null && acc.ShippingCity != Null &&
                    acc.ShippingCountry != Null && acc.ShippingPostalCode != Null
                    && acc.ShippingState != Null)){
                        addr.Name = acc.Name +''+ 'Address';
                        addr.Account__c = acc.id;
                        addr.Address_Type__c = 'Billing Address';
                        addr.Main__c = true;
                        addr.City__c = acc.BillingCity;
                        addr.Street__c = acc.BillingStreet;
                        addr.Country__c = acc.BillingCountry;
                        addr.State_Province__c = acc.BillingState;
                        addr.Zip_Postal_Code__c = acc.BillingPostalCode;
                    
                    blAddressList.add(addr);
                } else if((acc.BillingStreet != Null || acc.BillingCity != Null ||
                acc.BillingCountry != Null || acc.BillingPostalCode != Null
                || acc.BillingState != Null)){
                    addr.Name = acc.Name +''+ 'Address';
                    addr.Account__c = acc.id;
                    addr.Address_Type__c = 'Billing Address';
                    addr.City__c = acc.BillingCity;
                    addr.Street__c = acc.BillingStreet;
                    addr.Country__c = acc.BillingCountry;
                    addr.State_Province__c = acc.BillingState;
                    addr.Zip_Postal_Code__c = acc.BillingPostalCode;
                
                    blAddressList.add(addr);

                    }
                
            }
            // checking not to insert an empty List
            if(!blAddressList.isEmpty()){
                insert blAddressList;
            }
        }
    }
    public static void createAccountShippingAddress(List<Account> accList){
        Map<Id, Account> mpaccs = new Map<Id, Account>();
        List<Address__c> shAddressList = new List<Address__c>();
        for(SObject Account: Trigger.new){
            mpaccs.put(Account.Id, Account);
        }
        if(!mpaccs.isEmpty()){
            for(Account acc: mpaccs.values()){
                Address__c add = new Address__c();

                //Verifying that account has all the values of Shipping Address
                if(acc.ShippingStreet != Null && acc.ShippingCity != Null &&
                    acc.ShippingCountry != Null && acc.ShippingPostalCode != Null
                    && acc.ShippingState != Null){
                        add.Name = acc.Name +''+ 'Address';
                        add.Account__c = acc.id;
                        add.Address_Type__c = 'Shipping Address';
                        add.Main__c = true;
                        add.City__c = acc.ShippingCity;
                        add.Street__c = acc.ShippingStreet;
                        add.Country__c = acc.ShippingCountry;
                        add.State_Province__c = acc.ShippingState;
                        add.Zip_Postal_Code__c = acc.ShippingPostalCode;
                    
                    shAddressList.add(add);
                } else if (acc.ShippingStreet != Null || acc.ShippingCity != Null ||
                acc.ShippingCountry != Null || acc.ShippingPostalCode != Null
                || acc.ShippingState != Null) {

                    add.Name = acc.Name +''+ 'Address';
                    add.Account__c = acc.id;
                    add.Address_Type__c = 'Shipping Address';
                    add.City__c = acc.ShippingCity;
                    add.Street__c = acc.ShippingStreet;
                    add.Country__c = acc.ShippingCountry;
                    add.State_Province__c = acc.ShippingState;
                    add.Zip_Postal_Code__c = acc.ShippingPostalCode;
                
                    shAddressList.add(add);

                    }
                
            }
        }
        // checking not to insert an empty List
        if(!shAddressList.isEmpty()){
            insert shAddressList;
        }
    }
    public static void getAccountAddresses(List<Account> accList){
        List<Address__c> accAddressList = [select id, name, Account__c, Address_Type__c, Main__c 
                                            from Address__c where Account__c IN :accList];
            for(Address__c addr :accAddressList){
                if(addr.Main__c == true && accAddressList.size()>1){
                     addr.Main__c = false;
            }   
            
        }
    }

}