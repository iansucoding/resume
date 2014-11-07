using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
namespace AspNetMVCMusicStore.Models
{
    [Bind(Exclude = "AlbumId")] // Lists fields to exclude or include when binding parameter or form values to model properties
    public class Album
    {
        [ScaffoldColumn(false)] // Allows hiding fields from editor forms
        public int AlbumId { get; set; }

        [DisplayName("Genre")]
        public int GenreId { get; set; }
        [DisplayName("Artist")]
        public int ArtistId { get; set; }
        [Required(ErrorMessage = "An Album Title is required")]
        [StringLength(160)]
        public string Title { get; set; }
        [Required(ErrorMessage = "Price is required")]
        [Range(0.01, 100.00,
            ErrorMessage = "Price must be between 0.01 and 100.00")]
        public decimal Price { get; set; }
        [DisplayName("Album Art URL")]
        [StringLength(1024)]
        public string AlbumArtUrl { get; set; }

        public virtual Genre Genre { get; set; } //  virtual property. This allows Entity Framework to lazy-load them as necessary

        public virtual  Artist Artist { get; set; }

        public virtual List<OrderDetail> OrderDetails { get; set; }
    }
}