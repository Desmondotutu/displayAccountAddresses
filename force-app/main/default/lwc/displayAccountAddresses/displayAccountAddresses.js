// apexAddressesForAccount.js

import { LightningElement, wire, api, track } from 'lwc';
import getAccountAddresses from '@salesforce/apex/AccountHelper.getAccountAddresses';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class displayAccountAddresses extends LightningElement {
    
            @track columns = [{
                label: 'Account name',
                fieldName: 'Name',
                type: 'text',
                sortable: true
            },
            {
                label: 'Address Type',
                fieldName: 'Address_Type__c',
                type: 'text',
                sortable: true
            },
            {
                label: 'Account',
                fieldName: 'Account__c',
                sortable: true
            },
            {
                label: 'Main',
                fieldName: 'Main__c',
                type: 'checkbox',
                sortable: true
            },
            {
                label: 'Name',
                fieldName: 'name',
                type: 'text',
                sortable: true
            }
        ];

        @track error;
        @wire(getAccountAddresses)

        columns = this.columns;
        rowOffset = 0;
        connectedCallback() {
            this.data = getAccountAddresses;
        }

}