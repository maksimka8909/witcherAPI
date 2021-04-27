using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Component
    {
        public Component()
        {
            EquipmentStructures = new HashSet<EquipmentStructure>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<EquipmentStructure> EquipmentStructures { get; set; }
    }
}
