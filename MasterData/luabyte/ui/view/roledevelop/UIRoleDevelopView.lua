---自动生成代码----start----
local UIRoleDevelopView = BaseClass( 'UIRoleDevelopView' , BaseView )
local M = UIRoleDevelopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.charPicBtn = self:AddBaseCom( UIButton ,'charPicBtn')
  self.roleInfo =   self:AddValue('UI.Ctrl.RoleDevelop.NewRoleBaseInfoUICtrl','UI.View.RoleDevelop.NewRoleBaseInfoView','roleInfo')  
  self.anim =   self._binder:GetValue('anim')  
  self.breakClass =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','breakClass')  
  self.btnInfo = self:AddBaseCom( UINewButton ,'btnInfo')
  self.btnSkin = self:AddBaseCom( UINewButton ,'btnSkin')
  self.btnPreview = self:AddBaseCom( UINewButton ,'btnPreview')
  self.btnShare =   self._binder:GetValue('btnShare')  
  self.UICore2Ctrl =   self:AddValue('UI.Ctrl.RoleDevelop.UICore2Ctrl','UI.View.RoleDevelop.UICore2View','UICore2Ctrl')  
  self.UIAwakeClassCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.UIAwakeClassCtrl','UI.View.RoleDevelop.UIAwakeClassView','UIAwakeClassCtrl')  
  self.labLv1 = self:AddBaseCom( GameUIText ,'labLv1')
  self.labLv2 = self:AddBaseCom( GameUIText ,'labLv2')
  self.UIBreakCtrl =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','UIBreakCtrl')  
  self.statePos =   self._binder:GetValue('statePos')  
  self.UIGeneClassCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.UIGeneClassCtrl','UI.View.RoleDevelop.UIGeneClassView','UIGeneClassCtrl')  
  self.btnProfession = self:AddBaseCom( GameUIImage ,'btnProfession')
  self.CoreRedpoint =   self._binder:GetValue('CoreRedpoint')  
  self.GeneRedpoint =   self._binder:GetValue('GeneRedpoint')  
  self.AwakeRedpoint =   self._binder:GetValue('AwakeRedpoint')  
  self.infoRedPoint =   self._binder:GetValue('infoRedPoint')  
  self.tfCore =   self._binder:GetValue('tfCore')  
  self.UISkillClassCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.UISkillClassCtrl','UI.View.RoleDevelop.UISkillClassView','UISkillClassCtrl')  


end

return UIRoleDevelopView
---自动生成代码----end----