---自动生成代码----start----
local RoleGeneView = BaseClass( 'RoleGeneView' , BaseView )
local M = RoleGeneView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.panelState =   self._binder:GetValue('panelState')  
  self.suitPanel =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneSuitCtrl','UI.View.RoleDevelop.RoleGeneSuitView','suitPanel')  
  self.detailPanel =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneDetailCtrl','UI.View.RoleDevelop.RoleGeneDetailView','detailPanel')  
  self.gene1 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneItemCtrl','UI.View.RoleDevelop.RoleGeneItemView','gene1')  
  self.gene2 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneItemCtrl','UI.View.RoleDevelop.RoleGeneItemView','gene2')  
  self.gene3 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneItemCtrl','UI.View.RoleDevelop.RoleGeneItemView','gene3')  
  self.gene4 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneItemCtrl','UI.View.RoleDevelop.RoleGeneItemView','gene4')  
  self.gene5 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneItemCtrl','UI.View.RoleDevelop.RoleGeneItemView','gene5')  
  self.animator =   self._binder:GetValue('animator')  
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')
  self.redpoint =   self._binder:GetValue('redpoint')  


end

return RoleGeneView
---自动生成代码----end----