using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWitcher.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocationController : Controller
    {
        private readonly WitcherDBContext _context;

        public LocationController(WitcherDBContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IEnumerable<Object> Locations()
        {
            var request = from location in _context.Locations
                          join country in _context.Countries on location.Idcountry equals country.Id
                          join image in _context.Images on location.Idimage equals image.Id
                          join typeLocation in _context.LocationTypes on location.IdtypeLocation equals typeLocation.Id
                          select new { id = location.Id, 
                              name = location.Name ,
                              typeLocation = typeLocation.Name,
                              country = country.Name,
                              description = location.Description, 
                              image = image.Link};
            return request;
        }
        [HttpGet]
        [Route("[action]/{name}")]
        public IEnumerable<Object> Name(string name)
        {
            var request = from location in _context.Locations
                          join country in _context.Countries on location.Idcountry equals country.Id
                          join image in _context.Images on location.Idimage equals image.Id
                          join typeLocation in _context.LocationTypes on location.IdtypeLocation equals typeLocation.Id
                          where location.Name==name
                          select new
                          {
                              id = location.Id,
                              name = location.Name,
                              typeLocation = typeLocation.Name,
                              country = country.Name,
                              description = location.Description,
                              image = image.Link
                          };
            return request;
        }
    }
}
