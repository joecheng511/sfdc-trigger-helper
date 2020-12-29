/**
 * File name: ExampleTriggerHandler
 * Description: This is an example trigger handler which shows how to run the business logics defined in ExampleTriggerHelper.
                This handler is framework-neutral, which means you can use your favourate SFDC trigger handler framework.
 *
 *
 * Modification Log
 * ========================================================
 * Ver Date       Author         Modification
 * --- ---------- -------------- --------------------------
 * 1.0 29.12.2020 Joe Cheng      Initial Version
 */
public with sharing class ExampleTriggerHandler{

    public ExampleTriggerHandler() {
    }

    public void runAfterInsert() {
        if (Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) {

            /**
             * This is an example of how to run a trigger helper job, which contains the business logic 
             * of force using case assignment rule after the cases are inserted.
             */
            TriggerHelper.run(new ExampleTriggerHelper.ForceUseAssignmentRuleJob());

        }
    }

}