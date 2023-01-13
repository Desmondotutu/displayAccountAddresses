import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getCodesAndTagsForAccounts from '@salesforce/apex/CodesAndTagsController.getCodesAndTagsForAccounts';
export default class lwcCodesAndTags extends LightningElement {
accounts;
  error;
  @track expandedRows = [];

  @wire(getCodesAndTagsForAccounts)
  wiredAccounts({ error, data }) {
    if (data) {
      let accounts = JSON.parse(JSON.stringify(data));
      let parseData = [];
      let parentId = 0;
      let parentEntity = "";

      for (let i = 0; i < accounts.length; i++) {
        let jsonData =
          '{"Id":"' +
          parentId +
          '","Name":"","Rating":"' +
          accounts[i].Rating +
          '","Phone":""}';
        if (parentId === 0) {
          parseData.push(JSON.parse(jsonData));
          parseData[parentId]._children = [];
          parseData[parentId]._children.push(accounts[i]);
          parentEntity = accounts[i].Rating;
          parentId++;
        } else {
          if (accounts[i].Rating === parentEntity) {
            parseData[parentId - 1]._children.push(accounts[i]);
          } else {
            parentEntity = accounts[i].Rating;
            parseData.push(JSON.parse(jsonData));
            parseData[parentId]._children = [];
            parseData[parentId]._children.push(accounts[i]);
            parentId++;
          }
        }
      }
      this.accounts = parseData;
    } else if (error) {
      this.error = error;
      this.accounts = undefined;
    }
  }
  constructor() {
    super();
    this.columns = [
      {
        type: "text",
        fieldName: "Rating",
        label: "Rating"
      },
      {
        type: "text",
        fieldName: "Name",
        label: "Name"
      },
      {
        type: "text",
        fieldName: "Phone",
        label: "Phone"
      },

      { type: "action", typeAttributes: { rowActions: this.getRowActions } }
    ];
  }
  get expandedRowItems() {
    return this.expandedRows;
  }
  getRowActions(row, doneCallback) {
    const actions = [];
    actions.push({
      label: "Edit",
      name: "edit"
    });
    actions.push({
      label: "Delete",
      name: "delete"
    });
    doneCallback(actions);
  }
}