using System;
using System.Net;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.IO;

namespace JSONProcessing
{
    class EntryPoint
    {
        static void Main()
        {
            Utils.DownloadRss();
            var rssFeedAsJSON = Utils.ParseXmlToJSON();
            var titles = rssFeedAsJSON["feed"]["entry"]
                .Select(entry => entry["title"]);

            foreach (var title in titles)
            {
                Console.WriteLine(title);
            }


            var videos = rssFeedAsJSON["feed"]["entry"].Select(entry => JsonConvert.DeserializeObject<Video>(entry.ToString()));
            StringBuilder htmlText = new StringBuilder();
            htmlText.Append("<!DOCTYPE html><html><body>");
            foreach (var video in videos)
            {
                htmlText.AppendFormat("<div><a href=\"{0}\">{1}</a></div>", video.Link.Href, video.Title);
                htmlText.AppendFormat("<iframe width=\"420\" height=\"315\" " + "src=\"http://www.youtube.com/embed/{0}?autoplay=0\"></iframe>", video.Id);
            }

            htmlText.Append("</body></html>");
            File.WriteAllText("../../index.html", htmlText.ToString(), Encoding.UTF8);
       }
    }
}
