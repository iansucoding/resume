using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AspNetMVCMusicStore.Models
{
    public class Cart
    {
        /* 這個類別中有一個 string identifier 稱為 CartId, 用來允許可匿名(先不用登入)購物.
         * 但是該類中有一個 integer primary key 稱為 RecordId, 根據慣例,  Entity Framework Code-First
         * 期望欄位名稱為 ID 或是 CartId(類別名稱+ID) 設定為 Key, 但是可以另外自行修改想要使用的 key
         */
        [Key]
        public int RecordId { get; set; }
        public string CartId { get; set; }
        public int AlbumId { get; set; }
        public int Count { get; set; }
        public System.DateTime DateCreated { get; set; }
        public virtual Album Album { get; set; }
    }
}