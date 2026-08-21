---自动生成代码----start----
local JourneyFoodItemView = BaseClass( 'JourneyFoodItemView' , BaseView )
local M = JourneyFoodItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.addBtn =   self._binder:GetValue('addBtn')  
  self.item =   self._binder:GetValue('item')  


end

return JourneyFoodItemView
---自动生成代码----end----