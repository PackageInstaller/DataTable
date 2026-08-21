---自动生成代码----start----
local RoleChatItemView = BaseClass( 'RoleChatItemView' , BaseView )
local M = RoleChatItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgRoleAvatar = self:AddBaseCom( GameUIImage ,'imgRoleAvatar')
  self.txtRoleDialogue = self:AddBaseCom( GameUIText ,'txtRoleDialogue')


end

return RoleChatItemView
---自动生成代码----end----