local M = BaseClass("HomeLevelUpContext", BaseContext)

function M:Init()
    self.m_oldLevel = 0
    self.m_newLevel = 0
    self.m_uiNamesList = {
        ["TaskUI"] = true,
        ["BattleSettlementUI"] = true,
        ["MissionSweepRewardUI"] = true
    }
end

function M:LevelUpShow(evt)
    if IsNull(IGuideMgr) then return end

    if not evt.isShow then return end

    if IGuideMgr.IsGuiding then return end

    if not self.m_uiNamesList[evt.uiName] then return end

    if self.m_newLevel > self.m_oldLevel then
        --local curModuleId = ModuleMgr:GetInstance():GetCurModuleId()
        --战斗中为了不打断原的UI等待逻辑，此处把时间都停了
        -- if curModuleId == ModuleConfig.BattleModule.id then
        --     ITimeMgr:ChangeTimeMode(EnumConst.TimeMode.BattlePause)
        -- end
        self:_Show(self.m_oldLevel, self.m_newLevel)
        self.m_oldLevel = self.m_newLevel
    end
end

-- function M:OnClose()
--     ITimeMgr:ChangeTimeMode(EnumConst.TimeMode.BattleSingle)
--     M.super.OnClose(self)
-- end

function M:PlayerLevelUp(reslut)
    --不存在未展示的等级
    if self.m_oldLevel < reslut.preLevel then
        self.m_oldLevel = reslut.preLevel
    end
    self.m_newLevel = reslut.nextLevel
end

return M
