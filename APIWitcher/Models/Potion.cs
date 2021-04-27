using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Potion
    {
        public Potion()
        {
            InverseIdpotionTypeNavigation = new HashSet<Potion>();
            PotionStructures = new HashSet<PotionStructure>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int? IdpotionType { get; set; }
        public int? Idimage { get; set; }

        public virtual Image IdimageNavigation { get; set; }
        public virtual Potion IdpotionTypeNavigation { get; set; }
        public virtual ICollection<Potion> InverseIdpotionTypeNavigation { get; set; }
        public virtual ICollection<PotionStructure> PotionStructures { get; set; }
    }
}
