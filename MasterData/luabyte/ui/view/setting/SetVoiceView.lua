---自动生成代码----start----
local SetVoiceView = BaseClass( 'SetVoiceView' , BaseView )
local M = SetVoiceView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tg_backGroudSound = self:AddBaseCom( UIToggle ,'tg_backGroudSound')
  self.tg_sound = self:AddBaseCom( UIToggle ,'tg_sound')
  self.tg_speech = self:AddBaseCom( UIToggle ,'tg_speech')
  self.slider_backGround = self:AddBaseCom( UISlider ,'slider_backGround')
  self.slider_sound = self:AddBaseCom( UISlider ,'slider_sound')
  self.slider_speech = self:AddBaseCom( UISlider ,'slider_speech')


end

return SetVoiceView
---自动生成代码----end----