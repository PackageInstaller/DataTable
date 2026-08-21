---自动生成代码----start----
local UIMasqueradeShopView = BaseClass( 'UIMasqueradeShopView' , BaseView )
local M = UIMasqueradeShopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack =   self._binder:GetValue('btnBack')  
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.propertyBar =   self._binder:GetValue('propertyBar')  
  self.ScrollRect = self:AddBaseCom( UIScrollView ,'ScrollRect')
  self.tfLeft =   self._binder:GetValue('tfLeft')  
  self.tfRight =   self._binder:GetValue('tfRight')  


end

return UIMasqueradeShopView
---自动生成代码----end----