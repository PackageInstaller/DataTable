---自动生成代码----start----
local UIAdvancedView = BaseClass( 'UIAdvancedView' , BaseView )
local M = UIAdvancedView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.UIBreakCtrl =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','UIBreakCtrl')  
  self.btnMask =   self._binder:GetValue('btnMask')  
  self.Attr1 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr1')  
  self.Attr2 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr2')  
  self.Attr3 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr3')  
  self.Attr4 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr4')  
  self.Attr5 =   self:AddValue('UI.Ctrl.RoleDevelop.UIAdvancedItemCtrl','UI.View.RoleDevelop.UIAdvancedItemView','Attr5')  
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.UnlockItem =   self:AddValue('UI.Ctrl.RoleDevelop.UnlockItemCtrl','UI.View.RoleDevelop.UnlockItemView','UnlockItem')  


end

return UIAdvancedView
---自动生成代码----end----