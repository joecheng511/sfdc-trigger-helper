/**
 * File name: Triggerable
 * Description: The interface to be used to define the business logic (job) in the trigger helper.
 *
 *
 * Modification Log
 * ========================================================
 * Ver Date       Author         Modification
 * --- ---------- -------------- --------------------------
 * 1.0 29.12.2020 Joe Cheng      Initial Version
 */

public interface Triggerable {

    List<SObject> filter();

    void execute(List<SObject> scope);

}