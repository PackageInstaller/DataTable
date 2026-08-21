---自动生成代码----start----
local UICookItemHeroView = BaseClass( 'UICookItemHeroView' , BaseView )
local M = UICookItemHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateItem =   self._binder:GetValue('stateItem')  
  self.stateAddition =   self._binder:GetValue('stateAddition')  
  self.imgHero = self:AddBaseCom( GameUIImage ,'imgHero')
  self.txtHero = self:AddBaseCom( GameUIText ,'txtHero')
  self.stateSatiety =   self._binder:GetValue('stateSatiety')  
  self.sbarSatiety =   self._binder:GetValue('sbarSatiety')  
  self.txtSkill1 = self:AddBaseCom( GameUIText ,'txtSkill1')
  self.txtSkill2 = self:AddBaseCom( GameUIText ,'txtSkill2')
  self.stateSkill1 =   self._binder:GetValue('stateSkill1')  
  self.stateSkill2 =   self._binder:GetValue('stateSkill2')  


end

return UICookItemHeroView
---自动生成代码----end----