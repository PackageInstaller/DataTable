---自动生成代码----start----
local KitChenItemView = BaseClass( 'KitChenItemView' , BaseView )
local M = KitChenItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')


end

return KitChenItemView
---自动生成代码----end----