---自动生成代码----start----
local FirstRechargeItemView = BaseClass( 'FirstRechargeItemView' , BaseView )
local M = FirstRechargeItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.effect =   self._binder:GetValue('effect')  


end

return FirstRechargeItemView
---自动生成代码----end----