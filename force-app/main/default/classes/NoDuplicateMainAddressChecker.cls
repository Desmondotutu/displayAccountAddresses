/**
* @description       : This Class Handles No Duplicate Main Address on Account Main Address
* @author            : desmondwangki@HICLTD.com
* @group             : High Initiative Corporation.
* @last modified on  : 03-01-2023
* @last modified by  : desmondwangki@hicorp.com
**/
public with Sharing class NoDuplicateMainAddressChecker {
    public static void preventDuplicateMainAddress(List<Address__c> addrList, map<id,Address__c> oldAddresses){
 set<id> addrIds = new set<id>();
        
        List<Address__c> addressToUpdate = new List<Address__c>(); 
        for(Address__c addr : addrList){
            addrIds.add(addr.Id);
        }
        
        for(Address__c addr : [SELECT Id, Address_Type__c, Main__c FROM Address__c WHERE Id IN:addrIds]){
            
            Address__C oldAddress = oldAddresses.get(addr.Id);
            
            if(addr.Main__c == true && addr.Main__c == oldAddress.Main__c && oldAddress.Main__c == true ){
                                oldAddress.Main__c = false;
                                addressToUpdate.add(addr);
            }
        }
        if(!addressToUpdate.isEmpty()){
            update addressToUpdate;
        }
    }
        }