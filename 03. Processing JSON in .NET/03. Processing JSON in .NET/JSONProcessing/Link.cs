using System;
using Newtonsoft.Json;

namespace JSONProcessing
{
        public class Link
        {
            [JsonProperty("@href")]
            public string Href { get; set; }
        }

}
