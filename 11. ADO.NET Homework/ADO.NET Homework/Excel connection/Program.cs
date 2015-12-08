using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Data;
using System.Xml;
using System.Xml.Linq;

namespace Excel_connection
{
    class Program
    {
        static void Main()
        {
            //If you get OleDb Error garbage thing please go right click on Excel connection project go to Properties and set Platform type to either x86 or x64 for me it works with x64
            var excelContent = ReadExcelFile();
            var xml = excelContent.GetXml();//wohoo more XML I <3 XML
            var xmlDoc = XDocument.Parse(xml);
            var element = xmlDoc.Descendants("Sheet1_x0024_");

            //Problem 6
            foreach (XElement item in element)
            {
                Console.WriteLine("Name: " + item.Element("Name").Value + " Score: " + item.Element("Score").Value);
            }

            //Problem 7
            WriteExcelFile("People", "TestGuy", 5);
            Console.WriteLine("Excel file updated (located in root dir name is Test)");
            Console.ReadKey();

        }

        private static DataSet ReadExcelFile()
        {
            DataSet dataSet = new DataSet();

            string connectionString = GetConnectionString();

            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();
                OleDbCommand command = new OleDbCommand();
                command.Connection = connection;

                // Get all Sheets in Excel File
                DataTable dtSheet = connection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                // Loop through all Sheets to get data
                foreach (DataRow dr in dtSheet.Rows)
                {
                    //I find it more usefill to learn how to use DataSet object rather than just ConsoleWritelineing here...
                    string sheetName = dr["TABLE_NAME"].ToString();

                    if (!sheetName.EndsWith("$"))
                        continue;

                    // Get all rows from the Sheet
                    command.CommandText = "SELECT * FROM [" + sheetName + "]";

                    DataTable dt = new DataTable();
                    dt.TableName = sheetName;

                    OleDbDataAdapter da = new OleDbDataAdapter(command);
                    da.Fill(dt);

                    dataSet.Tables.Add(dt);
                }

                command = null;
                connection.Close();
            }

            return dataSet;
        }

        private static void WriteExcelFile(string sheetName, string personName, int score)
        {
            string connectionString = GetConnectionString();

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                OleDbCommand cmd = new OleDbCommand();
                cmd.Connection = conn;
                                                                                        //NEVER FORHET THE ' before and after string values!
                cmd.CommandText = "INSERT INTO [" + sheetName + "$](Name, Score) VALUES('" + personName + "'," + score + ");";// For some stupid reason the $ needs to be added in the name of the sheet otherwise it doesnt work...
                cmd.ExecuteNonQuery();

                conn.Close();
            }
        }

        private static string GetConnectionString()//Stole this from a website hehe.. pretty much the whole program Cheers goes to http://www.codeproject.com/Tips/705470/Read-and-Write-Excel-Documents-Using-OLEDB
        {
            Dictionary<string, string> props = new Dictionary<string, string>();

            // XLSX - Excel 2007, 2010, 2012, 2013
            props["Provider"] = "Microsoft.ACE.OLEDB.12.0;";
            props["Extended Properties"] = "Excel 12.0 XML";
            props["Data Source"] = "../../Test.xlsx";

            // XLS - Excel 2003 and Older
            //props["Provider"] = "Microsoft.Jet.OLEDB.4.0";
            //props["Extended Properties"] = "Excel 8.0";
            //props["Data Source"] = "C:\\MyExcel.xls";

            StringBuilder sb = new StringBuilder();

            foreach (KeyValuePair<string, string> prop in props)
            {
                sb.Append(prop.Key);
                sb.Append('=');
                sb.Append(prop.Value);
                sb.Append(';');
            }

            return sb.ToString();
        }
    }
}
