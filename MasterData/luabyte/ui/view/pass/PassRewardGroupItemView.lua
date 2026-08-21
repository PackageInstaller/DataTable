---自动生成代码----start----
local PassRewardGroupItemView = BaseClass( 'PassRewardGroupItemView' , BaseView )
local M = PassRewardGroupItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return PassRewardGroupItemView
---自动生成代码----end----