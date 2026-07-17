public with sharing class TradeRequestTriggerHandler {

    public void beforeInsert(List<Trade_Request__c> newTrades){

        Set<Id> traderIds = new Set<Id>();
    
        for(Trade_Request__c trade : newTrades){
    
            if(trade.Trader__c != null){
                traderIds.add(trade.Trader__c);
            }
    
        }
    
        Map<Id, Trader__c> traderMap =
            TradeRequestService.getTradersByIds(traderIds);
    
        for(Trade_Request__c trade : newTrades){
    
            if(trade.Trader__c == null){
                continue;
            }
    
            Trader__c trader = traderMap.get(trade.Trader__c);
    
            Decimal tradeValue =
                TradeRequestService.calculateExposure(
                    trade.Quantity__c,
                    trade.Entry_Price__c
                );
    
            if(tradeValue > trader.Trading_Limit__c){
    
                trade.addError(
                    'Trade value exceeds Trading Limit.'
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