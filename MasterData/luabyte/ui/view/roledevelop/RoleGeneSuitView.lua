---自动生成代码----start----
local RoleGeneSuitView = BaseClass( 'RoleGeneSuitView' , BaseView )
local M = RoleGeneSuitView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.curList =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectCtrl','UI.View.RoleDevelop.RoleGeneEffectView','curList')  
  self.nextList =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectCtrl','UI.View.RoleDevelop.RoleGeneEffectView','nextList')  
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')
  self.unLevelLockText = self:AddBaseCom( GameUIText ,'unLevelLockText')
  self.detailBtn =   self._binder:GetValue('detailBtn')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.nextNum = self:AddBaseCom( GameUIText ,'nextNum')
  self.activeBtn =   self._binder:GetValue('activeBtn')  
  self.dot =   self._binder:GetValue('dot')  
  self.lvTips =   self._binder:GetValue('lvTips')  
  self.lvTipNum = self:AddBaseCom( GameUIText ,'lvTipNum')


end

return RoleGeneSuitView
---自动生成代码----end----