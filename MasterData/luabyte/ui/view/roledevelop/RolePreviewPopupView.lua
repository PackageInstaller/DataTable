---自动生成代码----start----
local RolePreviewPopupView = BaseClass( 'RolePreviewPopupView' , BaseView )
local M = RolePreviewPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.hp = self:AddBaseCom( GameUIText ,'hp')
  self.def = self:AddBaseCom( GameUIText ,'def')
  self.defm = self:AddBaseCom( GameUIText ,'defm')
  self.atk = self:AddBaseCom( GameUIText ,'atk')
  self.shield = self:AddBaseCom( GameUIText ,'shield')
  self.costContent =   self._binder:GetValue('costContent')  
  self.coin =   self._binder:GetValue('coin')  
  self.costItem =   self._binder:GetValue('costItem')  
  self.rare = self:AddBaseCom( GameUIImage ,'rare')
  self.roleImg = self:AddBaseCom( GameRawImage ,'roleImg')
  self.chName = self:AddBaseCom( GameUIText ,'chName')
  self.enName = self:AddBaseCom( GameUIText ,'enName')
  self.lv = self:AddBaseCom( GameUIText ,'lv')
  self.starGroup =   self:AddValue('UI.Ctrl.RoleDevelop.RoleDevelopBaseInfoStarGroupCtrl','UI.View.RoleDevelop.RoleDevelopBaseInfoStarGroup','starGroup')  
  self.lastBtn =   self._binder:GetValue('lastBtn')  
  self.nextBtn =   self._binder:GetValue('nextBtn')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.UIBreakCtrl =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','UIBreakCtrl')  


end

return RolePreviewPopupView
---自动生成代码----end----