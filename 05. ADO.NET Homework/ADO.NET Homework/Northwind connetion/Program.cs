using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;

namespace Northwind_connetion
{
    internal class Program
    {
        private const string SqlConnectionString =
                                        "Server=.\\; " +
                                        "Database=Northwind; " +
                                        "Integrated Security=true";
        static void Main()
        {
            //Problem 1
            GetCategoryRowCount();
            WaitForNextMethod();

            //Problem 2
            GetCategoryNameAndDescription();
            WaitForNextMethod();

            //Problem 3
            GetCategoriesAndProducts();
            WaitForNextMethod();

            //Problem 4
            AddProductToProducts();
            WaitForNextMethod();

            //Problem 5
            ExtractAndSaveImagesFromCategories();
            WaitForNextMethod();

            //Problem 8
            Console.WriteLine("Enter Search pattern");
            var pattern = Console.ReadLine();
            FindProductsUsingSearchPattern(pattern);

            WaitForNextMethod();

        }

        private static void GetCategoryRowCount()
        {
            var sqlConnetion = new SqlConnection(SqlConnectionString);
            sqlConnetion.Open();

            using (sqlConnetion)
            {
                var sqlCommand = new SqlCommand("SELECT COUNT(*) FROM Categories", sqlConnetion);
                var reader = (int)sqlCommand.ExecuteScalar();
                Console.WriteLine("Number of rows in category: " + reader);
             
            }
        }

        private static void GetCategoryNameAndDescription()
        {
            var sqlConnetion = new SqlConnection(SqlConnectionString);

            sqlConnetion.Open();
            using (sqlConnetion)
            {
                var sqlCommand = new SqlCommand("SELECT CategoryName, Description FROM Categories", sqlConnetion);
                var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine("Category: " + reader["CategoryName"]);
                    Console.WriteLine("Description: " + reader["Description"]);
                    Console.WriteLine();
                }
            }
           
        }

        private static void GetCategoriesAndProducts()
        {
            var sqlConnetion = new SqlConnection(SqlConnectionString);
            sqlConnetion.Open();
            using (sqlConnetion)
            {
                var sqlCommand = new SqlCommand("SELECT c.CategoryName, p.ProductName" +
                                                " FROM Products p " +
                                                "JOIN Categories c " +
                                                "ON p.CategoryID = c.CategoryID" +
                                                " GROUP BY c.CategoryName, p.ProductName", sqlConnetion);// yes I can use join it's easy :P

                var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine("Category: " + reader["CategoryName"]);
                    Console.WriteLine("Product: " + reader["ProductName"]);
                    Console.WriteLine();
                }
            }
        }

        private static void AddProductToProducts()
        {
            var sqlConnection = new SqlConnection(SqlConnectionString);
            sqlConnection.Open();

            using (sqlConnection)
            {
                var sqlCommand = new SqlCommand("INSERT INTO Products(ProductName, CategoryID, Discontinued)" +
                                                " VALUES('Rotten Fish', 1, 1)", sqlConnection);//Category id 1 is beverages you can rerun the app and check its there...
                sqlCommand.ExecuteNonQuery();                                                  //Dun make much sence but idk and idc about the id of sea foods
                                                                                               //You could drink a rooten fish if it has rotted enought?
            }
            Console.WriteLine("Product added to DB Northwind... If its not there go south in search of it xD");
           
        }

        private static void ExtractAndSaveImagesFromCategories()
        {
            var images = new List<byte[]>();
            var sqlConnection = new SqlConnection(SqlConnectionString);
            sqlConnection.Open();
            using (sqlConnection)
            {
                var sqlCommand = new SqlCommand("SELECT Picture FROM Categories", sqlConnection);
                var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    images.Add((byte[])reader["Picture"]);
                }
            }

            var count = 0;
            foreach (var imageData in images)
            {
                var stream = new MemoryStream(imageData, 78, imageData.Length - 78);//The 78 thing makes it not crash idk why but...
                using (stream)
                {
                    var image = Image.FromStream(stream);
                    image.Save("Test " + count + ".jpg", ImageFormat.Jpeg);
                }
                count++;
            }

            Console.WriteLine("Pictures saved in bin/Debug folder");
        }

        private static void FindProductsUsingSearchPattern(string userSearchPattern)
        {
            var sqlConnection = new SqlConnection(SqlConnectionString);
            sqlConnection.Open();

            using (sqlConnection)
            {
                var sqlCommand = new SqlCommand("SELECT ProductName FROM Products" +
                                " WHERE ProductName LIKE '%" + userSearchPattern + "%' ", sqlConnection);
                var reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Console.WriteLine(reader["ProductName"]);
                }                 
            }
        }

        private static void WaitForNextMethod()
        {
            Console.WriteLine("Press Enter for next result");
            Console.WriteLine();
            Console.ReadKey();
        }
    }
}
