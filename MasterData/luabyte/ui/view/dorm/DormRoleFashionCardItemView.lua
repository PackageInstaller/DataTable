---自动生成代码----start----
local DormRoleFashionCardItemView = BaseClass( 'DormRoleFashionCardItemView' , BaseView )
local M = DormRoleFashionCardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.arrowSelect =   self._binder:GetValue('arrowSelect')  
  self.rawImg = self:AddBaseCom( GameRawImage ,'rawImg')
  self.item =   self._binder:GetValue('item')  


end

return DormRoleFashionCardItemView
---自动生成代码----end----