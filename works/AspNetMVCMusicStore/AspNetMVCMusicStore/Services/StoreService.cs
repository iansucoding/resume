using AspNetMVCMusicStore.Models;
using System.Collections.Generic;
using System.Linq;

namespace AspNetMVCMusicStore.Services
{
    public class StoreService : IStoreService
    {
        private MusicStoreEntities storeDB = new MusicStoreEntities();

        public IList<Genre> GetGenres()
        {
            var genres = from genre in storeDB.Genres
                         select genre;
            return genres.ToList();
        }

        public Genre GetGenreByName(string name)
        {
            var genre = storeDB.Genres.Include("Albums").Single(g => g.Name == name);
            return genre;
        }

        public Album GetAlbum(int id)
        {
            var album = storeDB.Albums.Single(a => a.AlbumId == id);
            return album;
        }
        public List<Genre> GetGenreMenu()
        {
            var genres = storeDB.Genres.ToList();
            return genres;
        }
    }
}