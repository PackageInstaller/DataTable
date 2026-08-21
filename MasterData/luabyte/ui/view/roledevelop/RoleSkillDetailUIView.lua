---自动生成代码----start----
local RoleSkillDetailUIView = BaseClass( 'RoleSkillDetailUIView' , BaseView )
local M = RoleSkillDetailUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.lifePanel =   self._binder:GetValue('lifePanel')  
  self.icon1 = self:AddBaseCom( GameUIImage ,'icon1')
  self.skillCost = self:AddBaseCom( GameUIText ,'skillCost')
  self.skillName1 = self:AddBaseCom( GameUIText ,'skillName1')
  self.skillMold = self:AddBaseCom( GameUIText ,'skillMold')
  self.skillType = self:AddBaseCom( GameUIText ,'skillType')
  self.skillLv = self:AddBaseCom( GameUIText ,'skillLv')
  self.curDesc = self:AddBaseCom( EmojiText ,'curDesc')
  self.nextDesc = self:AddBaseCom( EmojiText ,'nextDesc')
  self.nextDescTitleGo =   self._binder:GetValue('nextDescTitleGo')  
  self.nextDescGo =   self._binder:GetValue('nextDescGo')  
  self.skillCostGo =   self._binder:GetValue('skillCostGo')  
  self.powerTip =   self._binder:GetValue('powerTip')  
  self.powerText = self:AddBaseCom( GameUIText ,'powerText')
  self.ClickHelp =   self._binder:GetValue('ClickHelp')  
  self.tfMask =   self._binder:GetValue('tfMask')  
  self.ItemEquipPosCtrl =   self._binder:GetValue('ItemEquipPosCtrl')  
  self.tfContent =   self._binder:GetValue('tfContent')  
  self.tfMod =   self._binder:GetValue('tfMod')  
  self.tfType =   self._binder:GetValue('tfType')  
  self.icon2 = self:AddBaseCom( GameUIImage ,'icon2')
  self.skillName2 = self:AddBaseCom( GameUIText ,'skillName2')
  self.tfSkill1 =   self._binder:GetValue('tfSkill1')  
  self.tfSkill2 =   self._binder:GetValue('tfSkill2')  


end

return RoleSkillDetailUIView
---自动生成代码----end----