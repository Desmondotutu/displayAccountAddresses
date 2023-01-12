/**
* @description       : Updating account's address details when the main billing/shipping address has been updated.
* @author            : desmondwangki@HICLTD.com
* @group             : High Initiative Corporation.
* @last modified on  : 03-01-2023
* @last modified by  : desmondwangki@hicorp.com
**/
trigger MainAddressUpdater on Address__c ( before insert, before update, after update) {
    if (Trigger.isAfter){ 
        if (Trigger.isUpdate) {
            AccountAdressHandler.onUpdateAddresses(Trigger.newMap, Trigger.oldMap);

    }

    }
    
}