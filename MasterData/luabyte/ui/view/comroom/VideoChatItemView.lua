---自动生成代码----start----
local VideoChatItemView = BaseClass( 'VideoChatItemView' , BaseView )
local M = VideoChatItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgRoleAvatar = self:AddBaseCom( GameUIImage ,'imgRoleAvatar')
  self.txtRoleName = self:AddBaseCom( GameUIText ,'txtRoleName')
  self.rimgRolePic = self:AddBaseCom( GameRawImage ,'rimgRolePic')


end

return VideoChatItemView
---自动生成代码----end----