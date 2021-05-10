using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWitcher.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PotionController : Controller
    {
        private readonly WitcherDBContext _context;

        public PotionController(WitcherDBContext context)
        {
            _context = context;
        }
        [Route("[action]")]
        [HttpGet]
        public IEnumerable<Object> Elixirs()
        {
            var request = from potions in _context.Potions
                          join potionType in _context.PotionTypes on potions.IdpotionType equals potionType.Id
                          join image in _context.Images on potions.Idimage equals image.Id
                          where potionType.Name == "Эликсир"
                          select new
                          {
                              id = potions.Id,
                              name = potions.Name,
                              potionType = potionType.Name,
                              description = potions.Description,
                              image = image.Link,

                          };
            return request;
        }
        [Route("[action]/name/{name}")]
        [HttpGet]
        public IEnumerable<Object> Elixirs(string name)
        {
            var request = from potions in _context.Potions
                          join potionType in _context.PotionTypes on potions.IdpotionType equals potionType.Id
                          join image in _context.Images on potions.Idimage equals image.Id
                          where potions.Name == name && potionType.Name == "Эликсир"
                          select new
                          {
                              id = potions.Id,
                              name = potions.Name,
                              potionType = potionType.Name,
                              description = potions.Description,
                              image = image.Link,

                          };
            return request;
        }
        [HttpGet]
        [Route("[action]/{id}")]
        public IEnumerable<Object> GetIngredientsId(int id)
        {
            var request = from potionStructure in _context.PotionStructures
                          join ingredients in _context.Ingredients on potionStructure.Idingredient equals ingredients.Id
                          where potionStructure.Idpotion == id
                          select new
                          {
                              name = ingredients.Name,
                              value = potionStructure.Value
                          };
            return request;
        }

        [HttpGet]
        [Route("[action]/{name}")]
        public IEnumerable<Object> GetIngredientsName(string name)
        {
            var request = from potionStructure in _context.PotionStructures
                          join ingredients in _context.Ingredients on potionStructure.Idingredient equals ingredients.Id
                          join potion in _context.Potions on potionStructure.Idpotion equals potion.Id
                          where potion.Name == name
                          select new
                          {
                              name = ingredients.Name,
                              value = potionStructure.Value
                          };
            return request;
        }

        [Route("[action]")]
        [HttpGet]
        public IEnumerable<Object> Decotions()
        {
            var request = from potions in _context.Potions
                          join potionType in _context.PotionTypes on potions.IdpotionType equals potionType.Id
                          join image in _context.Images on potions.Idimage equals image.Id
                          where potionType.Name == "Отвар"
                          select new
                          {
                              id = potions.Id,
                              name = potions.Name,
                              potionType = potionType.Name,
                              description = potions.Description,
                              image = image.Link,

                          };
            return request;
        }
        [Route("[action]/name/{name}")]
        [HttpGet]
        public IEnumerable<Object> Decotions(string name)
        {
            var request = from potions in _context.Potions
                          join potionType in _context.PotionTypes on potions.IdpotionType equals potionType.Id
                          join image in _context.Images on potions.Idimage equals image.Id
                          where potions.Name == name && potionType.Name == "Отвар"
                          select new
                          {
                              id = potions.Id,
                              name = potions.Name,
                              potionType = potionType.Name,
                              description = potions.Description,
                              image = image.Link,

                          };
            return request;
        }
    }
}
