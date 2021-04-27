using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Image
    {
        public Image()
        {
            Beasts = new HashSet<Beast>();
            Characters = new HashSet<Character>();
            Equipment = new HashSet<Equipment>();
            Potions = new HashSet<Potion>();
        }

        public int Id { get; set; }
        public string Link { get; set; }

        public virtual ICollection<Beast> Beasts { get; set; }
        public virtual ICollection<Character> Characters { get; set; }
        public virtual ICollection<Equipment> Equipment { get; set; }
        public virtual ICollection<Potion> Potions { get; set; }
    }
}
