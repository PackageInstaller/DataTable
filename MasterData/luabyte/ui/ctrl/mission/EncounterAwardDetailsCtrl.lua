local M = BaseClass("EncounterAwardDetailsCtrl", BaseUICtrl)

function M:Init()
    self.m_encounteData = nil
    self._view.backBtn:onClick(Bind(self, self.OnClickBack))
    self._view.gainAllBtn:onClick(Bind(self,self.OnClickGainAll))
    self._view.cirScrollview:Init(require("UI.Ctrl.Mission.EncounterAwardDetailsItemCtrl"),require("UI.View.Mission.EncounterAwardDetailsItemView"))
    self._encount_gain_Hander = EventMgr:AddListener(UIMessageNames.ENCOUNT_GAIN_AWARD,Bind(self,self._OnGain))
end

function M:OnClickGainAll(go)
    EncounterConfMgr:GetInstance():GainEncounterAward(0,0,Bind(self,self._OnGain))
end

function M:_OnGain()
    self:OnEnter(self.m_encounteData)
end

function M:OnEnter(encounteData)
    self.m_encounteData = encounteData
    local zoneDatas = self.m_encounteData:GetZoneDatas()
    local list = {}
    --{zoneIdx=1,teamType=EncountConst.EEncountTeamType}
    --ETeamA = 1,
    --EteamB = 2,
    local hasReward = false
    for i = 1 , #zoneDatas do 
        --把1个选区的AB关奖励分开显示
        local zoneIdx = zoneDatas[i]:GetZoneIdx()
        local o = {}
        o.zoneIdx = zoneIdx
        o.teamType = EncountConst.EEncountTeamType.ETeamA
        o.canGain,o.alreadyGain = EncounterConfMgr:GetInstance():GanGainReward(zoneIdx,o.teamType)
        if zoneDatas[i]:CanGainReward(o.teamType) then
            hasReward = true
        end
        table.insert(list,o)
        o = {}
        o.zoneIdx = zoneIdx
        o.teamType = EncountConst.EEncountTeamType.EteamB
        o.canGain,o.alreadyGain = EncounterConfMgr:GetInstance():GanGainReward(zoneIdx,o.teamType)
        if zoneDatas[i]:CanGainReward(o.teamType) then
            hasReward = true
        end
        table.insert(list,o)
        
    end
    table.sort(list,Bind(self,self._SortList))

    self._view.gainAllBtn:SetActive(hasReward)
    self._view.cirScrollview:SetDataList(list)
end

function M:_SortList(o1,o2)
    if o1.canGain == o2.canGain and o1.alreadyGain == o2.alreadyGain then 
        return o1.zoneIdx < o2.zoneIdx
    end
    if o1.canGain ~= o2.canGain then 
        if o1.canGain then 
            return true
        end
        return false
    end
    if o1.alreadyGain ~= o2.alreadyGain then 
        if o1.alreadyGain then 
            return false
        end
        return true
    end
    return o1.zoneIdx < o2.zoneIdx
end

function M:OnClose()
    self.m_encounteData = nil
end

function M:OnClickBack(go)
    self:Close()
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ENCOUNT_GAIN_AWARD,self._encount_gain_Hander)
    M.super.OnDispose(self)
end

return M
