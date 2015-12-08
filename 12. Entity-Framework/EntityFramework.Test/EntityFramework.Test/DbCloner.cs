namespace EntityFramework.Test
{
   public static class DbCloner
    {
       public static void CloneDb()
       {
           using (var db = new NorthwindDb())
           {
               db.Database.CreateIfNotExists();
           }
       }
    }
}
