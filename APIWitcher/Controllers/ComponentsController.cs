using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using APIWitcher;

namespace APIWitcher.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ComponentsController : ControllerBase
    {
        private readonly WitcherDBContext _context;

        public ComponentsController(WitcherDBContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IEnumerable<Object> Components()
        {
            var request = from component in _context.Components
                          select new { id = component.Id, name = component.Name };
            return request;
        }
        [HttpGet]
        [Route("{id}")]
        public ActionResult<Component> Components(int id)
        {
            var request = from component in _context.Components
                          where component.Id == id
                          select component;
            if (request.Count() == 0) return NotFound();
            return new ObjectResult(request);
        }
    }
}
