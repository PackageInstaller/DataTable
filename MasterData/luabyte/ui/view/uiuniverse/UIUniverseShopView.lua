---自动生成代码----start----
local UIUniverseShopView = BaseClass( 'UIUniverseShopView' , BaseView )
local M = UIUniverseShopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack = self:AddBaseCom( GameUIImage ,'btnBack')
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.propertyBar =   self._binder:GetValue('propertyBar')  


end

return UIUniverseShopView
---自动生成代码----end----