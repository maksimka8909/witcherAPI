using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class PotionType
    {
        public PotionType()
        {
            Potions = new HashSet<Potion>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Potion> Potions { get; set; }
    }
}
