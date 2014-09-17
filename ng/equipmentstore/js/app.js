(function(){
   var _swords = [  
   {  
      "name":"木劍",
      "enname":"Wood Sword",
      "attack":1,
      "image":"images/swords/woodsword.gif"
   },
   {  
      "name":"學徒劍",
      "enname":"Apprentice Sword",
      "attack":2,
      "image":"images/swords/apprenticesword.gif"
   },
   {  
      "name":"彎刀",
      "enname":"Scimitar",
      "attack":3,
      "image":"images/swords/scimitar.gif"
   },
   {  
      "name":"軍刀",
      "enname":"Sabre",
      "attack":4,
      "image":"images/swords/sabre.gif"
   },
   {  
      "name":"寬劍",
      "enname":"Broad Sword",
      "attack":8,
      "image":"images/swords/broadsword.gif"
   },
   {  
      "name":"重劍",
      "enname":"Bastard Sword",
      "attack":12,
      "image":"images/swords/bastardsword.gif"
   },
   {  
      "name":"符文劍",
      "enname":"Rune Sword",
      "attack":24,
      "image":"images/swords/runesword.gif"
   },
   {  
      "name":"屠龍劍",
      "enname":"Dragon Buster",
      "attack":32,
      "image":"images/swords/dragonbuster.gif"
   }
   ];

   var _helms = [
   {
      "name":"頭巾",
      "enname":"Bandanna",
      "defense":1,
      "image":"images/helms/bandanna.gif"
   },
   {
      "name":"頭罩",
      "enname":"Quilted Hood",
      "defense":2,
      "image":"images/helms/quiltedhood.gif"
   },
   {
      "name":"皮甲頭盔",
      "enname":"Leather Helm",
      "defense":4,
      "image":"images/helms/leatherhelm.gif"
   },
   {
      "name":"鐵盔",
      "enname":"Iron Cap",
      "defense":8,
      "image":"images/helms/ironcap.gif"
   },
   {
      "name":"鋼盔",
      "enname":"Steel Cap",
      "defense":16,
      "image":"images/helms/steelcap.gif"
   },
   {
      "name":"龍頭盔",
      "enname":"Dragon Helm",
      "defense":32,
      "image":"images/helms/dragonhelm.gif"
   }
   ]; 
   var _armors = [
   {
      "name":"布外套",
      "enname":"Cloth Tunic",
      "defense":1,
      "image":"images/armors/clothtunic.gif"
   },
   {
      "name":"皮革背心",
      "enname":"Leather Vest",
      "defense":3,
      "image":"images/armors/leathervest.gif"
   },
   {
      "name":"鋼背心",
      "enname":"Steel Vest",
      "defense":6,
      "image":"images/armors/steelvest.gif"
   },
   {
      "name":"鎖子甲",
      "enname":"Brigandine",
      "defense":10,
      "image":"images/armors/brigandine.gif"
   },
   {
      "name":"末日護甲",
      "enname":"Doom Armor",
      "defense":15,
      "image":"images/armors/doomarmor.gif"
   },
   {
      "name":"龍盔甲",
      "enname":"Dragon Armor",
      "defense":20,
      "image":"images/armors/dragonarmor.gif"
   }

   ];  
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
         currentHelmObj = _helms.filter(function(obj) {
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
         currentArmorObj = _armors.filter(function(obj) {
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
      //$scope.swords = $http.get('js/sword.json'); 
      $scope.swords = _swords;
      $scope.getSword = function(i, name){
         // 往上發送資料讓 $on 接收
         $scope.$emit('getSword', {attack:i,name:name}); // going up!
      };
   });
   // 頭盔
   app.controller('HelmCtrl',function($scope,$http){
      //$scope.swords = $http.get('js/helm.json'); 
      $scope.helms = _helms;
      $scope.getHelm = function(i, name){
         // 往上發送資料讓 $on 接收
         $scope.$emit('getHelm', {defense:i,name:name}); // going up!
      };
   });
   // 盔甲
   app.controller('ArmorCtrl',function($scope,$http){
      //$scope.armors = $http.get('js/armor.json'); 
      $scope.armors = _armors;
      $scope.getArmor = function(i, name){
         // 往上發送資料讓 $on 接收
         $scope.$emit('getArmor', {defense:i,name:name}); // going up!
      };

   });
})();