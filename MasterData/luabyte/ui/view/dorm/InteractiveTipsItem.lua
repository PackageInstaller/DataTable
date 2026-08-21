---自动生成代码----start----
local InteractiveTipsItem = BaseClass( 'InteractiveTipsItem' , BaseView )
local M = InteractiveTipsItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Icon = self:AddBaseCom( GameUIImage ,'Icon')
  self.Text = self:AddBaseCom( GameUIText ,'Text')


end

return InteractiveTipsItem
---自动生成代码----end----