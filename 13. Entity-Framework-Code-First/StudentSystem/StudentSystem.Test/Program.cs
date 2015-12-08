namespace StudentSystem.Test
{
    using System;

    using System.Linq;
    using Data;
    using Models;

    class Program
    {
        private const string BsName = "abcdefghigklmnopqrstuvwxyz";

        private static Random rnd = new Random();

        static void Main()
        {

            //Initial seeding
            using (var db = new StudentSystemDb())
            {
                for (int i = 0; i < 50; i++)
                {
                    db.Students.Add(StudentGenerator());
                    db.Courses.Add(CourseGenerator());
                    db.Homeworks.Add(HomeworkGenerator());
                }
                db.SaveChanges();
            }

            //Some more seeding
            using (var db = new StudentSystemDb())
            {
                var homeworks = db.Homeworks.ToList();
                var students = db.Students.ToList();

                foreach (var homework in homeworks)
                {
                    foreach (var student in students)
                    {
                        student.Homeworks.Add(homework);//Ow look at them go all the homeworks done good job
                    }
                }
                db.SaveChanges();
            }
        }

        private static Student StudentGenerator()
        {
            var student = new Student();
            student.StudentNumber = GetRandomIntNumber(0,1000);
            student.FullName = GetRandomString();
            student.Courses.Add(CourseGenerator());

            return student;
        }

        private static Course CourseGenerator()
        {
            var course = new Course();
            course.Description = GetRandomString();
            return course;
        }

        private static Homework HomeworkGenerator()
        {
            var homework = new Homework();
            homework.Content = GetRandomString();
            homework.TimeSent = GetDateTime();
            return homework;
        }

        private static string GetRandomString()
        {
            return BsName.Substring(GetRandomIntNumber(0,5), GetRandomIntNumber(5,20));
        }

        private static DateTime GetDateTime()
        {
            return new DateTime(
                2015,
                GetRandomIntNumber(6,11),
                GetRandomIntNumber(1,28),
                GetRandomIntNumber(0,24),
                GetRandomIntNumber(0,59),
                GetRandomIntNumber(0, 59)
                );
        }

        private static int GetRandomIntNumber(int minRange, int maxRange)
        {
           return rnd.Next(minRange, maxRange);
        }
    }
}
