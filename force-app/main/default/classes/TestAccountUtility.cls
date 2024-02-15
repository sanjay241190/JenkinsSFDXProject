@isTest
public class TestAccountUtility {

    @isTest
    static void testViewAnnualRevenue() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                AnnualRevenue = 10000 * (i + 1) // Assuming incrementing revenue for each test account
            ));
        }
        insert testAccounts;

        // Call the method to be tested
        Test.startTest();
        AccountUtility.viewAnnualRevenue();
        Test.stopTest();

        // Verify debug logs
        List<LogEntry> logs = [SELECT Id, Application, Level, LogUserId, Timestamp, Message 
                               FROM ApexLog WHERE Application = 'IDE'];
        Boolean found = false;
        for(LogEntry log : logs) {
            if(log.Message != null && log.Message.contains('Account Name:') && log.Message.contains('Annual Revenue:')) {
                found = true;
                break;
            }
        }
        System.assert(found, 'Expected debug logs not found');
    }
}
