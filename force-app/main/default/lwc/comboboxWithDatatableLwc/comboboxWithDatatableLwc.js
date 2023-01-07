import { LightningElement,track } from 'lwc';
import getAccountsForCombobox from '@salesforce/apex/ComoboboxWithDatatableClass.getAccountsForCombobox';
import getContacts from '@salesforce/apex/ComoboboxWithDatatableClass.getContacts';

//Define columns for Datatable
const columns = [
    { label : 'Contacts Name' , fieldName : 'Name'},  //fieldname is defined in object manager 
    { label : 'Contacts Email' , fieldName : 'Email'},

]

export default class ComboboxWithDatatableLwc extends LightningElement {

    @track value = '';
    @track optionsArray = []; //this array will store the options for combobox
    @track cardVisible = false;   //used for show/hide card functionality
    @track data = []; //used for storing contact details in data-table
    @track columns = columns;

  //Now store option by returning the optionsArray
  get options(){
      return this.optionsArray;
  }

    //call apex method to get Account stored in Salesforce org Database
    connectedCallback(){
        getAccountsForCombobox()
        .then(response=>{
        let arr = []; //This array store the accounts details in lable and value pair
        for(var i=0 ; i<response.length ; i++){
            // add the account Name as label and Id as value in arr []
            arr.push({ label : response[i].Name , value : response[i].Id })
        }

        //store the arr objects into optionsArray
        this.optionsArray = arr;

        }) 

    }

   //Get Selected Account recordId
   handleChnagedValue(event){

    //Whenever a account is selected in combobox then "cardVisible" will become true and 
    //contact data=table will diplayed to user
       this.cardVisible = true;

    //store selected accountId in "value" property
       this.value  = event.detail.value;

       //call apex method to get contacts of selected Account
       getContacts({ selectedAccountId : this.value})  //pass selected Account recordId to apex method to get related contacts
       .then( result =>{
           this.data = result;
       })
       .catch( error =>{
           window.alert("error:"+error) 
       })
   }
}