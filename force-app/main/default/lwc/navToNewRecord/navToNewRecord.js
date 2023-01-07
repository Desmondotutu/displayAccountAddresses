import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavToNewRecord extends NavigationMixin(LightningElement) {
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