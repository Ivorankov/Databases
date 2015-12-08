using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace StudentSystem.Models
{
   public class Homework
   {
       private ICollection<Student> students;
 
       public Homework()
       {
         this.students = new HashSet<Student>();  
       }

       [Key]
       public int Id { get; set; }

       [Required]
       public string Content { get; set; }

       [Required]
       public DateTime TimeSent { get; set; }

       public virtual ICollection<Student> Students
       {
           get { return this.students; }
           set { this.students = value; }
       } 
    }
}
