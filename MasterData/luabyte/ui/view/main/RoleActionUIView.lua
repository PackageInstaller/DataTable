---自动生成代码----start----
local RoleActionUIView = BaseClass( 'RoleActionUIView' , BaseView )
local M = RoleActionUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.RoleListCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.RoleListCtrl','UI.View.RoleDevelop.RoleListView','RoleListCtrl')  
  self.eventScrollView = self:AddBaseCom( CircularScrollView ,'eventScrollView')
  self.save =   self._binder:GetValue('save')  
  self.quality = self:AddBaseCom( GameUIImage ,'quality')
  self.iconProfession = self:AddBaseCom( GameUIImage ,'iconProfession')
  self.roleName = self:AddBaseCom( GameUIText ,'roleName')
  self.roleInfoState =   self._binder:GetValue('roleInfoState')  


end

return RoleActionUIView
---自动生成代码----end----