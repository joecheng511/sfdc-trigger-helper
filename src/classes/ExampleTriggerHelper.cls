/**
 * File name: ExampleTriggerHelper
 * Description: This is an example trigger helper instance
 *
 *
 * Modification Log
 * ========================================================
 * Ver Date       Author         Modification
 * --- ---------- -------------- --------------------------
 * 1.0 29.12.2020 Joe Cheng      Initial Version
 */

public without sharing class ExampleTriggerHelper {

    public ExampleTriggerHelper() {
    }


    /**
     * Class Name: ForceUseAssignmentRuleJob
     * Description: Force the incoming cases to use the assignment rule. 
     *              Please note that this class implements Triggerable which means it need to implement 
     *              the filter() and execute() functions. Triggerable is mandatory to be implemented.
     *              By implementing Finishable, you can define the logic by implementing a finish() method, 
     *              which will be run in a Queueable Apex. Finishable is optional to implement.
     */
    public class ForceUseAssignmentRuleJob implements Triggerable, Finishable {

        private List<Case> newCases;

        /**
         * The constructor pass the newly inserted cases to the private variable newCases.
         */
        public ForceUseAssignmentRuleJob() {
            if (Trigger.isInsert) {
                this.newCases = (List<Case>) Trigger.new;
            }
        }

        /**
         * The implementation of filter() method, which returns the filtered result (the cases which need to be processed)
         * The returned result will be the input (scope) of the execute() method below.
         */
        public List<Case> filter() {
            List<Case> filterResult = new List<Case>();
            if (Trigger.isAfter && Trigger.isInsert) {
                /**
                 * Iterate through newCases and add the cases which meet the criteria (the if clause) to the filterResult.
                 * Here we only add those has an "Origin".
                 */
                for(Case c : newCases) {
                    if (c.Origin != null) {
                        filterResult.add(c);
                    }
                }
            }
            return filterResult;
        }

        /**
         * The implementation of execute() method, which process the records within the scope.
         * In this example, we force the cases to use the assignment rule.
         */
        public void execute(List<Case> scope) {
            if (scope.size() > 0) {
                Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.assignmentRuleHeader.useDefaultRule = true;
                for(Case c : scope) {
                    c.setOptions(dmo);
                }
                update scope;
            }
        }

        /**
         * The implementation of finish() method, which process the records within the same scope as execute() method.
         * The logic defined here will be run in a Queueable Apex after the execution of execute() method.
         */
        public void finish(List<Case> scope) {
            // Some logic here...
        }

    }

}