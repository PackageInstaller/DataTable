local M = BaseClass("EncounterAwardDetailsItemCtrl",require("Framework.UI.Component.CircularScrollViewItem"))

function M:__init()
    self._view.gainBtn:onClick(Bind(self,self._OnClickGain))
    self._view.cannotGainBtn:onClick(Bind(self,self._OnClickUnGain))
end

--点击领取
function M:_OnClickGain(go)
    EncounterConfMgr:GetInstance():GainEncounterAward(self.m_zoneIdx,self.m_emissionCfg.id,Bind(self,self._OnGain))
end

function M:_OnGain()
    EventMgr:Broadcast(UIMessageNames.ENCOUNT_GAIN_AWARD)
end

function M:_OnClickUnGain(go)
    GameHelper.Tips("未通关")
end

-- data = {zoneIdx=1,teamType=EncountConst.EEncountTeamType}
function M:UpdateItem(data,idx)
    self.m_data = data
    self.m_idx = idx
    self.m_zoneIdx = data.zoneIdx
    self.m_teamType = data.teamType
    local encounterData = EncounterConfMgr:GetInstance():GetEncounterData()
    local encounterZoneData = encounterData:GetZoneDataByIdx(data.zoneIdx)
    local emissionCfg = encounterZoneData:GetEMissionCfg(data.teamType)
    self.m_emissionCfg = emissionCfg
    local isPass = encounterZoneData:IsPass(data.teamType==EncountConst.EEncountTeamType.ETeamA)
    local canGain = encounterZoneData:CanGainReward(data.teamType)
    local alreadyGain = encounterZoneData:GetAlreadyByTeamType(data.teamType)
    self._view.icon:SetPic(encounterZoneData:IconPath())
    local nameDesc = ConfigHelper.GetLocalString(encounterZoneData:ZoneNameId())
    self._view.nameTf:SetText(nameDesc .. (data.teamType==EncountConst.EEncountTeamType.ETeamA and "A" or "B"))
    if canGain then 
        self._view.state:SetState(2)
    elseif not isPass and not alreadyGain then 
        self._view.state:SetState(1)
    else
        self._view.state:SetState(3)
    end
    local reward = emissionCfg.reward
    local num = #reward / 2
    for i = 1, 5 do
        local item = self._view["item"..i]
        if i <= num then 
            item:SetActive(true)
            local id = reward[(i - 1) * 2 + 1]
            local num = reward[(i - 1) * 2 + 2]
            item:SetInfo(id, ItemNumberType.TOTLE, num)
            item:EnablePopItem(true)
        else
            item:SetActive(false)
        end
    end
end

return M