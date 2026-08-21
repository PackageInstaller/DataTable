local M = BaseClass("EncounterBattleSettlementCtrl", BaseUICtrl)

function M:OnEnter(id,missionId)
    ITimeMgr:ChangeTimeMode(EnumConst.TimeMode.GameNormal)
    local lua_idx = 1
    local cfg = ConfigHelper.GetCfg("engagementZone", id)
    for i = 1, #cfg.missions do 
        local emissionCfg = ConfigHelper.GetCfg("encounterMission", cfg.missions[i])
        if emissionCfg.missionId == missionId then 
            lua_idx = i 
        end
    end
    local nameDesc = "%s<color=#FBC20E>(%s点已通关)</color>"
    local flag = lua_idx == 1 and "A" or "B"
    local namestr = ConfigHelper.GetLocalString(cfg.name)
    self._view.nameText:SetText( string.format( nameDesc,namestr, flag) )
    self._view.roleCtrl:Refresh(EnumConst.EBattleStyle.Encount, {})
    self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self._OnTimer), nil, false)
    self._timer:Start()
    self._timeRemain = 10
end

function M:_OnTimer()
    self._timeRemain = self._timeRemain - 1
    self._view.txt_timer:SetText(tostring(self._timeRemain))
    if self._timeRemain <= 0 then
        if self._timer then
            self._timer:Stop()
        end
        self._timer = nil
        self:_OnCloseClick()
    end
end

function M:OnDispose()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    M.super.OnDispose(self)
end

function M:Init()
    self._view.closeBtn:onClick(Bind(self, self._OnCloseClick))
end

--点击设置退出键
function M:OnDeviceBack()
    self:_OnCloseClick()
    return true
end

function M:_OnCloseClick()
    if self._timer then
        self._timer:Stop()
    end
    self._timer = nil
    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.StageModule.id, EnumConst.EBattleStyle.Encount, nil, nil, true);
end

return M
