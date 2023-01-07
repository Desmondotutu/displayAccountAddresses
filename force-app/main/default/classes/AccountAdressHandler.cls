/**
* @description       : Updating account's address details when the main billing/shipping address has been updated.
* @author            : desmondwangki@HICLTD.com
* @group             : High Initiative Corporation.
* @last modified on  : 03-01-2023
* @last modified by  : desmondwangki@hicorp.com
**/
public with sharing class AccountAdressHandler {
    public static void onUpdateAddresses(map<id,Address__c> newAddress, map<id,Address__c> oldAddress){
        list<account> updateAccFromChildMain = new list<account>();
        set<id> accIdSet = new set<id>();
        
        for(Address__c ad:[SELECT Id , Account__c ,Main__c FROM Address__c where id =:newAddress.keySet() and Main__c =true ]){
            accIdSet .add(ad.Account__c);
        }
        
        map<id,Account> accData = new map<id,account>([SELECT Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingStreet, 
                                                       BillingState, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingStreet, 
                                                       ShippingState FROM Account WHERE Id IN :accIdSet]);
        
        for(Address__c ad: newAddress.values()){
            if(ad.Main__c == true){
                Address__c oldAdd =  oldAddress.get(ad.Id);           
                if(ad.Address_Type__c == 'Billing Address'){
                    if(ad.Street__c != oldAdd.Street__c && ad.Street__c != null && ad.Street__c != accData.get(ad.Account__c).BillingStreet ||
                      ad.Country__c != oldAdd.Street__c && ad.Street__c != null && ad.Country__c != accData.get(ad.Account__c).BillingCountry ||
                      ad.Zip_Postal_Code__c != oldAdd.Street__c && ad.Street__c != null && ad.Zip_Postal_Code__c != accData.get(ad.Account__c).BillingPostalCode ||
                      ad.City__c != oldAdd.Street__c && ad.Street__c != null && ad.City__c != accData.get(ad.Account__c).BillingCity ||
                      ad.State_Province__c != oldAdd.Street__c && ad.Street__c != null && ad.State_Province__c != accData.get(ad.Account__c).BillingState){
                        		accData.get(ad.Account__c).BillingCity = ad.City__c;
                                accData.get(ad.Account__c).BillingCountry = ad.Country__c;
                                accData.get(ad.Account__c).BillingPostalCode =ad.Zip_Postal_Code__c;
                                accData.get(ad.Account__c).BillingStreet = ad.Street__c;
                                accData.get(ad.Account__c).BillingState = ad.State_Province__c;
                                updateAccFromChildMain.add(accData.get(ad.Account__c));                      
                    }
                }

                else if(ad.Address_Type__c == 'Shipping Address'){
                    if(ad.Street__c != oldAdd.Street__c && ad.Street__c != null && ad.Street__c != accData.get(ad.Account__c).ShippingStreet ||
                      ad.Country__c != oldAdd.Street__c && ad.Street__c != null && ad.Country__c != accData.get(ad.Account__c).ShippingCountry ||
                      ad.Zip_Postal_Code__c != oldAdd.Street__c && ad.Street__c != null && ad.Zip_Postal_Code__c != accData.get(ad.Account__c).ShippingPostalCode ||
                      ad.City__c != oldAdd.Street__c && ad.Street__c != null && ad.City__c != accData.get(ad.Account__c).ShippingCity ||
                      ad.State_Province__c != oldAdd.Street__c && ad.Street__c != null && ad.State_Province__c != accData.get(ad.Account__c).ShippingState){
                                accData.get(ad.Account__c).ShippingCity = ad.City__c;
                                accData.get(ad.Account__c).ShippingCountry = ad.Country__c;
                                accData.get(ad.Account__c).ShippingPostalCode =ad.Zip_Postal_Code__c;
                                accData.get(ad.Account__c).ShippingStreet = ad.Street__c;
                                accData.get(ad.Account__c).ShippingState = ad.State_Province__c;
                                updateAccFromChildMain.add(accData.get(ad.Account__c)); 
                    }
                }
                
            }
        }
        
        if(!updateAccFromChildMain.isEmpty()){
            update updateAccFromChildMain;
        }
        
    }
    
}