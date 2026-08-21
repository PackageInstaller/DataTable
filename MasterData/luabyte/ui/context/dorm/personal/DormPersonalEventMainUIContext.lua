local M = BaseClass("DormPersonalEventMainUIContext", BaseContext)
local eventId = UIMessageNames.DORM_PERSONALCOPY_ENDBATTLE

function M:Init()
    GameKeyNodeMgr:GetInstance():AddHandler(EGameKeyNode.AfterMainScene, Bind(self, self.OnEnterMainScene))
    GameKeyNodeMgr:GetInstance():AddHandler(EGameKeyNode.AccountLevelUp, Bind(self, self.OnCheckUnlockState))
    GameKeyNodeMgr:GetInstance():AddHandler(EGameKeyNode.HerosFavorAbilityUp, Bind(self, self.OnCheckUnlockState))
end

function M:Open(heroId, copyList)
    if self.m_endBattle then EventMgr:RemoveListener(eventId, self.m_endBattle) end
    self.m_endBattle = EventMgr:AddListener(eventId, Bind(self, self.UpdateCopyList))
    self:_Show(heroId, copyList)
end

function M:UpdateCopyList()
    local ctrl = self:GetCtrl()
    if ctrl then ctrl:UpdateMissionList() end
end

function M:OnEnterMainScene()
    DormDataMgr:DoReqLoadPersonalCopy()
end

function M:OnCheckUnlockState()
    -- DormDataMgr:CheckPersonalUnlock()
end

function M:OnClose()
    if self.m_endBattle then
        EventMgr:RemoveListener(eventId, self.m_endBattle)
        self.m_endBattle = nil
    end
    M.super.OnClose(self)
end

return M
