public class AccountUtility {    
//comment addewd
    public static void viewAnnualRevenue(){
        List<Account> accountsList=[SELECT name,annualrevenue from account];
        for(Account acc:accountsList ){
            String acctRev='Account Name:' +acc.Name+ ' Annual Revenue: ' +acc.AnnualRevenue;
            System.debug(acctRev);
        }
        
    }
    public static void viewMonthlyRevenue(){
        List<Account> accountsList=[SELECT name,annualrevenue from account];
        for(Account acc:accountsList ){
            String acctRev='Account Name:' +acc.Name+ ' Annual Revenue: ' +acc.AnnualRevenue;
            System.debug(acctRev);
        }
        
    }

    public static void viewTimelyRevenue(){
        List<Account> accountsList=[SELECT name,annualrevenue from account];
        for(Account acc:accountsList ){
            String acctRev='Account Name:' +acc.Name+ ' Annual Revenue: ' +acc.AnnualRevenue;
            System.debug(acctRev);
        }
        
    }

    public static void viewQuarterlyRevenue(){
        List<Account> accountsList=[SELECT name,id,annualrevenue from account];
        for(Account acc:accountsList ){
            String acctRev='Account Name:' +acc.Name+ ' Annual Revenue: ' +acc.AnnualRevenue;
            System.debug(acctRev);
        }
        
    }

    public static void viewCalculations(){
        List<Account> accountsList=[SELECT name,id,annualrevenue from account];
        for(Account acc:accountsList ){
            String acctRev='Account Name:' +acc.Name+ ' Annual Revenue: ' +acc.AnnualRevenue;
            System.debug(acctRev);
        }
        
    }

}
