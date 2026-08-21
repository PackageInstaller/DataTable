---自动生成代码----start----
local RestaurantRootUIView = BaseClass( 'RestaurantRootUIView' , BaseView )
local M = RestaurantRootUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.OtakuTitlePanel =   self:AddValue('UI.Ctrl.Otaku.OtakuTitleCtrl','UI.View.Otaku.OtakuTitleView','OtakuTitlePanel')  
  self.UIPosItemCtrl =   self:AddValue('UI.Ctrl.Restaurant.UIPosItemCtrl','UI.View.Restaurant.UIPosItemView','UIPosItemCtrl')  
  self.btnStart = self:AddBaseCom( GameUIImage ,'btnStart')
  self.tfStar =   self._binder:GetValue('tfStar')  
  self.imgFood = self:AddBaseCom( GameUIImage ,'imgFood')


end

return RestaurantRootUIView
---自动生成代码----end----