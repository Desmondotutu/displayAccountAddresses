public class AccountController {
    public static List<Account> displayAccounts(){
        List<Account> accList = [select id, name, (select id, name, Account__c from Addresses__r) from Account];
        return accList;
    }
}