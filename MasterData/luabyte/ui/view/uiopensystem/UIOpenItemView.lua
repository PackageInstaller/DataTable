---自动生成代码----start----
local UIOpenItemView = BaseClass( 'UIOpenItemView' , BaseView )
local M = UIOpenItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labDes = self:AddBaseCom( GameUIText ,'labDes')


end

return UIOpenItemView
---自动生成代码----end----