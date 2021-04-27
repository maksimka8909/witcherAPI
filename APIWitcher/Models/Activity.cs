using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Activity
    {
        public Activity()
        {
            Characters = new HashSet<Character>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Character> Characters { get; set; }
    }
}
