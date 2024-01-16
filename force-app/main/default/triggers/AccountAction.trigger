trigger AccountAction on Account (after insert, after Update) {
    if(trigger.isInsert && trigger.isAfter){
       // AccountActionHandler.AccountUpdate(trigger.new);d
    }
if(trigger.isUpdate && trigger.isAfter){
   // AccountActionHandler.OpportunityCreate(trigger.newMap, trigger.oldMap);//
}

}