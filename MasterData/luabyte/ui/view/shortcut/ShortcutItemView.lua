---自动生成代码----start----
local ShortcutItemView = BaseClass( 'ShortcutItemView' , BaseView )
local M = ShortcutItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.label = self:AddBaseCom( GameUIText ,'label')

  self.jumpId = self:GetBaseValue('jumpId')
end

return ShortcutItemView
---自动生成代码----end----