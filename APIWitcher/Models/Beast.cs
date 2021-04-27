using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Beast
    {
        public Beast()
        {
            Bestiaries = new HashSet<Bestiary>();
        }

        public int Id { get; set; }
        public int? Idimage { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int? Idclass { get; set; }

        public virtual Class IdclassNavigation { get; set; }
        public virtual Image IdimageNavigation { get; set; }
        public virtual ICollection<Bestiary> Bestiaries { get; set; }
    }
}
