/**
 * File name: Finishable
 * Description: The interface to be used to define the finish() method in the trigger helper.
 *              The finish() method will be enqueued and run in a different transaction.
 * See also: TriggerHelper class.
 *
 *
 * Modification Log
 * ========================================================
 * Ver Date       Author         Modification
 * --- ---------- -------------- --------------------------
 * 1.0 29.12.2020 Joe Cheng      Initial Version
 */

public interface Finishable {

    void finish(List<SObject> scope);

}