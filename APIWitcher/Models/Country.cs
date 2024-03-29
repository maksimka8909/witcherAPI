﻿using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Country
    {
        public Country()
        {
            Locations = new HashSet<Location>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Location> Locations { get; set; }
    }
}
