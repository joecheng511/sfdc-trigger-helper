# sfdc-trigger-helper
A pattern of Salesforce trigger helper.

<a href="https://www.buymeacoffee.com/iloveblowfish" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a> 

## Introduction
The purpose of this repository is:
1. to keep your trigger handler clean;
2. to streamline the trigger helper.

In most of the cases, the steps of writing a Salesforce trigger can be described as follows;
1. iterate through all the records which fire the trigger, find the cared record subset by certain criteria;
2. take some actions to the record subset;
3. sometimes take additional actions after the execution of the main actions (in step 2).

By using this pattern, you can define each business logic as a sub-class of a trigger helper. And you can define the three steps as the following method:
 - filter()
 - execute()
 - finish()

In this way, the trigger helper will be clean to read and easier to manage.

This pattern is handler-neutral, which means you can use your favorite trigger handler framework together with this solution.

## Get Start
Copy the `TriggerHelper.cls`, `Triggerable.cls` and `Finishable.cls` under `/src/classes` to your Salesforce project and follow the `ExampleTrigger.trigger` for more details.



