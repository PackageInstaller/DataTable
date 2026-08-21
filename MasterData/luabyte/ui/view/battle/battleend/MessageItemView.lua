---自动生成代码----start----
local MessageItemView = BaseClass( 'MessageItemView' , BaseView )
local M = MessageItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.text = self:AddBaseCom( GameUIText ,'text')


end

return MessageItemView
---自动生成代码----end----