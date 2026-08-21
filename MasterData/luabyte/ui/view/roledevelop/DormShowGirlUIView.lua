---自动生成代码----start----
local DormShowGirlUIView = BaseClass( 'DormShowGirlUIView' , BaseView )
local M = DormShowGirlUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.pic1 = self:AddBaseCom( GameRawImage ,'pic1')
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return DormShowGirlUIView
---自动生成代码----end----