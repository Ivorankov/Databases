using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Net;
using System.Text;
using System.Xml.Linq;

namespace JSONProcessing
{
   internal static class Utils
    {
       private const string xmlFilePath = "../../telerikRSSFeed.xml";

        public static void DownloadRss()
        {
            var telerikRssUri = "https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";
            WebClient client = new WebClient();
            client.Encoding = Encoding.UTF8 ;
            client.DownloadFile(telerikRssUri, xmlFilePath);
        }

        public static JObject ParseXmlToJSON()
        {
            var xmlDocument = XDocument.Load(xmlFilePath);
            var JObjectAsString = JsonConvert.SerializeXNode(xmlDocument, Formatting.Indented);
            var jObject = JObject.Parse(JObjectAsString);

            return jObject;
        }
    }
}
