using System;
using System.Collections.Generic;

#nullable disable

namespace APIWitcher
{
    public partial class EquipmentStructure
    {
        public int Id { get; set; }
        public string Value { get; set; }
        public int? Idequipment { get; set; }
        public int? Idcomponent { get; set; }

        public virtual Component IdcomponentNavigation { get; set; }
        public virtual Equipment IdequipmentNavigation { get; set; }
    }
}
