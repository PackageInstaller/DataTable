---自动生成代码----start----
local VoiceChatItemView = BaseClass( 'VoiceChatItemView' , BaseView )
local M = VoiceChatItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgRoleAvatar =   self._binder:GetValue('imgRoleAvatar')  
  self.txtRoleName =   self._binder:GetValue('txtRoleName')  


end

return VoiceChatItemView
---自动生成代码----end----