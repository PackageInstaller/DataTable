---自动生成代码----start----
local UICookItemView = BaseClass( 'UICookItemView' , BaseView )
local M = UICookItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')


end

return UICookItemView
---自动生成代码----end----