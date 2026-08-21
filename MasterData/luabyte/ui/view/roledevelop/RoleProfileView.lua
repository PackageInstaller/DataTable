---自动生成代码----start----
local RoleProfileView = BaseClass( 'RoleProfileView' , BaseView )
local M = RoleProfileView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tab =   self._binder:GetValue('tab')  
  self.persona =   self:AddValue('UI.Ctrl.RoleDevelop.RoleProfilePersonaCtrl','UI.View.RoleDevelop.RoleProfilePersonaView','persona')  
  self.story =   self:AddValue('UI.Ctrl.RoleDevelop.RoleProfileStoryCtrl','UI.View.RoleDevelop.RoleProfileStoryView','story')  
  self.voice =   self:AddValue('UI.Ctrl.RoleDevelop.RoleProfileVoiceCtrl','UI.View.RoleDevelop.RoleProfileVoiceView','voice')  


end

return RoleProfileView
---自动生成代码----end----