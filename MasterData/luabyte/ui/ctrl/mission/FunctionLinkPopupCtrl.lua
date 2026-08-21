local M = BaseClass("FunctionLinkPopupCtrl", BaseUICtrl)

function M:Init()
    self.m_mission = nil
    self.m_callback = nil
    self._view.btn_mask:onClick(Bind(self, self.Close))
    self._view.btn_close:onClick(Bind(self, self.Close))
    self._view.btn_goto:onClick(Bind(self, self.OnClickGoTo))
end

function M:OnEnter(mission, callback)
    self.m_mission = mission
    self.m_callback = callback
    self._view.img_banner:SetPic(mission.jumpPicture)

    local keyName = "PopupMission" .. tostring(mission.id)
    PlayerPrefTools.SetPlayerPrefs(keyName, 1)
end

function M:OnDispose()
    if self.m_callback then
        self.m_callback()
        self.m_callback = nil
    end
    self.m_mission = nil
    M.super.OnDispose(self)
end

function M:OnClickGoTo(go)
    if not self.m_mission then return end

    if self.m_mission.jumpType == EnumConst.PostmissionJumpType.Jump then
        JumpMgr:GetInstance():Execute(self.m_mission.jumpId)
    elseif self.m_mission.jumpType == EnumConst.PostmissionJumpType.Url then
        UIContextMgr:GetInstance():Show("WebUI", self.m_mission.jumpWeb)
    else
        Logger.LogError("jumpType error, jumpType = " .. tostring(self.m_mission.jumpType))
    end
    self.m_callback = nil
    self:Close()
end

return M
