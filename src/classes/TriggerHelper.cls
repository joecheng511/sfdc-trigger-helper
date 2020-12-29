/**
 * File name: TriggerHelper
 * Description: The trigger helper class to run the Triggerable and Finishable interfaces
 *
 *
 * Modification Log
 * ========================================================
 * Ver Date       Author         Modification
 * --- ---------- -------------- --------------------------
 * 1.0 29.12.2020 Joe Cheng      Initial Version
 */

public class TriggerHelper {

    public static void run(Triggerable triggerable) {
        run(triggerable, true);
    }

    /**
     * Method Name: run()
     * Description: Run the Triggerable / Finishable job defined in the trigger helper.
     *              1. run triggerable.filter() method to filter out the target records;
     *              2. run triggerable.execute() method for the main business logic;
     *              3. if the job class implements the Finishable interface, enqueue the finish() method.
     * @param triggerable the Triggerable / Finishable job
     * @param skipFinishIfScopeEmpty Boolean. true -> skip finish() if scope is empty.
     */
    public static void run(Triggerable triggerable, Boolean skipFinishIfScopeEmpty) {
        if (!Trigger.isExecuting) {
            throw new TriggerableNotInTriggerContextException();
        }

        System.debug('###### START - triggerable.filter()');
        List<SObject> scope = triggerable.filter();
        System.debug('###### STOP - triggerable.filter() | scope: ' + scope);

        if (scope != null && scope.size() > 0) {
            System.debug('###### START - triggerable.execute()');
            triggerable.execute(scope);
            System.debug('###### STOP - triggerable.execute()');
        } else {
            System.debug('###### SKIPPED - triggerable.execute(): EMPTY SCOPE.');
        }

        if (triggerable instanceof Finishable) {
            if (scope.size() > 0 || !skipFinishIfScopeEmpty) {
                System.debug('###### START - triggerable.finish()');
                System.enqueueJob(new TriggerHelperFinisher((Finishable) triggerable, scope));
                System.debug('###### STOP - triggerable.finish()');
            } else {
                System.debug('###### SKIPPED - triggerable.finish(): EMPTY SCOPE.');
            }
        } else {
            System.debug('###### SKIPPED - triggerable.finish(): Finishable interface NOT IMPLEMENTED.');
        }
    }

    private class TriggerHelperFinisher implements Queueable {

        private Finishable finishable;
        private List<SObject> scope;

        public TriggerHelperFinisher(Finishable finishable, List<SObject> scope) {
            this.finishable = finishable;
            this.scope = scope;
        }

        public void execute(QueueableContext context) {
            this.finishable.finish(this.scope);
        }
    }

    private class TriggerableNotInTriggerContextException extends Exception {}

}