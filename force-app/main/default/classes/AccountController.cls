public class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> displayAccounts(){
        List<Account> accList = [select id, name, phone, website from Account];
        return accList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountWithContact(){
        return [select id,Name, (select lastName from contacts) from Account];
    }
}