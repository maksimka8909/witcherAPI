using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class Equipment
    {
        public Equipment()
        {
            EquipmentStructures = new HashSet<EquipmentStructure>();
        }

        public int Id { get; set; }
        public int? Idimage { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Location { get; set; }
        public int? IdequipmentType { get; set; }

        public virtual EquipmentType IdequipmentTypeNavigation { get; set; }
        public virtual Image IdimageNavigation { get; set; }
        public virtual ICollection<EquipmentStructure> EquipmentStructures { get; set; }
    }
}
