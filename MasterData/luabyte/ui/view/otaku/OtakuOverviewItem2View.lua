---自动生成代码----start----
local OtakuOverviewItem2View = BaseClass( 'OtakuOverviewItem2View' , BaseView )
local M = OtakuOverviewItem2View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectState =   self._binder:GetValue('selectState')  
  self.roleNumState =   self._binder:GetValue('roleNumState')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.OtakuCookHeroItemCtrl =   self:AddValue('UI.Ctrl.Restaurant.RestaurantItemCtrl','UI.View.Restaurant.RestaurantItemView','OtakuCookHeroItemCtrl')  
  self.clickBtn =   self._binder:GetValue('clickBtn')  


end

return OtakuOverviewItem2View
---自动生成代码----end----