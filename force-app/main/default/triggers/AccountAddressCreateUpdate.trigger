/**
* @description       : This trigger create account addresses and updating of the main billing or shipping address when an account is updated.
* @author            : desmondwangki@HICLTD.com
* @group             : High Initiative Corporation.
* @last modified on  : 03-01-2023
* @last modified by  : desmondwangki@hicorp.com
**/

trigger AccountAddressCreateUpdate on Account (after insert, after update) {
    //Initializing our apex trigger custom metadata switcher...      
        if (Trigger.isAfter){
            if (Trigger.isInsert){  
                AccountAddressCreatorAndUpdater.createAccount(Trigger.new);
            }
            if (Trigger.isUpdate){
            AccountAddressCreatorAndUpdater.accountAddressUpdate(trigger.new, trigger.oldmap);
}
}
}