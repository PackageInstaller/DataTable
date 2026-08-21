---自动生成代码----start----
local Style03Image_TextView = BaseClass( 'Style03Image_TextView' , BaseView )
local M = Style03Image_TextView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Desc = self:AddBaseCom( GameUIText ,'Desc')
  self.Title = self:AddBaseCom( GameUIText ,'Title')


end

return Style03Image_TextView
---自动生成代码----end----