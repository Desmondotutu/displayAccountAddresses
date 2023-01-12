@isTest
public class AccountAddressCreatorAndUpdaterTest{
    @isTest
    public static void createAccAndAddressTestForBilling(){
        // create test Account records
        List<Account> accList = new List<Account>([SELECT Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingStreet, BillingState, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingStreet, ShippingState FROM Account WHERE Id IN :Trigger.new]);
        set<id> accId = new Set<id>();
        for(integer i=0; i<200; i++){
            Account acc = new Account();
            if(acc.BillingCity != null && acc.BillingCountry != null && acc.BillingPostalCode != null && acc.BillingState != null && acc.BillingStreet != null){
                acc.Name = 'Test Account' +i;
                acc.BillingCity = 'Test City' +i;
                acc.BillingCountry = 'Test Country' +i;
                acc.BillingPostalCode = 'TPC' +i;
                acc.BillingState = 'Test State' +i;
                acc.BillingStreet = 'Test Street' +i;
                accList.add(acc);
            }
              else if(!String.isBlank(acc.BillingCity) || !String.isBlank(acc.BillingCountry) || !String.isBlank(acc.BillingPostalCode) || !String.isBlank(acc.BillingState) || 
            !String.isBlank(acc.BillingStreet)){
                acc.Name = 'Test Account' +i;
                acc.BillingCity = 'Test City' +i;
                acc.BillingCountry = 'Test Country' +i;
                acc.BillingState = 'Test State' +i;
                acc.BillingStreet = 'Test Street' +i;
                accList.add(acc);
            }
            else if(acc.ShippingCity != null && acc.ShippingCountry != null && acc.ShippingPostalCode != null && acc.ShippingState != null && acc.ShippingStreet != null){
                acc.Name = 'Test Account' +i;
                acc.ShippingCity = 'Test City' +i;
                acc.ShippingCountry = 'Test Country' +i;
                acc.ShippingPostalCode = 'TPC' +i;
                acc.ShippingState = 'Test State' +i;
                acc.ShippingStreet = 'Test Street' +i;
                accList.add(acc);  
            }
            else if(!String.isBlank(acc.ShippingCity) || !String.isBlank(acc.ShippingCountry) || !String.isBlank(acc.ShippingPostalCode) || !String.isBlank(acc.ShippingState) || !String.isBlank(acc.ShippingStreet)){
                acc.Name = 'Test Account' +i;
                acc.ShippingCity = 'Test City' +i;
                acc.ShippingCountry = 'Test Country' +i;
                acc.ShippingPostalCode = 'TPC' +i;
                acc.ShippingState = 'Test State' +i;
                accList.add(acc);
        }
        accId.add(acc.id);
        //insert test address records
        Test.startTest();
          if(!accList.isEmpty()){
        insert accList;
        }
        Test.stopTest();
        
        List<Address__c> addrListInserted = [select id, Name from Address__c where Account__c IN:accId];
        
        system.assertEquals(addrListInserted.size(), accList.size());
   	}
    }
@isTest
private static void TestUpdateAccountAddress(){
        set<id> accIds = new Set<id>();
        List<Address__c> addrList = new List<Address__c>();
        List<Account> accList = new List<Account>();
        for(integer i=0; i<200; i++){
            Account Billing = new Account(name = 'Test Account'+i, BillingStreet = 'hey'+i, BillingCity = 'you'+i, BillingCountry = 'come'+i, BillingState = 'here'+i, BillingPostalCode = 'and'+i);
            accList.add(Billing);
            accIds.add(Billing.id);
            Account Shipping = new Account(name = 'Test Account'+i, ShippingStreet = 'hey'+i, ShippingCity = 'you'+i, ShippingCountry = 'come'+i, ShippingState = 'here'+i, ShippingPostalCode = 'and'+i);
            accList.add(Shipping);
            accIds.add(Shipping.id);
            }
    	if(!accList.isEmpty()){
            insert accList;
    	}
        List<Account> accToUpdate = new List<Account>();
        for(Account acc:[SELECT Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingStreet, BillingState, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingStreet, ShippingState FROM Account WHERE Id IN :accIds]){
            if(acc.BillingAddress != null){
            acc.BillingCity = 'Test update';
            acc.BillingCountry = 'Test update';
            acc.BillingPostalCode = 'TPC1';
            acc.BillingState = 'Test update';
            acc.BillingStreet = 'Test update';
                accToUpdate.add(acc);
            }

            else if(acc.ShippingAddress != null){
            acc.ShippingCity = 'Test update';
            acc.ShippingCountry = 'Test update';
            acc.ShippingPostalCode = 'TPC1';
            acc.ShippingState = 'Test update';
            acc.ShippingStreet = 'Test update';
                accToUpdate.add(acc);
            }
    	}
        if(!accToUpdate.isEmpty()){
         insert accToUpdate;
        }
        
        List<Address__c> addrToUpdate = new List<Address__c>();
        for(Address__c addr2:[SELECT Id, Name, City__c, Country__c, Zip_Postal_Code__c, 
                                      Street__c, State_Province__c, Address_Type__c, Main__c FROM Address__c where Main__c = true]){
            if(addr2.Address_Type__c == 'Billing Address' && addr2.Main__c ==true){
                addr2.City__c = 'Test go';
                addr2.Country__c = 'Test g Country';
                addr2.Zip_Postal_Code__c = 'TPCf';
                addr2.State_Province__c = 'Test fdState';
                addr2.Street__c = 'Test Svvtreet';
                addrToUpdate.add(addr2);
            }
            else if(addr2.Address_Type__c == 'Shipping Address' && addr2.Main__c ==true){
                addr2.City__c = 'Test go';
                addr2.Country__c = 'Test g Country';
                addr2.Zip_Postal_Code__c = 'TPCf';
                addr2.State_Province__c = 'Test fdState';
                addr2.Street__c = 'Test Svvtreet';
                addrToUpdate.add(addr2);
            }


        }
        test.startTest();
        if(!addrToUpdate.isEmpty()){
        update addrToUpdate;
        }
        test.stopTest();
        
        List<Address__c> updatedAddrs = [select id, name, City__c from Address__c where City__c = 'Test go'];
        system.assertEquals(true, updatedAddrs.size()>0);
	}
}