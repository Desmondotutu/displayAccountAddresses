import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Address__c.Name';
import ACCOUNT_FIELD from '@salesforce/schema/Address__c.Account__c';
import ADDRESS_TYPE_FIELD from '@salesforce/schema/Address__c.Address_Type__c';
import MAIN_FIELD from '@salesforce/schema/Address__c.Main__c';
import CITY_FIELD from '@salesforce/schema/Address__c.City__c';
import COUNTRY_FIELD from '@salesforce/schema/Address__c.Country__c';
import STREET_FIELD from '@salesforce/schema/Address__c.Street__c';
import STATE_PROVINCE_FIELD from '@salesforce/schema/Address__c.State_Province__c';
import ZIP_POSTAL_CODE_FIELD from '@salesforce/schema/Address__c.Zip_Postal_Code__c';
import { NavigationMixin } from 'lightning/navigation';

export default class recordFormStaticContacts extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;
    fields= [NAME_FIELD, ACCOUNT_FIELD, ADDRESS_TYPE_FIELD, MAIN_FIELD, ZIP_POSTAL_CODE_FIELD, STATE_PROVINCE_FIELD, STREET_FIELD, COUNTRY_FIELD, CITY_FIELD];
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