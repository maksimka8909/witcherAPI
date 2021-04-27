using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Character
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int? Idrace { get; set; }
        public int? Idactivity { get; set; }
        public int? Idimage { get; set; }

        public virtual Activity IdactivityNavigation { get; set; }
        public virtual Image IdimageNavigation { get; set; }
        public virtual Race IdraceNavigation { get; set; }
    }
}
