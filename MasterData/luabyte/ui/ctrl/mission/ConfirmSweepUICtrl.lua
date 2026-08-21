local M = BaseClass("ConfirmSweepUICtrl", BaseUICtrl)


function M:Init()
    self.m_costNUm = 0
    self.m_sweepCount = 1
    self.m_sweepLimit = GameHelper.GetParamter(366)
    self.m_fmtStr = ConfigHelper.GetLocalString(6219)
    self._view.btn_mask:onClick(Bind(self, self.Close))
    self._view.btn_cancel:onClick(Bind(self, self.Close))
    self.m_sweepHandler = Bind(self, self.OnSweepBattleEnd)
    self._view.btn_confirm:onClick(Bind(self, self.OnClickConfirm))
    self._view.numSlider:SetChangedCallback(Bind(self, self.OnNumChanged))
end

function M:OnEnter(md)
    self.m_missionData = md
    self.m_mission = md:GetMissionCfg()
    self.m_costNUm = self.m_mission.energyCost
    local energyNum = EnergyMgr:GetInstance():EnergyValue()
    local maxCount = math.floor(energyNum / self.m_costNUm)
    self._view.numSlider:SetSliderInfo(self.m_sweepCount, math.min(maxCount, self.m_sweepLimit))
    self:_UpdateDesc()
end

function M:OnClickConfirm(go)
    if self.m_missionData:IsActivity() then
        local actId = ActivityCopyDataMgr:GetInstance():GetActivity()
        local nReq = { ActivityId = actId, MissionId = self.m_mission.id, Times = self.m_sweepCount }
        MissionDataMgr:GetInstance():ReqCopySweepBattle(nReq, self.m_sweepHandler)
    else
        local nReq = { MissionId = self.m_mission.id, Times = self.m_sweepCount }
        MissionDataMgr:GetInstance():ReqSweepBattle(nReq, self.m_sweepHandler)
    end
end

function M:OnNumChanged(num)
    self.m_sweepCount = num
    self:_UpdateDesc()
end

function M:OnClose()
    self.m_fmtStr = nil
    self.m_costNUm = nil
    self.m_mission = nil
    self.m_sweepLimit = nil
    self.m_sweepCount = nil
    self.m_missionData = nil
    self.m_sweepHandler = nil
end

-- 扫荡成功反馈
function M:OnSweepBattleEnd(sweepItems, totalExp)
    local mission = self.m_mission
    self:Close() -- 先关闭自己 再打开其它
    if not sweepItems then return end
    UIContextMgr:GetInstance():Show("MissionSweepRewardUI", sweepItems, mission, totalExp)
end

function M:_UpdateDesc()
    local value = self.m_costNUm * self.m_sweepCount
    self._view.txt_desc:SetText(string.format(self.m_fmtStr, value))
end

return M
