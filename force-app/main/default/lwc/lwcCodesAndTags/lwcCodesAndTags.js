import {LightningElement,api,wire,track} from 'lwc';
import getCodesAndTags from '@salesforce/apex/CodesAndTagsController.getCodesAndTags';

export default class lwcCodesAndTags extends LightningElement {
    @api recordId;
    @track multiple = true;
    @track CodesAndTags ;
    @wire(getCodesAndTags)
    wiredCodesAndTags({
    error,
    data
}) {
    if (data) {
        this.CodesAndTags = data;
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

}