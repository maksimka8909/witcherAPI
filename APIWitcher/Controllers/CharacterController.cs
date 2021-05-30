using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWitcher.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CharacterController : Controller
    {
        private readonly WitcherDBContext _context;

        public CharacterController(WitcherDBContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IEnumerable<Object> Characters()
        {
            var request = from characters in _context.Characters
                          join race in _context.Races on characters.Idrace equals race.Id
                          join image in _context.Images on characters.Idimage equals image.Id
                          join activity in _context.Activities on characters.Idactivity equals activity.Id
                          select new
                          {
                              id = characters.Id,
                              name = characters.Name,
                              race = race.Name,
                              activity = activity.Name,
                              description = characters.Description,
                              image = image.Link
                          };
            return request;
        }
        [HttpGet]
        [Route("[action]/{name}")]
        public IEnumerable<Object> Name(string name)
        {
            var request = from characters in _context.Characters
                          join race in _context.Races on characters.Idrace equals race.Id
                          join image in _context.Images on characters.Idimage equals image.Id
                          join activity in _context.Activities on characters.Idactivity equals activity.Id
                          where characters.Name == name
                          select new
                          {
                              id = characters.Id,
                              name = characters.Name,
                              race = race.Name,
                              activity = activity.Name,
                              description = characters.Description,
                              image = image.Link
                          };
            return request;
        }

    }
        
}
