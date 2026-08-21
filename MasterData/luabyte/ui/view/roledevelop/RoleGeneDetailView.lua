---自动生成代码----start----
local RoleGeneDetailView = BaseClass( 'RoleGeneDetailView' , BaseView )
local M = RoleGeneDetailView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.star1 =   self._binder:GetValue('star1')  
  self.star2 =   self._binder:GetValue('star2')  
  self.star3 =   self._binder:GetValue('star3')  
  self.star4 =   self._binder:GetValue('star4')  
  self.star5 =   self._binder:GetValue('star5')  
  self.star6 =   self._binder:GetValue('star6')  
  self.effect1 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectItemCtrl','UI.View.RoleDevelop.RoleEffectItemView','effect1')  
  self.effect2 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectItemCtrl','UI.View.RoleDevelop.RoleEffectItemView','effect2')  
  self.effect3 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectItemCtrl','UI.View.RoleDevelop.RoleEffectItemView','effect3')  
  self.effect4 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectItemCtrl','UI.View.RoleDevelop.RoleEffectItemView','effect4')  
  self.effect5 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleGeneEffectItemCtrl','UI.View.RoleDevelop.RoleEffectItemView','effect5')  
  self.costItem =   self:AddValue('','UI.View.Common.ItemPfbView','costItem')  
  self.content =   self._binder:GetValue('content')  
  self.detailBtn =   self._binder:GetValue('detailBtn')  
  self.activeBtn =   self._binder:GetValue('activeBtn')  
  self.upStarBtn =   self._binder:GetValue('upStarBtn')  
  self.state =   self._binder:GetValue('state')  
  self.goBtn =   self._binder:GetValue('goBtn')  
  self.comCost =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','comCost')  
  self.stateBtn =   self._binder:GetValue('stateBtn')  
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')


end

return RoleGeneDetailView
---自动生成代码----end----