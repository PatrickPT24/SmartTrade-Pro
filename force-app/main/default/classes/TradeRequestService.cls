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

    /**
     * Checks whether the requested trade is within the trader's trading limit.
     */
    public static Boolean validateTradingLimit(
        Id traderId,
        Decimal quantity,
        Decimal entryPrice
    ){

        Trader__c trader = [
            SELECT Trading_Limit__c
            FROM Trader__c
            WHERE Id = :traderId
            LIMIT 1
        ];

        Decimal tradeValue = quantity * entryPrice;
        return tradeValue <= trader.Trading_Limit__c;
    }

    /**
     * Calculates total exposure for a trade.
     */
    public static Decimal calculateExposure(
        Decimal quantity,
        Decimal entryPrice
    ){
    
        return quantity * entryPrice;
    }
    /**
     * Updates the status of a Trade Request.
     */
    public static void updateTradeStatus(
        Id tradeRequestId,
        String newStatus
    ){
    
        Trade_Request__c trade = [
            SELECT Id, Status__c
            FROM Trade_Request__c
            WHERE Id = :tradeRequestId
            LIMIT 1
        ];
    
        trade.Status__c = newStatus;
        update trade;
    }    
}