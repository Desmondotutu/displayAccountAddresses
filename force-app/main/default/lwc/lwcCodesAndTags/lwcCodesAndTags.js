import {LightningElement,api,wire,track} from 'lwc';
import getCodesAndTags from '@salesforce/apex/CodesAndTagsController.getCodesAndTags';
import{NavigationMixin} from 'lightning/navigation';
const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Allocation', fieldName: 'allocation__c' },
    { label: 'Parent Code', fieldName: 'Parent_Code__c' },
]
export default class lwcCodesAndTags extends NavigationMixin(LightningElement){
    @api recordId;
    @track multiple = true;
    @track columns= columns;
    @track errorMessage;
    @wire(getCodesAndTags)
    CodesAndTags;

    handleNext(event){

    }
    section = '';

    handleClick(event) {
        this.section = 'B';
    }

    handleSectionToggle(event) {
        this.section = event.detail.openSections;
    }
}