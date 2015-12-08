using System;
using Newtonsoft.Json;

namespace JSONProcessing
{
    internal class Video
    {
        [JsonProperty("link")]
        public Link Link { get; private set; }

        [JsonProperty("title")]
        public string Title { get; private set; }

        [JsonProperty("yt:channelId")]
        public string Id { get; private set; }
    }
}
