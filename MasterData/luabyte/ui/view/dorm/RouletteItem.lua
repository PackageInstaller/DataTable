---自动生成代码----start----
local RouletteItem = BaseClass( 'RouletteItem' , BaseView )
local M = RouletteItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Icon = self:AddBaseCom( GameUIImage ,'Icon')
  self.Text = self:AddBaseCom( GameUIText ,'Text')


end

return RouletteItem
---自动生成代码----end----