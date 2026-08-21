---自动生成代码----start----
local OtakuSettleHeroItemView = BaseClass( 'OtakuSettleHeroItemView' , BaseView )
local M = OtakuSettleHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateItem =   self._binder:GetValue('stateItem')  
  self.imgHero = self:AddBaseCom( GameUIImage ,'imgHero')
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')
  self.txtCurSatiety = self:AddBaseCom( GameUIText ,'txtCurSatiety')
  self.txtMaxSatiety = self:AddBaseCom( GameUIText ,'txtMaxSatiety')
  self.sbarSatiety =   self._binder:GetValue('sbarSatiety')  
  self.stateSatiety =   self._binder:GetValue('stateSatiety')  
  self.txtLockLevel = self:AddBaseCom( GameUIText ,'txtLockLevel')
  self.eat =   self._binder:GetValue('eat')  


end

return OtakuSettleHeroItemView
---自动生成代码----end----