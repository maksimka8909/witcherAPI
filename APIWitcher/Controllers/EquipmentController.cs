using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWitcher.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EquipmentController : Controller
    {
        private readonly WitcherDBContext _context;

        public EquipmentController(WitcherDBContext context)
        {
            _context = context;
        }
        [Route("[action]")]
        [HttpGet]
        public IEnumerable<Object> Armor()
        {
            var request = from equipment in _context.Equipment
                          join equipmentType in _context.EquipmentTypes on equipment.IdequipmentType equals equipmentType.Id
                          join image in _context.Images on equipment.Idimage equals image.Id
                          where equipmentType.Name == "Броня"
                          select new
                          {
                              id = equipment.Id,
                              name = equipment.Name,
                              equipmentType = equipmentType.Name,
                              location = equipment.Location,
                              description = equipment.Description,
                              image = image.Link,
                             
                          };
            return request;
        }
        [Route("[action]/name/{name}")]
        [HttpGet]
        public IEnumerable<Object> Armor(string name)
        {
            var request = from equipment in _context.Equipment
                          join equipmentType in _context.EquipmentTypes on equipment.IdequipmentType equals equipmentType.Id
                          join image in _context.Images on equipment.Idimage equals image.Id
                          where equipment.Name == name && equipmentType.Name == "Броня"
                          select new
                          {
                              id = equipment.Id,
                              name = equipment.Name,
                              equipmentType = equipmentType.Name,
                              location = equipment.Location,
                              description = equipment.Description,
                              image = image.Link,

                          };
            return request;
        }

        [HttpGet]
        [Route("[action]/{id}")]
        public IEnumerable<Object> GetComponentsId(int id)
        {
            var request = from equipmentSructure in _context.EquipmentStructures
                          join components in _context.Components on equipmentSructure.Idcomponent equals components.Id
                          where equipmentSructure.Idequipment == id
                          select new
                          {
                              name = components.Name,
                              value = equipmentSructure.Value
                              

                          };
            return request;
        }

        [HttpGet]
        [Route("[action]/{name}")]
        public IEnumerable<Object> GetComponentsName(string name)
        {
            var request = from equipmentSructure in _context.EquipmentStructures
                          join components in _context.Components on equipmentSructure.Idcomponent equals components.Id
                          join  equpiment in _context.Equipment on equipmentSructure.Idequipment equals equpiment.Id
                          where equpiment.Name == name
                          select new
                          {
                              name = components.Name,
                              value = equipmentSructure.Value
                              

                          };
            return request;
        }

        [Route("[action]")]
        [HttpGet]
        public IEnumerable<Object> Sword()
        {
            var request = from equipment in _context.Equipment
                          join equipmentType in _context.EquipmentTypes on equipment.IdequipmentType equals equipmentType.Id
                          join image in _context.Images on equipment.Idimage equals image.Id
                          where equipmentType.Name == "Меч"
                          select new
                          {
                              id = equipment.Id,
                              name = equipment.Name,
                              equipmentType = equipmentType.Name,
                              location = equipment.Location,
                              description = equipment.Description,
                              image = image.Link,

                          };
            return request;
        }
        [Route("[action]/name/{name}")]
        [HttpGet]
        public IEnumerable<Object> Sword(string name)
        {
            var request = from equipment in _context.Equipment
                          join equipmentType in _context.EquipmentTypes on equipment.IdequipmentType equals equipmentType.Id
                          join image in _context.Images on equipment.Idimage equals image.Id
                          where equipment.Name == name && equipmentType.Name == "Меч"
                          select new
                          {
                              id = equipment.Id,
                              name = equipment.Name,
                              equipmentType = equipmentType.Name,
                              location = equipment.Location,
                              description = equipment.Description,
                              image = image.Link,

                          };
            return request;
        }
    }
}
