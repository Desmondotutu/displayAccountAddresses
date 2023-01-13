import {LightningElement,api,wire,track} from 'lwc';
import getAccountAddresses from '@salesforce/apex/AddressController.getAccountAddresses';
import {deleteRecord} from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';
const actions = [
    { label: 'Edit', name: 'edit' },
    { label: 'Delete', name: 'Delete' },
];
 
const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Address Type', fieldName: 'Address_Type__c' },
    { label: 'Main', fieldName: 'Main__c' },
];
export default class accountAddresses extends NavigationMixin(LightningElement){
    error;
    @track columns = columns;
    @api recordId;

    @wire(getAccountAddresses, {recordId: '$recordId', columns})
    accounts;
    
    handleClick() {
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Address__c',
                    actionName: 'new'
                },
            });
        }
        showNotification() {
            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Modification saved',
                variant: 'warning',
                mode: 'pester'
            });
            this.dispatchEvent(event);
        }
        handleRowAction( event ) {

            const actionName = event.detail.action.name;
            const row = event.detail.row;
            switch ( actionName ) {
                case 'Delete':
                    this[NavigationMixin.Navigate]({
                        type: 'standard__recordPage',
                        attributes: {
                            recordId: row.Id,
                            actionName: 'delete'
                        }
                    });
                    break;
                case 'edit':
                    this[NavigationMixin.Navigate]({
                        type: 'standard__recordPage',
                        attributes: {
                            recordId: row.Id,
                            objectApiName: 'Address__c',
                            actionName: 'edit'
                        }
                    });
                    break;
                default:
            }
    
        }
    }