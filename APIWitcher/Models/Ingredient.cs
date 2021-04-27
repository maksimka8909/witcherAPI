using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Ingredient
    {
        public Ingredient()
        {
            PotionStructures = new HashSet<PotionStructure>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<PotionStructure> PotionStructures { get; set; }
    }
}
