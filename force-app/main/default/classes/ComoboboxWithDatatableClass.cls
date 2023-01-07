public class ComoboboxWithDatatableClass {
    
    //This Method will return Accounts To LWC 
    @AuraEnabled
    public static List<Account> getAccountsForCombobox(){
        List<Account> accountList = [Select Id,Name from Account];
        return accountList;
    }

    @AuraEnabled
    public static List<Contact> getContacts(){
        try {
            return [select id, firstname from contact];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}