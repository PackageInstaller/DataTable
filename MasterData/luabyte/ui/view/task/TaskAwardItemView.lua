---自动生成代码----start----
local TaskAwardItemView = BaseClass( 'TaskAwardItemView' , BaseView )
local M = TaskAwardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.quality = self:AddBaseCom( GameUIImage ,'quality')
  self.numberTf = self:AddBaseCom( GameUIText ,'numberTf')
  self.select =   self._binder:GetValue('select')  


end

return TaskAwardItemView
---自动生成代码----end----