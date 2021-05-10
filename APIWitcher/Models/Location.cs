using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Location
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int? IdtypeLocation { get; set; }
        public int? Idcountry { get; set; }
        public int? Idimage { get; set; }

        public virtual Country IdcountryNavigation { get; set; }
        public virtual Image IdimageNavigation { get; set; }
        public virtual LocationType IdtypeLocationNavigation { get; set; }
    }
}
