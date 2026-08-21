---自动生成代码----start----
local TeamChangeSkillItemView = BaseClass( 'TeamChangeSkillItemView' , BaseView )
local M = TeamChangeSkillItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.select =   self._binder:GetValue('select')  
  self.heroHead =   self._binder:GetValue('heroHead')  
  self.heroIcon = self:AddBaseCom( GameUIImage ,'heroIcon')
  self.skillIcon = self:AddBaseCom( GameUIImage ,'skillIcon')
  self.skillUp =   self._binder:GetValue('skillUp')  
  self.skillName = self:AddBaseCom( GameUIText ,'skillName')
  self.skillDesc = self:AddBaseCom( GameUIText ,'skillDesc')
  self.skillLevel = self:AddBaseCom( GameUIText ,'skillLevel')
  self.lockIcon =   self._binder:GetValue('lockIcon')  
  self.normalBtn =   self._binder:GetValue('normalBtn')  
  self.costIcon = self:AddBaseCom( GameUIImage ,'costIcon')
  self.skillCost =   self._binder:GetValue('skillCost')  
  self.castTime = self:AddBaseCom( GameUIText ,'castTime')


end

return TeamChangeSkillItemView
---自动生成代码----end----