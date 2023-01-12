@isTest
public class HelperClassTest {
    @isTest
    public static void TestUpdateAccountAddress(){
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
            Address__c addr = new Address__c();
            if(addr.Address_Type__c == 'Billing Address' && addr.Main__c ==true){
            addr.Name = acc.name +'Test Address' +i;
            addr.City__c = 'Test City' +i;
            addr.Country__c = 'Test Country' +i;
            addr.Account__c = acc.id;
            addr.Main__c = true;
            addr.Zip_Postal_Code__c = 'TPC' +i;
            addr.State_Province__c = 'Test State' +i;
            addr.Street__c = 'Test Street' +i;
                addrList.add(addr);
            }
            else if(addr.Address_Type__c == 'Shipping Address' && addr.Main__c ==true){
            addr.Name = 'Test Address' +i;
            addr.City__c = 'Test City' +i;
            addr.Country__c = 'Test Country' +i;
            addr.Account__c = acc.id;
            addr.Main__c = true;
            addr.Zip_Postal_Code__c = 'TPC' +i;
            addr.State_Province__c = 'Test State' +i;
            addr.Street__c = 'Test Street' +i;
                addrList.add(addr); 
            }
    }
        insert addrList;
        insert accList;
       
        List<Address__c> accToUpdate = new List<Address__c>();
        for(Address__c addr2: [SELECT Id, Name, City__c, Country__c, Zip_Postal_Code__c, 
                                      Street__c, State_Province__c, Address_Type__c, Main__c FROM Address__c where Main__c = true]){
            if(addr2.Address_Type__c == 'Billing Address' && addr2.Main__c ==true){
                addr2.City__c = 'Test go';
                addr2.Country__c = 'Test g Country';
                addr2.Zip_Postal_Code__c = 'TPCf';
                addr2.State_Province__c = 'Test fdState';
                addr2.Street__c = 'Test Svvtreet';
                accToUpdate.add(addr2);
            }
            else if(addr2.Address_Type__c == 'Shipping Address' && addr2.Main__c ==true){
                addr2.City__c = 'Test go';
                addr2.Country__c = 'Test g Country';
                addr2.Zip_Postal_Code__c = 'TPCf';
                addr2.State_Province__c = 'Test fdState';
                addr2.Street__c = 'Test Svvtreet';
                accToUpdate.add(addr2);
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