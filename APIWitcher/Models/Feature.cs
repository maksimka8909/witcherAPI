using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Feature
    {
        public Feature()
        {
            Bestiaries = new HashSet<Bestiary>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Bestiary> Bestiaries { get; set; }
    }
}
