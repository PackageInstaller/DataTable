local VoiceChatItemCtrl = BaseClass("VoiceChatItemCtrl")
local M = VoiceChatItemCtrl

function M:__init(view)
    self._view = view
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end

    self:_SetAvatarAndName(data)
end

function M:_SetAvatarAndName(data)
    self._view.imgRoleAvatar:SetAvatarIcon(data.hero, 1)
    self._view.txtRoleName:SetText(data.heroName)
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return VoiceChatItemCtrl
