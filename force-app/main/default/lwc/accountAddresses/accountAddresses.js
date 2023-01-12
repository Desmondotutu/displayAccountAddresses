import {LightningElement,api,wire,track} from 'lwc';
import getAccountData from '@salesforce/apex/AccountDemoController.getAccountData';
import {deleteRecord} from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class accountAddresses extends LightningElement {
    @track multiple = true;
@track accounts ;
@wire (getAccountData) getContact;
@wire(getAccountData) 
wiredAccountss({
    error,
    data
}) {
    if (data) {
        this.accounts = data;
        console.log(data);
        console.log(JSON.stringify(data, null, '\t'));
        
        data.forEach(function (item, key) {
            console.log(key); 
            console.log(item); 
        });
        
    } else if (error) {
        this.error = error;
    }
}
//@wire (displayContactRecord) getContact;
@track recordId;

handleContactDelete(event){
   this.recordId = event.target.value;
   //window.console.log('recordId# ' + this.recordId);
   deleteRecord(this.recordId) 
   .then(() =>{

      const toastEvent = new ShowToastEvent({
          title:'Record Deleted',
          message:'Record deleted successfully',
          variant:'success',
      })
      this.dispatchEvent(toastEvent);

      return refreshApex(this.getContact);
      
   })
   .catch(error =>{
       window.console.log('Unable to delete record due to ' + error.body.message);
   });
}
}