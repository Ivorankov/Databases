using System.Collections.Generic;

namespace StudentSystem.Models
{
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;


   public class Student
   {
       private ICollection<Course> courses;
       private ICollection<Homework> homeworks; 

       public Student()
       {
           this.courses = new HashSet<Course>();
           this.homeworks = new HashSet<Homework>();
       }

       [Key]
       public int Id { get; set; }

       [Required]
       public string FullName { get; set; }

       [Required]
       public int StudentNumber { get; set; }

       public virtual ICollection<Course> Courses
       {
           get { return this.courses; }
           set { this.courses = value; }
       }

       public virtual ICollection<Homework> Homeworks
       {
           get { return this.homeworks; }
           set { this.homeworks = value; }
       } 
    }
}
