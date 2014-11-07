using Microsoft.Practices.Unity;
using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace AspNetMVCMusicStore.Factories
{
    public class UnityControllerFactory : IControllerFactory
    {
        private IUnityContainer _container;
        private IControllerFactory _innerFactor;

        public UnityControllerFactory(IUnityContainer container)
            : this(container, new DefaultControllerFactory()) // 呼叫本身另一個建構式 (外部沒有給自定的 IControllerFactory 時就使用原生的)
        { }

        protected UnityControllerFactory(IUnityContainer container, IControllerFactory innerFactor)
        {
            // Ioc 的設計，將生成物件的職責，交給 IUnityContainer 負責，至於 UnityContainer 實體物件，則交給外部決定
            _container = container;
            _innerFactor = innerFactor;
        }

        public IController CreateController(RequestContext requestContext, string controllerName)
        {
            // 當 Unity 可正常的產生所對應的 Controller 物件時，則回傳 UnityContainer 的結果
            // 若 UnityContainer 發生錯誤，則以傳入的 innerFactor 回傳的 Controller 為主
            // 若外部沒有設定 innerFactor，則 innerFactor 為 DefaultControllerFactory 物件
            try
            {
                return _container.Resolve<IController>(controllerName);
            }
            catch (Exception)
            {

                return _innerFactor.CreateController(requestContext, controllerName);
            }

        }

        public System.Web.SessionState.SessionStateBehavior GetControllerSessionBehavior(RequestContext requestContext, string controllerName)
        {
            return System.Web.SessionState.SessionStateBehavior.Default;
        }

        public void ReleaseController(IController controller)
        {
            _container.Teardown(controller);
        }
    }
}