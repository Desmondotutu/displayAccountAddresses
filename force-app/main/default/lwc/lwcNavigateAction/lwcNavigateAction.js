import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class LwcNavigateAction extends NavigationMixin(LightningElement) {
    @api recordId;

    
    actionToCreateAddresstNav() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Address',
                actionName: 'new'
            },
        });
    }
    
}