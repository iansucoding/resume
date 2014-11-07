using AspNetMVCMusicStore.Controllers;
using AspNetMVCMusicStore.Factories;
using AspNetMVCMusicStore.Services;
using Microsoft.Practices.Unity;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace AspNetMVCMusicStore
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            System.Data.Entity.Database.SetInitializer(new MvcMusicStore.Models.SampleData());
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // 建立 UnityContainer，也就是 Builder 角色
            var container = new UnityContainer();

            // 註冊介面對應的實體類別
            container.RegisterType<IStoreService, StoreService>();

            // 當外部呼叫 IControllerFactory 的 CreateController 方法時，若傳入的 controllerName 為 "Store"，則回傳 StoreController
            container.RegisterType<IController, StoreController>("Store");

            // 建立 UnityControllerFactory，並將剛剛的 UnityContainer 注入，代表 Controller 的生成，交由上面的 UnityContainer 負責
            var factory = new UnityControllerFactory(container);

            // 設定要使用的 ControllerFactory 為 UnityControllerFactory
            ControllerBuilder.Current.SetControllerFactory(factory);
        }
    }
}