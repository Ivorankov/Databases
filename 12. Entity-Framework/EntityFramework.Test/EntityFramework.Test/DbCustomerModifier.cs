namespace EntityFramework.Test
{
    using System;
    using System.Linq;

   public static class DbCustomerModifier
    {
       public static void InsertCutomer(Customer customer)
       {
           using (var db = new NorthwindDb())
           {
               if (db.Customers.Find(customer.CustomerID) != null)
               {
                   Console.WriteLine("Duplicate entry");
               }
               else
               {
                   db.Customers.Add(customer);
                   db.SaveChanges();
               }
           }
       }

       public static void DeleteCustomer(string customerId)
       {

           using (var db = new NorthwindDb())
           {
               db.Customers.Remove(db.Customers.Find(customerId));
               db.SaveChanges();
           }
       }

       public static void ModifiyCustomer(Customer customer, Customer customerModifiaction)
       {
           using (var db = new NorthwindDb())
           {
              
               var customerToModify = db.Customers.Find(customer.CustomerID);
               customerToModify = customerModifiaction;
               db.SaveChanges();
           }

           Console.WriteLine("Customer modified!");
       }
    }
}
