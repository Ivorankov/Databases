using System;
using System.Runtime.InteropServices;

namespace EntityFramework.Test
{
    using System.Collections.Generic;
    using System.Linq;

   public static class DbQuerieer
    {
       //Deam now thats a KPK name xD
       public static List<Customer> FindCustomersWithOrdersToCanadaIn1997()
       {
           var customersCollection = new List<Customer>();
           using (var db = new NorthwindDb())
           {
              var customers = from c in db.Customers
                               join o in db.Orders
                               on c.CustomerID equals o.CustomerID
                               where o.OrderDate.Value.Year == 1997 && o.ShipCountry == "Canada"
                               select c;
               customersCollection.AddRange(customers);
           }

           return customersCollection;
       }

       public static void FindCustomersWithOrdersToCanadaIn1997WithNativeSQL()
       {
           using (var db = new NorthwindDb())
           {
               string query =
                            "SELECT c.Address" +
                            "FROM Customers c " +
                            "JOIN Orders o " +
                            "ON c.CustomerID = o.CustomerID " +
                            "WHERE YEAR(o.OrderDate) = 1997 AND o.ShipCountry = 'Canada'";

               object[] parameters = { db.Customers, db.Orders };
               var customers = db.Database.SqlQuery<Customer>(String.Format(query, parameters));
           }
       }

       public static List<Order> FindSalesByRegionAndPeriod(string region, DateTime startDate, DateTime endDate)
       {
           var orders = new List<Order>();
           using (var db = new NorthwindDb())
           {
               var ordersQuery = from o in db.Orders
                   where o.OrderDate >= startDate && o.OrderDate <= endDate && o.ShipRegion == region
                   select o;
               orders.AddRange(ordersQuery);
           }

           return orders;
       }
    }
}
