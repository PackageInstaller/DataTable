---自动生成代码----start----
local OtakuHeroItemUI = BaseClass( 'OtakuHeroItemUI' , BaseView )
local M = OtakuHeroItemUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Normal =   self._binder:GetValue('Normal')  
  self.Plus =   self._binder:GetValue('Plus')  
  self.Lock =   self._binder:GetValue('Lock')  
  self.Icon = self:AddBaseCom( GameUIImage ,'Icon')
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.valueLabel = self:AddBaseCom( GameUIText ,'valueLabel')
  self.valueSlider = self:AddBaseCom( UISlider ,'valueSlider')
  self.leave = self:AddBaseCom( GameUIImage ,'leave')
  self.work = self:AddBaseCom( GameUIImage ,'work')
  self.hunger = self:AddBaseCom( GameUIImage ,'hunger')


end

return OtakuHeroItemUI
---自动生成代码----end----