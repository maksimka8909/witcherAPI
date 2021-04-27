using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Bestiary
    {
        public int Id { get; set; }
        public string Value { get; set; }
        public int? Idfeature { get; set; }
        public int? Idbeast { get; set; }

        public virtual Beast IdbeastNavigation { get; set; }
        public virtual Feature IdfeatureNavigation { get; set; }
    }
}
