namespace EntityFramework.Test
{
    using System;

    class Startup
    {
        static void Main()
        {
            //Problem 1 is NorthwindDb.edmx

            //Problem 2 is DbCustomerModifier.cs

            //Problem 3 5 is in DbQuerieer.cs

            //----------<Tests for problem 2>---------
           // var customer = new Customer();
           // customer.City = "Detroit";
           // customer.Address = "1st Street";
           // customer.Country = "USA";
           // customer.CustomerID = "AFK";
           // customer.CompanyName = "OG-Projects";

           // var customerModifiaction = customer;
           // customerModifiaction.City = "Atlanta";

           // var customerToRemoveId = "AFK";
            
           //DbCustomerModifier.InsertCutomer(customer);

           //DbCustomerModifier.ModifiyCustomer(customer, customerModifiaction);

           //Console.WriteLine("Go check in the Northwind cuz this next step will remove the new Customer...");
           //Console.ReadKey();
           //DbCustomerModifier.DeleteCustomer(customerToRemoveId);

            //----------</Tests for problem 2>-------------

            //----------<Test for problem 3>------------
            var test = DbQuerieer.FindCustomersWithOrdersToCanadaIn1997();
            test.ForEach(x => Console.WriteLine("City: {0} Address: {1}",x.City, x.Address));
            //---------</Test for problem 3>---------

            //---------<Test for problem 5>----------
            var test2 = DbQuerieer.FindSalesByRegionAndPeriod("RJ", new DateTime(1995, 01, 01), new DateTime(2000, 01, 01));
            test2.ForEach(x => Console.WriteLine("OrderDate: {0} ShipRegion: {1}",x.OrderDate,x.ShipRegion));
            //---------</Test for problem 5>----------

            //---------<Test for problem 6>----------
            DbCloner.CloneDb();
            //---------</Test for problem 6>----------

        }
    }
}
