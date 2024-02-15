public class AccountUtility {    
//commenterg
    public static void viewAnnualRevenue(){
        List<Account> accountsList=[SELECT name,annualrevenue from account];
        for(Account acc:accountsList ){
            String acctRev='Account Name:' +acc.Name+ ' Annual Revenue: ' +acc.AnnualRevenue;
            System.debug(acctRev);
        }
        
    }

}
