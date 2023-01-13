@RestResource(urlMapping='/Lead/*')
global with sharing class LeadManager {

    public class ResponseBody {

        @AuraEnabled public String firstName;
        @AuraEnabled public String lastName;
        @AuraEnabled public String address;
        @AuraEnabled public String city;
        @AuraEnabled public String stateProvince;
        @AuraEnabled public String postalCode;
        @AuraEnabled public String primaryPhone;
        @AuraEnabled public String email;
        @AuraEnabled public Integer leadOid;
        @AuraEnabled public String leadSource;
        @AuraEnabled public List<Interview> interview;
    }
        public class Interview {
            @AuraEnabled public String question;
            @AuraEnabled public String answer;
        }
    	
ResponseBody responseBody = (ResponseBody)System.JSON.deserialize(json, ResponseBody.class);

 
    @HttpGet
    global static Lead getLeadById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String LeadId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Lead result =  [SELECT id, lastName, email
                        FROM Lead
                        WHERE Id = :LeadId];
        return result;
    }
  
    @HttpDelete
    global static void deleteLead() {
        RestRequest request = RestContext.request;
        String LeadId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Lead thisLead = [SELECT Id FROM Lead WHERE Id = :LeadId];
        delete thisLead;
    }     
    @HttpPut
    global static ID upsertLead(string id, String lastName, String company, String satus, String email, string firstName, string postalCode, string street,
    string stateProvince, string leadoId, string interview, string answer, string mobile, string leadSource) {
            
        List<Lead> leads = [select id, email from Lead where email = :email];
            
            if (leads.size() == 0) {
                //Create new lead
                insert new Lead(Company = 'Lead Company', FirstName = firstname, LastName = lastname, Email = email, Status = 'Open', Interview_Question__c = question,
                                Street= address, State = stateprovince,LeadSource = leadSource, v, City = city, Mobile = primaryPhone, LeadOId__c = leadOid, Interview_Answer__c = answer);
            } else if (leads.size() == 1) {
            // Update this lead
            leads[0].FirstName = firstName;
            leads[0].LastName = lastname;
            leads[0].Status = 'Open';
            leads[0].Company = 'Test Company';
            leads[0].Email = email;
            leads[0].Street= address;
            leads[0].State = stateprovince;
            leads[0].LeadSource = leadSource;
            leads[0].PostalCode = postalCode;
            leads[0].City = city;
            leads[0].Mobile = primaryPhone;
            leads[0].LeadOId__c = leadOid;
            leads[0].Interview_Question__c = question;
            leads[0].Interview_Answer__c = answer;
                update leads;
        // Match Lead by Id, if present.
        // Otherwise, create new Lead.
        upsert thisLead;
        // Return the case ID.
        return thisLead.Id;
    }
    @HttpPatch
    global static ID updateLeadFields() {
        RestRequest request = RestContext.request;
        String LeadId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Lead thisLead = [SELECT Id FROM Lead WHERE Id = :LeadId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisLead.put(fieldName, params.get(fieldName));
        }
        update thisLead;
        return thisLead.Id;
    }    
}