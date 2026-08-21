---自动生成代码----start----
local RoleProfileStoryView = BaseClass( 'RoleProfileStoryView' , BaseView )
local M = RoleProfileStoryView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self:AddValue('UI.Ctrl.RoleDevelop.RoleProfileStoryItemCtrl','UI.View.RoleDevelop.RoleProfileStoryItemView','item')  
  self.describleTxt = self:AddBaseCom( GameUIText ,'describleTxt')
  self.describleContainer =   self._binder:GetValue('describleContainer')  
  self.container =   self._binder:GetValue('container')  


end

return RoleProfileStoryView
---自动生成代码----end----