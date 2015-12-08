namespace StudentSystem.Data
{
    using StudentSystem.Models;
    using System.Data.Entity;

    public class StudentSystemDb : DbContext
    {
        public StudentSystemDb()
            : base("name=StudentSystemDb")
        {
        }

        public IDbSet<Student> Students { get; set; }

        public IDbSet<Course> Courses { get; set; }

        public IDbSet<Homework> Homeworks { get; set; }
    
    }
}
