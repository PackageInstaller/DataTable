---自动生成代码----start----
local UIShopPackView = BaseClass( 'UIShopPackView' , BaseView )
local M = UIShopPackView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBuy = self:AddBaseCom( GameUIImage ,'btnBuy')
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.btnMask =   self._binder:GetValue('btnMask')  
  self.GiftPackItem =   self:AddValue('','UI.View.Shop.GiftPackItemView','GiftPackItem')  
  self.PropertyBar =   self._binder:GetValue('PropertyBar')  
  self.redpoint =   self._binder:GetValue('redpoint')  
  self.UIState =   self._binder:GetValue('UIState')  


end

return UIShopPackView
---自动生成代码----end----