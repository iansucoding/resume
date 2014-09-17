(function(){
   // 主人公
   var _hero = {
      name:"主人公",
      attack:0,
      defense:0,
      weapon:'',
      helm:'',
      armor:'',
   };
   var app = angular.module('equipStore', ['ngRoute'],function($routeProvider){
      $routeProvider.when('/',{
         templateUrl:'swords.html',
         controller:'SwordCtrl'
      }).when('/helms',{
         templateUrl:'helms.html',
         controller:'HelmCtrl'
      }).when('/armors',{
         templateUrl:'armors.html',
         controller:'ArmorCtrl'
      }).otherwise({
         redirectTo:'/'
      });

   });
   // 商店
   app.controller('StoreCtrl', function($scope,$http){
      $scope.hero = _hero;
      $http.get('js/armor.json').success(function(data){
         $scope.armors = data;
      }); 
      $http.get('js/helm.json').success(function(data){
         $scope.helms = data;
      });  
      // 接收資料
      // 參考：http://toddmotto.com/all-about-angulars-emit-broadcast-on-publish-subscribing/
      $scope.$on('getSword', function (event, data) {
         var currentAttack = $scope.hero.attack,// 未更換裝備前的攻擊力
             diffAttack = parseInt(data.attack,10) - currentAttack ; // 更換裝備後, 攻擊力提升或是下降的數據
             console.log('取得武器"'+ data.name +'(攻擊力 ' + data.attack + ')", 攻擊力提升了 ' + diffAttack + ' 點');
             $scope.hero.attack = data.attack;
             $scope.hero.weapon = data.name;
          });
      $scope.$on('getHelm', function (event, data) {
         var currentDefense = $scope.hero.defense, // 未更換裝備前的防禦力
         currentHelmObj = $scope.helms.filter(function(obj) {
            return obj.name === $scope.hero.helm;
             })[0], // 目前的頭盔物件
             currentHelmDefense = currentHelmObj===undefined?0:currentHelmObj.defense; // 目前的頭盔物件的防禦力
             diffDefense = data.defense - currentHelmDefense ;
         //console.log(xxx=currentHelmObj);
         console.log('取得頭盔 "'+ data.name +'(防禦力 ' + data.defense+')", 防禦力提升了 ' + diffDefense + ' 點'); 
         $scope.hero.helm = data.name;
         $scope.hero.defense = currentDefense + diffDefense;
      });
      $scope.$on('getArmor', function (event, data) {
         var currentDefense = $scope.hero.defense, // 未更換裝備前的防禦力
         currentArmorObj = $scope.armors.filter(function(obj) {
            return obj.name === $scope.hero.armor;
             })[0], // 目前的盔甲物件
             currentArmorDefense = currentArmorObj===undefined?0:currentArmorObj.defense; // 目前的盔甲物件的防禦力
             diffDefense = data.defense - currentArmorDefense ;
         //console.log(xxx=currentHelmObj);
         console.log('取得盔甲 "'+ data.name +'(防禦力 ' + data.defense+')", 防禦力提升了 ' + diffDefense + ' 點'); 
         $scope.hero.armor = data.name;
         $scope.hero.defense = currentDefense + diffDefense;
      });
   });
   // 刀劍
   app.controller('SwordCtrl',function($scope,$http){
      $http.get('js/sword.json').success(function(data){
         $scope.swords = data;
      }); 
      $scope.getSword = function(i, name){
         // 往上發送資料讓 $on 接收
         $scope.$emit('getSword', {attack:i,name:name}); // going up!
      };
   });
   // 頭盔
   app.controller('HelmCtrl',function($scope,$http){
      $http.get('js/helm.json').success(function(data){
         $scope.helms = data;
      });  
      $scope.getHelm = function(i, name){
         // 往上發送資料讓 $on 接收
         $scope.$emit('getHelm', {defense:i,name:name}); // going up!
      };
   });
   // 盔甲
   app.controller('ArmorCtrl',function($scope,$http){
      $http.get('js/armor.json').success(function(data){
         $scope.armors = data;
      });  
      $scope.getArmor = function(i, name){
         // 往上發送資料讓 $on 接收
         $scope.$emit('getArmor', {defense:i,name:name}); // going up!
      };

   });
})();