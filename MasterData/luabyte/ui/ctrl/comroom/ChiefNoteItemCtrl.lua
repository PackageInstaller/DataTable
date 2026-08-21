local M = BaseClass("ChiefNoteItemCtrl")

function M:__init(view)
    self._view = view
    self._isUnlock = nil
    self._select = nil
    self._id = nil
    self._view.rectItem:onClick(Bind(self, self.OnNoteClick))
end

function M:Dispose()
    self._view.rectItem:onClick(nil)
    self._isUnlock = nil
    self._select = nil
    self._id = nil
    self:OnDispose()
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:OnNoteClick()
    if not self._select then
        PlayerPrefTools.SetPlayerPrefs("keyWord" .. tostring(self._id), 1)
        ChiefNoteDataMgr:GetInstance():UpdateSelectDataById(self._id)
        EventMgr:Broadcast(UIMessageNames.CHIEFNOTE_SELECT_UPDATE)
        IRedPointMgr:ForceCheck(RedPointConst.ChiefNoteMainTypeRedPointChecker)
    end
end

function M:UpdateItem(data)
    if not data then return end

    self._select = data.select
    self._id = data.id
    self._isUnlock = JumpMgr:GetInstance():CheckLockByOpenConditionIds(data.openCondition)

    if self._isUnlock then
        if data.select then
            self:_SetUnlockSelectState(data)
        else
            self:_SetUnlockUnselectState(data.name)
        end
    else
        if data.select then
            self:_SetLockSelectState(data)
        else
            self:_SetLockUnselectState(data.name)
        end
    end

    self._view.redPoint:SetParam(0, self._id)
    self._view.redPoint:Check()
end

function M:_SetUnlockSelectState(data)
    self._view.anim:SetDoRestart()
    self._view.stateItem:SetState(ChiefNoteConst.UIState.UNLOCK_SELECT)
    self._view.txtItem:SetText(data.name)

    local count = JumpMgr:GetInstance():GetUnLockCount(data.openCondition)
    local content = ""
    for i = 1, count do
        local desc = ConfigHelper.GetLocalStringByPlayerName(data.explanation[i])
        if content then
            content = content .. string.format("%s\n", desc)
        else
            content = string.format("%s\n", desc)
        end
    end

    self._view.stateContent:SetState(1)
    self._view.txtUnlockContent:SetText(content)
end

function M:_SetUnlockUnselectState(name)
    self._view.stateItem:SetState(ChiefNoteConst.UIState.UNLOCK_UNSELECT)
    self._view.txtItem:SetText(name)
end

function M:_SetLockSelectState(data)
    self._view.anim:SetDoRestart()
    self._view.stateItem:SetState(ChiefNoteConst.UIState.LOCK_SELECT)
    self._view.txtItem:SetText(data.name)

    self._view.stateContent:SetState(2)
    self._view.txtLockContent:SetText(data.tips)
end

function M:_SetLockUnselectState(name)
    self._view.stateItem:SetState(ChiefNoteConst.UIState.LOCK_UNSELECT)
    self._view.txtItem:SetText(name)
end

return M
