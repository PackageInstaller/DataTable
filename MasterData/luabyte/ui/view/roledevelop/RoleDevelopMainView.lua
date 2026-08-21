---自动生成代码----start----
local RoleDevelopMainView = BaseClass( 'RoleDevelopMainView' , BaseView )
local M = RoleDevelopMainView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.togglelst =   self._binder:GetValue('togglelst')  
  self.RoleDevelopListCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.RoleDevelopListCtrl','UI.View.RoleDevelop.RoleDevelopListView','RoleDevelopListCtrl')  
  self.state =   self._binder:GetValue('state')  
  self.tfBtnList =   self._binder:GetValue('tfBtnList')  


end

return RoleDevelopMainView
---自动生成代码----end----