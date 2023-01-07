import { LightningElement, track, wire, api } from 'lwc';
import getaddresses from '@salesforce/apex/ContactController.getaddresses';
import deladdrRecords from '@salesforce/apex/ContactController.deladdrRecords';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Address__c.Name';
import ACCOUNT_FIELD from '@salesforce/schema/Address__c.Account__c';
import ADDRESS_TYPE_FIELD from '@salesforce/schema/Address__c.Address_Type__c';
import MAIN_FIELD from '@salesforce/schema/Address__c.Main__c';
import { NavigationMixin } from 'lightning/navigation';
import CITY_FIELD from '@salesforce/schema/Address__c.City__c';
import COUNTRY_FIELD from '@salesforce/schema/Address__c.Country__c';
import STREET_FIELD from '@salesforce/schema/Address__c.Street__c';
import STATE_PROVINCE_FIELD from '@salesforce/schema/Address__c.State_Province__c';
import ZIP_POSTAL_CODE_FIELD from '@salesforce/schema/Address__c.Zip_Postal_Code__c';

const COLS = [
    {
        label: 'Account',
        fieldName: ACCOUNT_FIELD.fieldApiName,
        editable: true
    },
    {
        label: 'Name',
        fieldName: NAME_FIELD.fieldApiName,
        editable: true
    },
    { label: 'Address Type', fieldName: ADDRESS_TYPE_FIELD.fieldApiName, editable: true },
    {
        label: 'Main',
        fieldName: MAIN_FIELD.fieldApiName,
        type: 'boolean',
        editable: true
    },
];
export default class accountAddresses extends LightningElement{
    @api recordId;
    @track columns = COLS;
    draftValues = [];
    @api selectedAddresslist=[];
    @api errorMessage;

    // Using Apex to fetch records while waiting for a replacement to getListUi() which is deprecated
    @wire(getaddresses, {accId: '$recordId'})
    addresses;

    async handleSave(event) {
        // Convert datatable draft values into record objects
        const records = event.detail.draftValues.slice().map((draftValue) => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });

        // Clear all datatable draft values
        this.draftValues = [];

        try {
            // Update all records in parallel thanks to the UI API
            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);

            // Report success with a toast
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Addresses updated',
                    variant: 'success'
                })
            );

            // Display fresh data in the datatable
            await refreshApex(this.addresses);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error while updating or refreshing records',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
    getSelectedId(event){
        const selectedRows = event.detail.selectedRows;
        console.log('selectedRecordID'+JSON.stringify(selectedRows));
        this.selectedAddresslist=[];
        for (let i = 0; i<selectedRows.length; i++){
            this.selectedAddresslist.push(selectedRows[i].Id);
        }
    }
    handleDelete(){
        deladdrRecords({selectRecords: this.selectedAddresslist })
        .then(()=>{
            eval("$A.get('e.force:refreshView').fire();");
            this.template.querySelector('lightning-datatable').selectedRows=[];
            return refreshApex(this.addresses);
        })
        .catch((error)=>{
            this.errorMessage=error;
            console.log('unable to delete the record due to'+JSON.stringify(this.errorMessage));
        });

    }
    navigateToNewAddress() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Address__c',
                actionName: 'new'
            }
        });
    }

}