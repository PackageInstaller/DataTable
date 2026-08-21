---自动生成代码----start----
local BridgeCmdSkillItemView = BaseClass( 'BridgeCmdSkillItemView' , BaseView )
local M = BridgeCmdSkillItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.lockMask =   self._binder:GetValue('lockMask')  
  self.skillIcon = self:AddBaseCom( GameUIImage ,'skillIcon')
  self.skillName = self:AddBaseCom( GameUIText ,'skillName')
  self.skillUp =   self._binder:GetValue('skillUp')  
  self.skillLevel = self:AddBaseCom( GameUIText ,'skillLevel')
  self.skillDesc = self:AddBaseCom( GameUIText ,'skillDesc')
  self.heroHead = self:AddBaseCom( GameUIImage ,'heroHead')
  self.heroIcon = self:AddBaseCom( GameUIImage ,'heroIcon')
  self.skillTog = self:AddBaseCom( UIToggle ,'skillTog')
  self.itemState =   self._binder:GetValue('itemState')  


end

return BridgeCmdSkillItemView
---自动生成代码----end----