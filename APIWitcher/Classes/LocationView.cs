using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWitcher.Classes
{
    public class LocationView
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string typeLocation { get; set; }
        public string country { get; set; }
        public string image { get; set; }
    }
}
