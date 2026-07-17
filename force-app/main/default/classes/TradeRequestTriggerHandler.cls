public with sharing class TradeRequestTriggerHandler {

    public void beforeInsert(List<Trade_Request__c> newTrades) {

        for (Trade_Request__c trade : newTrades) {

            Decimal exposure =
                TradeRequestService.calculateExposure(
                    trade.Quantity__c,
                    trade.Entry_Price__c
                );

            if (!TradeRequestService.validateTradingLimit(
                    trade.Trader__c,
                    trade.Quantity__c,
                    trade.Entry_Price__c
                )) {

                trade.addError(
                    'Trade value exceeds the Trading Limit of the Trader.'
                );
            }

        }

    }

    public void beforeUpdate(
        List<Trade_Request__c> newTrades,
        Map<Id, Trade_Request__c> oldMap
    ) {

        // We'll implement business rules here later.

    }

    public void afterInsert(
        List<Trade_Request__c> newTrades
    ) {

        // Future enhancement

    }

    public void afterUpdate(
        List<Trade_Request__c> newTrades,
        Map<Id, Trade_Request__c> oldMap
    ) {

        // Future enhancement

    }

}