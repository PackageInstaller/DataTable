---自动生成代码----start----
local SelectHeroUIView = BaseClass( 'SelectHeroUIView' , BaseView )
local M = SelectHeroUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.toggle1 = self:AddBaseCom( UIToggle ,'toggle1')
  self.toggle2 = self:AddBaseCom( UIToggle ,'toggle2')
  self.toggle3 = self:AddBaseCom( UIToggle ,'toggle3')
  self.toggle4 = self:AddBaseCom( UIToggle ,'toggle4')
  self.toggle5 = self:AddBaseCom( UIToggle ,'toggle5')
  self.toggle6 = self:AddBaseCom( UIToggle ,'toggle6')
  self.toggle7 = self:AddBaseCom( UIToggle ,'toggle7')
  self.looplist = self._binder:GetValue('looplist')
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  
  self.btn_close =   self._binder:GetValue('btn_close')  
  self.animDelay =   self._binder:GetValue('animDelay')  


end

return SelectHeroUIView
---自动生成代码----end----