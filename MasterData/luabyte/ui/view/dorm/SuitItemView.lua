---自动生成代码----start----
local SuitItemView = BaseClass( 'SuitItemView' , BaseView )
local M = SuitItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  


end

return SuitItemView
---自动生成代码----end----