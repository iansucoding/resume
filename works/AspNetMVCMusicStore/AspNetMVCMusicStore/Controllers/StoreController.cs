using AspNetMVCMusicStore.Models;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using AspNetMVCMusicStore.Services;

namespace AspNetMVCMusicStore.Controllers
{
    public class StoreController : Controller
    {
        private IStoreService service;
        public StoreController(IStoreService service)
        {
            this.service = service;
        }
        // GET: Store
        public ActionResult Index()
        {

            // create list of genres
            var genres = this.service.GetGenres();
            return View(genres);
        }

        public ActionResult Browse(string genre)
        {
            // Retrieve Genre and its Associated Albums from database
            var genreModel = this.service.GetGenreByName(genre);
            return View(genreModel);
        }

        public ActionResult Detail(int id)
        {
            var album = this.service.GetAlbum(id);
            return View(album);
        }
        //
        // GET: /Store/GenreMenu
        [ChildActionOnly]
        public ActionResult GenreMenu()
        {
            var genres = this.service.GetGenreMenu();
            return PartialView(genres);
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                //storeDB.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}