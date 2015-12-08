using System.Collections.Generic;
using System.Data.Entity;

namespace StudentSystem.Models
{
    using System.ComponentModel.DataAnnotations;

   public class Course
    {
       private ICollection<Student> students; 

       public Course()
       {
           this.students = new HashSet<Student>();
       }

       [Key]
       public int Id { get; set; }

       public string Description { get; set; }

       public int? HomeworkId { get; set; }

       public virtual Homework Homework { get; set; }

       public virtual ICollection<Student> Students
       {
           get { return this.students; }
           set { this.students = value; }
       } 
    }
}
