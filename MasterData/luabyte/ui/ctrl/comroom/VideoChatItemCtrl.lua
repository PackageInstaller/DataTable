local VideoChatItemCtrl = BaseClass("VideoChatItemCtrl")
local M = VideoChatItemCtrl

function M:__init(view)
    self._view = view
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end

    self:_SetAvatarAndName(data)
    self:_SetVideo(data)
end

function M:_SetAvatarAndName(data)
    self._view.imgRoleAvatar:SetAvatarIcon(data.hero, 1)
    self._view.txtRoleName:SetText(data.heroName)
end

function M:_SetVideo(data)
    if data.id ~= 999999 then

    end
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return VideoChatItemCtrl
