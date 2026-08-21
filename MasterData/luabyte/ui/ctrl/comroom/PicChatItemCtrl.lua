local PicChatItemCtrl = BaseClass("PicChatItemCtrl")
local M = PicChatItemCtrl

function M:__init(view)
    self._view = view

    self._view.rimgRolePic:onClick(Bind(self, self.OnPicClick))
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end

    self:_SetAvatarAndName(data)
    self:_SetPicture(data)
end

function M:OnPicClick()
    UIContextMgr:GetInstance():Show("ComRoomPicUI", self._path)
end

function M:_SetAvatarAndName(data)
    self._view.imgRoleAvatar:SetAvatarIcon(data.hero, 1)
    self._view.txtRoleName:SetText(data.heroName)
end

function M:_SetPicture(data)
    if data.id ~= 999999 then
        self._path = data.picture
        self._view.rimgRolePic:SetPic(data.picture, false)
    end
end

function M:Dispose()
    self._view.rimgRolePic:onClick(nil)
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return PicChatItemCtrl
