---自动生成代码----start----
local RoleProfilePersonaView = BaseClass( 'RoleProfilePersonaView' , BaseView )
local M = RoleProfilePersonaView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.content =   self._binder:GetValue('content')  
  self.item =   self:AddValue('UI.Ctrl.RoleDevelop.RoleProfileItemCtrl','UI.View.RoleDevelop.ProfileItemView','item')  


end

return RoleProfilePersonaView
---自动生成代码----end----