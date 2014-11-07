using AspNetMVCMusicStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AspNetMVCMusicStore.ViewModels
{
    public class ShoppingCartViewModel
    {
        public List<Cart> CartItems { get; set; }
        public decimal CartTotal { get; set; }
    }
}