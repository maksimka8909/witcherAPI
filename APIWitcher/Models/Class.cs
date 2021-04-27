using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Class
    {
        public Class()
        {
            Beasts = new HashSet<Beast>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Beast> Beasts { get; set; }
    }
}
