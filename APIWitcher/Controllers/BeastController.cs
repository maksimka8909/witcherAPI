using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWitcher.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BeastController : Controller
    {
        private readonly WitcherDBContext _context;

        public BeastController(WitcherDBContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IEnumerable<Object> Beast()
        {
            var request = from beast in _context.Beasts
                          join type in _context.Classes on beast.Idclass equals type.Id
                          join image in _context.Images on beast.Idimage equals image.Id
                          select new
                          {
                              id = beast.Id,
                              name = beast.Name,
                              type = type.Name,
                              description = beast.Description,
                              image = image.Link
                          };
            return request;
        }
        [HttpGet]
        [Route("[action]/{name}")]
        public IEnumerable<Object>Name(string name)
        {
            var request = from beast in _context.Beasts
                          join type in _context.Classes on beast.Idclass equals type.Id
                          join image in _context.Images on beast.Idimage equals image.Id
                          where beast.Name == name
                          select new
                          {
                              id = beast.Id,
                              name = beast.Name,
                              type = type.Name,
                              description = beast.Description,
                              image = image.Link
                          };
            return request;
        }
        [HttpGet]
        [Route("[action]/{id}")]
        public IEnumerable<Object> GetFeaturesId(int id)
        {
            var request = from bestiary in _context.Bestiaries
                          join features in _context.Features on bestiary.Idfeature equals features.Id
                          where bestiary.Idbeast == id
                          select new
                          {
                              
                              name = features.Name,
                              value = bestiary.Value

                          };
            return request;
        }

        [HttpGet]
        [Route("[action]/{name}")]
        public IEnumerable<Object> GetFeaturesName(string name)
        {
            var request = from bestiary in _context.Bestiaries
                          join beast in _context.Beasts on bestiary.Idbeast equals beast.Id
                          join features in _context.Features on bestiary.Idfeature equals features.Id
                          where beast.Name == name
                          select new
                          {
                              name = features.Name,
                              value = bestiary.Value
                          };
            return request;
        }
        
    }
}
