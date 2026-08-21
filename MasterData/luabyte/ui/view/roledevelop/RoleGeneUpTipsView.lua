---自动生成代码----start----
local RoleGeneUpTipsView = BaseClass( 'RoleGeneUpTipsView' , BaseView )
local M = RoleGeneUpTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnMask =   self._binder:GetValue('btnMask')  
  self.Attr1 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr1')  
  self.Attr2 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr2')  
  self.Attr3 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr3')  
  self.Attr4 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr4')  
  self.Attr5 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr5')  
  self.state =   self._binder:GetValue('state')  
  self.effect1 =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effect1')  
  self.effect2 =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effect2')  
  self.effect3 =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effect3')  
  self.effect4 =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effect4')  
  self.effect5 =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effect5')  
  self.effect6 =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effect6')  
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.tipMask = self:AddBaseCom( GameUIImage ,'tipMask')
  self.tipsPanel =   self:AddValue('UI.Ctrl.RoleDevelop.GeneUpTipsCtrl','UI.View.RoleDevelop.GeneUpTipsView','tipsPanel')  


end

return RoleGeneUpTipsView
---自动生成代码----end----