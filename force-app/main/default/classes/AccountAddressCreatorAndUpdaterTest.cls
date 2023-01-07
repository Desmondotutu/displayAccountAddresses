@isTest
public class AccountAddressCreatorAndUpdaterTest{
    @isTest
    public static void createAccAndAddressTestForBilling(String accIds){
        // create test Account records
        List<Account> accList = new List<Account>();
        for(integer i=0; i<200; i++){
            Account acc = new Account();
            if(acc.BillingAddress != null){
                acc.Name = 'Test Account' +i;
                acc.BillingCity = 'Test City' +i;
                acc.BillingCountry = 'Test Country' +i;
                acc.BillingPostalCode = 'TPC' +i;
                acc.BillingState = 'Test State' +i;
                acc.BillingStreet = 'Test Street' +i;
                accList.add(acc);
            }
            else if(acc.ShippingAddress != null){
                acc.Name = 'Test Account' +i;
                acc.ShippingCity = 'Test City' +i;
                acc.ShippingCountry = 'Test Country' +i;
                acc.ShippingPostalCode = 'TPC' +i;
                acc.ShippingState = 'Test State' +i;
                acc.ShippingStreet = 'Test Street' +i;
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
            else if(!String.isBlank(acc.ShippingCity) && !String.isBlank(acc.ShippingCountry) && !String.isBlank(acc.ShippingPostalCode) && !String.isBlank(acc.ShippingState) && !String.isBlank(acc.ShippingStreet)){
                acc.Name = 'Test Account' +i;
                acc.ShippingCity = 'Test City' +i;
                acc.ShippingCountry = 'Test Country' +i;
                acc.ShippingPostalCode = 'TPC' +i;
                acc.ShippingState = 'Test State' +i;
                accList.add(acc);
            }
   
       
        }
        //insert test address records
        Test.startTest();
        insert accList;
        Test.stopTest();
        
        List<Address__c> addrListInserted = [select id, Name from Address__c where Account__c IN:accIds];
        
        system.assertEquals(addrListInserted.size(), accList.size());
   	}

    @isTest
    public static void TestUpdateAccountAddress(){
        set<id> accIds = new Set<id>();
        List<Address__c> addrList = new List<Address__c>();
        List<Account> accList = new List<Account>();
        for(integer i=0; i<200; i++){
            Account acc = new Account();
                acc.name = 'Test Account'+i; 
                acc.BillingStreet = 'hey'+i;
                acc.BillingCity = 'you'+i;
                acc.BillingCountry = 'come'+i;
            	acc.BillingState = 'here'+i;
            	acc.BillingPostalCode = 'and'+i;
            accList.add(acc);
            set.add(acc.id);
            }
            insert accList;
        for(Account acc:accList){
            Address__c addr = new Address__c();
            if(acc.BillingAddress != null){
            addr.Name = acc.name +'Test Address';
            addr.City__c = 'Test City';
            addr.Country__c = 'Test Country';
            addr.Address_Type__c = 'Billing Address';
            addr.Account__c = acc.id;
            addr.Main__c = true;
            addr.Zip_Postal_Code__c = 'TPC';
            addr.State_Province__c = 'Test State';
            addr.Street__c = 'Test Street';
                addrList.add(addr);
            }

            else if(acc.ShippingAddress != null){
            addr.Name = acc.name +'Test Address';
            addr.City__c = 'Test City';
            addr.Country__c = 'Test Country';
            addr.Account__c = acc.id;
            addr.Address_Type__c = 'Shipping Address';
            addr.Zip_Postal_Code__c = 'TPC';
            addr.State_Province__c = 'Test State';
            addr.Street__c = 'Test Street';
                addrList.add(addr);
            }
    	}
        if(!addrList.isEmpty()){
         insert addrList;
        }
        
        List<Address__c> accToUpdate = new List<Address__c>();
        List<Address__c> addrlist2 = [SELECT Id, Name, City__c, Country__c, Zip_Postal_Code__c, 
                                      Street__c, State_Province__c, Address_Type__c FROM Address__c where Main__c = true];
        for(Address__c addr2: addrlist2){
            if(addr2.Address_Type__c == 'Billing Address' && addr2.Main__c ==true){
                addr2.City__c = 'Test go';
                addr2.Country__c = 'Test g Country';
                addr2.Zip_Postal_Code__c = 'TPCf';
                addr2.State_Province__c = 'Test fdState';
                addr2.Street__c = 'Test Svvtreet';
                addrList2.add(addr2);
            }
            else if(addr2.Address_Type__c == 'Shipping Address' && addr2.Main__c ==true){
                addr2.City__c = 'Test go';
                addr2.Country__c = 'Test g Country';
                addr2.Zip_Postal_Code__c = 'TPCf';
                addr2.State_Province__c = 'Test fdState';
                addr2.Street__c = 'Test Svvtreet';
                addrList2.add(addr2);
            }


        }
        test.startTest();
        if(!accToUpdate.isEmpty()){
        update accToUpdate;
        }
        test.stopTest();
        
        List<Address__c> updatedAddrs = [select id, name, City__c from Address__c where City__c = 'Test go'];
        system.assertEquals(true, updatedAddrs.size()>0);
	}
}