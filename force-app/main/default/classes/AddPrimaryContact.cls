public class AddPrimaryContact implements Queueable {
    private contact c;
    private string state;
    public AddPrimaryContact(contact c, String state){
        this.c=c;
        this.state=state;
    }
    public void execute(queueablecontext context){
        List<Account> ListAccount = [SELECT ID, Name ,(Select id,FirstName,LastName from contacts )
                                     FROM ACCOUNT WHERE BillingState = :state LIMIT 200];
        List<Contact> lstContact = new List<Contact>();
        for (Account acc:ListAccount){
            Contact cont = c.clone(false,false,false,false);
                 cont.AccountId =  acc.id;
                 lstContact.add( cont );

        }
        if(lstContact.size() >0 )
         {
             insert lstContact;
         }

    }
}