---自动生成代码----start----
local UIAdvancedItemView = BaseClass( 'UIAdvancedItemView' , BaseView )
local M = UIAdvancedItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.sprIcon = self:AddBaseCom( GameUIImage ,'sprIcon')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labNum1 = self:AddBaseCom( GameUIText ,'labNum1')
  self.labNum2 = self:AddBaseCom( GameUIText ,'labNum2')


end

return UIAdvancedItemView
---自动生成代码----end----