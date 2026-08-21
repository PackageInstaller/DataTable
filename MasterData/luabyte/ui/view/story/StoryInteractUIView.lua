---自动生成代码----start----
local StoryInteractUIView = BaseClass( 'StoryInteractUIView' , BaseView )
local M = StoryInteractUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtRatio = self:AddBaseCom( GameUIText ,'txtRatio')
  self.sliderWipe = self:AddBaseCom( UISlider ,'sliderWipe')
  self.sliderPower = self:AddBaseCom( UISlider ,'sliderPower')
  self.rectPress =   self._binder:GetValue('rectPress')  
  self.animFinger =   self._binder:GetValue('animFinger')  
  self.rectWipeGuide =   self._binder:GetValue('rectWipeGuide')  
  self.rectPressGuide =   self._binder:GetValue('rectPressGuide')  


end

return StoryInteractUIView
---自动生成代码----end----