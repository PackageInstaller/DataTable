local ComHeroItemCtrl = BaseClass("ComHeroItemCtrl")
local M = ComHeroItemCtrl

function M:__init(view)
    self._view = view
    self._data = nil
    self._curTab = nil

    self._view.rectClickArea:onClick(Bind(self, self.OnTabClick))
    self._view.rectRename:onClick(Bind(self, self.OnRenameClick))
end

function M:OnTabClick()
    EventMgr:Broadcast(UIMessageNames.COM_TYPE_TAB_CHANGE, self._data)
end

function M:OnRenameClick()
    UIContextMgr:GetInstance():Show("ComRenameUI", self._chatName)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self._chatName = data.chatName
    self:_HideAll()
    self._view.redpoint:SetParam(0,  self._chatName)
    self._view.redpoint:Check()
    if data.chatType == ComConst.ChatType.Private then
        self:_SetPrivateTab(data)
    elseif data.chatType == ComConst.ChatType.Group then
        self:_SetGroupTab(data)
    else
        self:_SetOfficalTab(data)
    end

    if data.select then
        self._view.UIState:SetState(2)
    else
        self._view.UIState:SetState(1)
    end

end

function M:_HideAll()
    self._view.rectPrivateTab:SetActive(false)
    self._view.rectGroupTab:SetActive(false)
    self._view.rectOfficalTab:SetActive(false)
end

function M:_SetPrivateTab(data)
    self._view.rectPrivateTab:SetActive(true)

    self:_SetName(data)
    self:_SetAvatar(data)
end

function M:_SetGroupTab(data)
    self._view.rectGroupTab:SetActive(true)

    self:_SetName(data)
end

function M:_SetOfficalTab(data)
    self._view.rectOfficalTab:SetActive(true)

    self:_SetName(data)
    self:_SetAvatar(data)
end

function M:_SetName(data)
    local name = PlayerPrefabHelper.GetString(ComConst.ComRename .. data.chatName)

    if name == nil or name == "" then
        self._view.txtTabNameCN:SetText(data.chatName)
    else
        self._view.txtTabNameCN:SetText(name)
    end

    -- if data.chatType == ComConst.ChatType.Private then
    --     self._view.txtTabNameEN:SetActive(true)
    --     self._view.txtTabNameEN:SetText(data.chatNameEn)
    -- elseif data.chatType == ComConst.ChatType.Group or data.chatType == ComConst.ChatType.Offical then
    --     self._view.txtTabNameEN:SetActive(false)
    -- end
end

function M:_SetAvatar(data)
    if data.chatType == ComConst.ChatType.Private then
        self._view.imgRoleIcon:SetAvatarIcon(data.hero, 1)
    elseif data.chatType == ComConst.ChatType.Offical then
        self._view.imgOfficalIcon:SetPic(data.smallPicture)
    end
end

function M:Dispose()
    self._view.rectClickArea:onClick(nil)

    self._data = nil
    self._curTab = nil

    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return ComHeroItemCtrl
