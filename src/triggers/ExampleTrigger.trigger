/**
 * File name: ExampleTrigger
 * Description: This is an example trigger on Case object
 *
 *
 * Modification Log
 * ========================================================
 * Ver Date       Author         Modification
 * --- ---------- -------------- --------------------------
 * 1.0 29.12.2020 Joe Cheng      Initial Version
 */

trigger ExampleTrigger on Case (after insert) {

    ExampleTriggerHandler handler = new ExampleTriggerHandler();
    handler.runAfterInsert();

}