namespace AspNetMVCMusicStore.Models
{
    using System;
    using System.Data.Entity;
    using System.Linq;

    public class MusicStoreEntities : DbContext
    {
        // 您的內容已設定為使用應用程式組態檔 (App.config 或 Web.config)
        // 中的 'Model1' 連接字串。根據預設，這個連接字串的目標是
        // 您的 LocalDb 執行個體上的 'AspNetMVCMusicStore.Models.Model1' 資料庫。
        // 
        // 如果您的目標是其他資料庫和 (或) 提供者，請修改
        // 應用程式組態檔中的 'Model1' 連接字串。
        public MusicStoreEntities()
            : base("name=MusicStoreConnection")
        {
        }

        // 針對您要包含在模型中的每種實體類型新增 DbSet。如需有關設定和使用
        // Code First 模型的詳細資訊，請參閱 http://go.microsoft.com/fwlink/?LinkId=390109。

        public DbSet<Album> Albums { get; set; }
        public DbSet<Genre> Genres { get; set; }

        public DbSet<Artist> Artists { get; set; }

        public DbSet<Cart>Carts { get; set; }
        public DbSet<Order> Orders{ get; set; }
        public DbSet<OrderDetail>OrderDetails { get; set; }
    }
}