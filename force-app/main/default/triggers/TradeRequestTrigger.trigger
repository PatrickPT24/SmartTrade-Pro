trigger TradeRequestTrigger on Trade_Request__c (
    before insert,
    before update,
    after insert,
    after update
) {

    TradeRequestTriggerHandler handler = new TradeRequestTriggerHandler();

    if (Trigger.isBefore) {

        if (Trigger.isInsert) {
            handler.beforeInsert(Trigger.new);
        }

        if (Trigger.isUpdate) {
            handler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }

    }

    if (Trigger.isAfter) {

        if (Trigger.isInsert) {
            handler.afterInsert(Trigger.new);
        }

        if (Trigger.isUpdate) {
            handler.afterUpdate(Trigger.new, Trigger.oldMap);
        }

    }
}