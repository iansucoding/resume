using AspNetMVCMusicStore.Models;
using System.Collections.Generic;

namespace AspNetMVCMusicStore.Services
{
    public interface IStoreService
    {
        IList<Genre> GetGenres();

        Genre GetGenreByName(string name);

        Album GetAlbum(int id);

        List<Genre> GetGenreMenu();

    }
}