using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MySql_Books_connection
{
    class Program
    {                                                                         //If you have a root password it goes in Pwd=.. the other should be the same
        private const string connectionStringToServer = "Server=localhost; Port=3306; Uid=root; Pwd=; pooling=true";
        private const string connectionStringToDatabase = "Server=localhost; Port=3306; Database=Library; Uid=root; Pwd=; pooling=true";
        static void Main()
        {
            //Run these two to create the db with a table in it
            CreateDb();
            CreateTable();

            AddBookToDb(1, "Book1", "Guy", "01/01/2001", "0001");
            
            AddBookToDb(2, "Book2", "Girl", "01/01/2002", "0002");

            SelectAllBooksFromDb();

            SelectBookFromDbByTitle("Book1");

            Console.ReadKey();


        }

        private static void AddBookToDb(int id, string title, string author, string publishDate, string isbn)
        {
            MySqlConnection dbConnection = new MySqlConnection(connectionStringToDatabase);
            dbConnection.Open();

            using (dbConnection)
            {
                var command = dbConnection.CreateCommand();

                command.CommandText =
                    "INSERT INTO Books(BookId, Title,Author,PublishDate,ISBN) VALUES(@bookId, @title, @author, @publishDate, @isbn)";
                command.Parameters.Add("@bookId", id);
               command.Parameters.Add("@title", title);
               command.Parameters.Add("@author", author);
               command.Parameters.Add("@publishDate", publishDate);
               command.Parameters.Add("@isbn", isbn);
                command.ExecuteNonQuery();
            }
        }

        private static void SelectAllBooksFromDb()
        {
            MySqlConnection dbConnection = new MySqlConnection(connectionStringToDatabase);
            dbConnection.Open();

            using (dbConnection)
            {
                var command = dbConnection.CreateCommand();

                command.CommandText =
                    "SELECT * FROM Books";

                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine(reader["Title"] + " " + reader["Author"]);
                }
            }
        }

        private static void SelectBookFromDbByTitle(string titleOfBook)
        {
            MySqlConnection dbConnection = new MySqlConnection(connectionStringToDatabase);
            dbConnection.Open();

            using (dbConnection)
            {
                var command = dbConnection.CreateCommand();

                command.CommandText =
                    "SELECT * FROM Books " +
                    "WHERE Title = '" + titleOfBook + "';";

                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine("Found your book! - " + reader["Title"] + " " + reader["Author"] + " " + reader["PublishDate"] + " " + reader["ISBN"]);
                }
            }
        }

        private static void CreateDb()
        {
            MySqlConnection dbConnection = new MySqlConnection(connectionStringToServer);
            dbConnection.Open();

            using (dbConnection)
            {
                var command = dbConnection.CreateCommand();

                command.CommandText =
                    "CREATE SCHEMA IF NOT EXISTS `Library` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;";

                command.ExecuteNonQuery();
            }

        }

        private static void CreateTable()
        {
            MySqlConnection dbConnection = new MySqlConnection(connectionStringToDatabase);
            dbConnection.Open();

            using (dbConnection)
            {
                var command = dbConnection.CreateCommand();

                command.CommandText =
                                    "CREATE TABLE Books (" +
                                    "`BookId` INT NOT NULL COMMENT ''," +
                                    "`Title` VARCHAR(45) NULL COMMENT ''," +
                                    "`Author` VARCHAR(45) NULL COMMENT ''," +
                                    "`PublishDate` VARCHAR(45) NULL COMMENT ''," +
                                    "`ISBN` VARCHAR(45) NULL COMMENT ''," +
                                    "PRIMARY KEY (`BookId`)  COMMENT '')" +
                                    "ENGINE = InnoDB;";
                command.ExecuteNonQuery();
            }

        }

    }
}
