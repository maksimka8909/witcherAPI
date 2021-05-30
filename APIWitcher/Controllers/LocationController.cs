using APIWitcher.Classes;
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
        [HttpGet]
        [Route("[action]")]
        public IEnumerable<Object> getLocationTypes()
        {
            var request = from locationType in _context.LocationTypes
                          select new
                          {
                              name = locationType.Name
                          };
            return request;
        }
        [HttpGet]
        [Route("[action]")]
        public IEnumerable<Object> getCountries()
        {
            var request = from country in _context.Countries
                          select new
                          {
                              name = country.Name
                          };
            return request;
        }
        
        [HttpPost]
        [Route("[action]")]
        public ActionResult<LocationView> PostLocation(LocationView location)
        {
            Image img = new Image() { Link = location.image };

            _context.Images.Add(img);

            Location lc = new Location()
            {
                Name = location.name,
                Description = location.description,
                IdtypeLocation = _context.LocationTypes.Where(x => x.Name == location.typeLocation).Select(y => y.Id).FirstOrDefault(),
                Idcountry = _context.Countries.Where(x => x.Name == location.country).Select(y => y.Id).FirstOrDefault(),
                IdimageNavigation = img
            };
            _context.Locations.Add(lc);
            _context.SaveChanges();
            var request = (from locations in _context.Locations
                          join typeLocation in _context.LocationTypes on locations.IdtypeLocation equals typeLocation.Id
                          join image in _context.Images on locations.Idimage equals image.Id
                          join country in _context.Countries on locations.Idcountry equals country.Id
                          where locations.Name == lc.Name 
                          select new
                          LocationView()
                          {
                              id = locations.Id,
                              name = locations.Name,
                              description = locations.Description,
                              typeLocation = typeLocation.Name,
                              country = country.Name,
                              image = image.Link
                          }).ToList();

            if (request.Count == 0)
            {
                return NotFound();
            }

            return new ObjectResult(request[0]);
        }
    }
}

