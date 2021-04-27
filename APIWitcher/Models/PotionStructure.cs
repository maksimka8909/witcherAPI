using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class PotionStructure
    {
        public int Id { get; set; }
        public string Value { get; set; }
        public int? Idingredient { get; set; }
        public int? Idpotion { get; set; }

        public virtual Ingredient IdingredientNavigation { get; set; }
        public virtual Potion IdpotionNavigation { get; set; }
    }
}
