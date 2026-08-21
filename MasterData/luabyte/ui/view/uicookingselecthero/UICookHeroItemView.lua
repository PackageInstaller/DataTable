---自动生成代码----start----
local UICookHeroItemView = BaseClass( 'UICookHeroItemView' , BaseView )
local M = UICookHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroHeadItem =   self._binder:GetValue('HeroHeadItem')  
  self.hunger =   self._binder:GetValue('hunger')  
  self.roomInfo = self:AddBaseCom( GameUIText ,'roomInfo')
  self.roomArea =   self._binder:GetValue('roomArea')  
  self.working =   self._binder:GetValue('working')  
  self.slider =   self._binder:GetValue('slider')  
  self.sliderColor = self:AddBaseCom( GameUIImage ,'sliderColor')


end

return UICookHeroItemView
---自动生成代码----end----