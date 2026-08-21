---自动生成代码----start----
local MaterialsItemUI = BaseClass( 'MaterialsItemUI' , BaseView )
local M = MaterialsItemUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.item =   self._binder:GetValue('item')  


end

return MaterialsItemUI
---自动生成代码----end----