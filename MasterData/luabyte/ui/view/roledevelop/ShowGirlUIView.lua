---自动生成代码----start----
local ShowGirlUIView = BaseClass( 'ShowGirlUIView' , BaseView )
local M = ShowGirlUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.picContent =   self._binder:GetValue('picContent')  
  self.pic1 = self:AddBaseCom( GameRawImage ,'pic1')
  self.pic3 = self:AddBaseCom( GameRawImage ,'pic3')
  self.pic2 = self:AddBaseCom( GameRawImage ,'pic2')
  self.illustrationGo =   self._binder:GetValue('illustrationGo')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.scrollHelper =   self._binder:GetValue('scrollHelper')  
  self.Arrow =   self._binder:GetValue('Arrow')  


end

return ShowGirlUIView
---自动生成代码----end----