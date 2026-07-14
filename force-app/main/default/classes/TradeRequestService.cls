public with sharing class TradeRequestService {

    /**
     * Returns all submitted Trade Requests.
     */
    public static List<Trade_Request__c> getSubmittedTrades() {

        return [
            SELECT Id,
                    Name,
                    Status__c,
                    Symbol__c,
                    Quantity__c,
                    Entry_Price__c,
                    Target_Price__c,
                    Trader__r.Name,
                    Trading_Strategy__r.Name
            FROM Trade_Request__c
            WHERE Status__c = 'Submitted'
            ORDER BY CreatedDate DESC
        ];
    }

}