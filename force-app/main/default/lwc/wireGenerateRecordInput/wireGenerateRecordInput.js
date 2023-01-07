import { LightningElement, api, wire } from 'lwc';
import {
    getRecordCreateDefaults,
    generateRecordInputForCreate
} from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class WireGenerateRecordInput extends LightningElement {
    @api recordId;
    @wire(getRecordCreateDefaults, { objectApiName: CONTACT_OBJECT })
    contactCreateDefaults;

    get recordInputForCreate() {
        if (!this.contactCreateDefaults.data) {
            return undefined;
        }

        const contactObjectInfo = this.contactCreateDefaults.data.objectInfos[
            CONTACT_OBJECT.objectApiName
        ];
        const recordDefaults = this.contactCreateDefaults.data.record;
        const recordInput = generateRecordInputForCreate(
            recordDefaults,
            contactObjectInfo
        );
        return recordInput;
    }

    get errors() {
        return this.contactCreateDefaults.error;
    }
}