---自动生成代码----start----
local DormitoryDressupAreaItem = BaseClass( 'DormitoryDressupAreaItem' , BaseView )
local M = DormitoryDressupAreaItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.label = self:AddBaseCom( GameUIText ,'label')
  self.Item =   self._binder:GetValue('Item')  
  self.Rect =   self._binder:GetValue('Rect')  
  self.Redpoint =   self._binder:GetValue('Redpoint')  


end

return DormitoryDressupAreaItem
---自动生成代码----end----