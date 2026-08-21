local M = BaseClass("EncounterStageUICtrl", BaseUICtrl)
local EBattleStyle = EnumConst.EBattleStyle

function M:Init()
    self.m_index = 0
    self.m_zoneData = nil
    self.m_ectrData = nil -- EncounteData
    self.m_ABIndex = 1
    self._view.btn_ready:onClick(Bind(self, self.OnClickReady))
    self._view.btn_Encounter:onClick(Bind(self,self.OnClickChangeGarrison))
    self._view.btn_EncounterExit:onClick(Bind(self,self.OnClickGiveUpBattle))
end

--更新驻守
function M:OnClickChangeGarrison(go)
    local canGarrsion,heroIds,lockNum,garrsionHeroIds = EncounterConfMgr:GetInstance():GetChangeGarrsionData(self.m_index)
    if canGarrsion then 
        UIContextMgr:GetInstance():Show("EncounterGarrisonSelect",heroIds,lockNum,garrsionHeroIds,Bind(self,self.OnSelectGarrion))
    end
end

--放弃战斗
function M:OnClickGiveUpBattle(go)
    local passA = self.m_zoneData:IsPass(true)
    local allPass = passA and self.m_zoneData:IsPass(false)
    local desc = ""
    if allPass then 
        desc = ConfigHelper.GetLocalString(5847) -- "【警告】重置A、B区域，通关进度清除，需重新攻打（奖励不重置）(语言ID=?)"
    elseif passA then
        desc = ConfigHelper.GetLocalString(5846) -- "【警告】重置A区域，通关进度清除，需重新攻打（奖励不重置）(语言ID=?)"
    else
        return 
    end
    GameHelper.Confirm(desc,function(isOK)
        if isOK then 
            EncounterConfMgr:GetInstance():ResetEncounter(function(data)
                self:OnEnter(data,self.m_index )
            end)
        end
    end)
end

function M:OnSelectGarrion(garrionHeros)
    self:RefreshGarrsionHeros()
end

function M:OnDeviceBack()
    return self:OnBack()
end

function M:OnBack()
    self:Close()
    local encounterData = EncounterConfMgr:GetInstance():GetEncounterData()
    UIContextMgr:GetInstance():Show("EncounteMainUI", encounterData)
    return false
end

--刷新驻守英雄
function M:RefreshGarrsionHeros()
    local canGarrsion,heroIds,lockNum,garrsionHeroIds = EncounterConfMgr:GetInstance():GetChangeGarrsionData(self.m_index)
    local allPass = self.m_zoneData:IsPass(true) and self.m_zoneData:IsPass(false)
    self._view.garrsionState:SetState( ( allPass or canGarrsion ) and 2 or 1 )
    self._view.btn_ready:SetState(allPass and 2 or 1 )
    if not canGarrsion then 
        return
    end
    garrsionHeroIds = garrsionHeroIds or {}
    local list = {}
    self._OnClickGarrsionItem = self._OnClickGarrsionItem or Bind(self,self.OnClickGarrsionItem)
    for i = 1 , 6 do 
        local heroId = garrsionHeroIds[i]
        heroId = heroId or 0
        local data = {IsWork=false,HeroID = heroId}
        local itemView = self._view["garrisonItem"..i]
        if heroId ~= 0 or i <= lockNum then 
            itemView:SetActive(true)
            local itemCtrl = require("UI.Ctrl.ComRoom.JourneyHeroItemCtrl").New(itemView)
            itemCtrl:UpdateItem(data)
            itemCtrl:ClickCallback(self._OnClickGarrsionItem)
        else
            itemView:SetActive(false)
        end
    end

    self._view.btn_Encounter:SetActive(not allPass)
    self._view.btn_EncounterExit:SetActive(not allPass)
    
end

function M:OnClickGarrsionItem(data)
    local allPass = self.m_zoneData:IsPass(true) and self.m_zoneData:IsPass(false)
    if allPass then 
        return
    end
    --空的 
    local canGarrsion,heroIds,lockNum,garrsionHeroIds = EncounterConfMgr:GetInstance():GetChangeGarrsionData(self.m_index)
    if canGarrsion then
        if garrsionHeroIds then 
            UIContextMgr:GetInstance():Show("EncounterGarrisonSelect",heroIds,lockNum,garrsionHeroIds,Bind(self,self.OnSelectGarrion))
            return
        end
    end
end

function M:OnEnter(data, idx,isFromBattle)
    self.m_index = idx
    self.m_ectrData = data
    if isFromBattle == nil then 
        isFromBattle = false
    end
    self.m_isFromBattle = isFromBattle
    self.m_zoneData = self.m_ectrData:GetZoneDataByIdx(self.m_index)
    --self._view.txt_zoneName:SetText(self.m_zoneData:ZoneNameId())
    --标题隐藏
    self._view.txt_zoneName:SetActive(false)
    self._view.txt_zoneDesc:SetText(self.m_zoneData:ZoneDescId())
    local dataList = data:GetZoneDatas()
    self._view.zomeItem:UpdateItem(dataList[idx],idx)
    self._view.entryArea:SetActive(self.m_ectrData:Diffculty() ~= EncountConst.EEncountDifficult.ESimple)
    if self.m_ectrData:Diffculty() ~= EncountConst.EEncountDifficult.ESimple then 
        self._view.txt_seasonEntry:SetText(self.m_ectrData:SeasonEntryName())
        self._view.txt_seasonEntryDes:SetText(self.m_ectrData:SeasonEntryDesc())
        self._view.img_zoneIcon:SetPic(self.m_zoneData:IconPath())
    end
    
    local missions = self.m_zoneData:ZoneMissions()
    self._selectMengagementMissionId = 0 
    self._onSelectCallback = Bind(self,self._OnSelect)
    self._view.routeA:SetData(missions[1],self.m_zoneData:IsPass(true),self._onSelectCallback)
    self._view.routeB:SetData(missions[2],self.m_zoneData:IsPass(false),self._onSelectCallback)
    self._view.trans_lv:SetActive(false)
    --刷新驻守
    self:RefreshGarrsionHeros()
    --通关A，B未通关选A
    if  self.m_zoneData:IsPass(true) and not self.m_zoneData:IsPass(false) then 
        self:_OnSelect(missions[2]) 
        if self.m_isFromBattle then 
            self:OnClickChangeGarrison(nil)
        end
    --两个都未通关则选A
    elseif not self.m_zoneData:IsPass(true) and not self.m_zoneData:IsPass(false) then
        self:_OnSelect(missions[1])
    --通关
    elseif self.m_zoneData:IsPass(true) and self.m_zoneData:IsPass(false) then
        self:_OnSelect(0)
    end
end

function M:_OnSelect(mengagementMissionId)
    local missions = self.m_zoneData:ZoneMissions()
    --全通关了
    if mengagementMissionId == 0 then 
        self._view.routeA:SetSelect(false)
        self._view.routeB:SetSelect(false)
        self._view.txt_recommandLv:SetActive(false)
        self._view.trans_lv:SetActive(false)
        EncounterConfMgr:GetInstance():SetIndex(self.m_index,0)
        return
    elseif mengagementMissionId == missions[1] then
        self._view.routeA:SetSelect(true)
        self._view.routeB:SetSelect(false)
        self.m_ABIndex = 0
    else
        self._view.routeA:SetSelect(false)
        self._view.routeB:SetSelect(true)
        self.m_ABIndex = 1
    end
    self._view.txt_recommandLv:SetActive(true)
    EncounterConfMgr:GetInstance():SetIndex(self.m_index,self.m_ABIndex)
    self._selectMengagementMissionId = mengagementMissionId
    local emCfg = ConfigHelper.GetCfg("encounterMission",mengagementMissionId)
    local mCfg = ConfigHelper.GetCfg("mission",emCfg.missionId)
    self._view.txt_recommandLv:SetText(tostring(mCfg.showLv))
    self._view.trans_lv:SetActive(true)
end

function M:OnClose()
    -- body
end

function M:OnClickMore(go)
    UIContextMgr:GetInstance():Show("EncounterAwardDetails", self.m_ectrData, self.m_zoneData)
end

function M:OnClickReady(go)
   
    if self.m_zoneData:IsPass(true) and self.m_zoneData:IsPass(false) then 
        self:OnClickGiveUpBattle(nil)
        return 
    end

    --检测阵型
    EncounterConfMgr:GetInstance():CheckTeamData(self.m_ABIndex)

    local num = EncounterConfMgr:GetInstance():GetEncounterData():GetZoneMissionPassCount(self.m_index)
    ---如果只通关1关,并且还没有 驻守人数不足
    if num == 1 then 
        local canGarrsion,heroIds,lockNum,garrsionHeroIds = EncounterConfMgr:GetInstance():GetChangeGarrsionData(self.m_index)
        if canGarrsion then
            if garrsionHeroIds and #garrsionHeroIds < lockNum then 
                UIContextMgr:GetInstance():Show("EncounterGarrisonSelect",heroIds,lockNum,garrsionHeroIds,Bind(self,self.OnSelectGarrion))
                return
            end
        end
    end
    local eMissionCfg = ConfigHelper.GetCfg("encounterMission", self._selectMengagementMissionId)
    EncounterConfMgr:GetInstance():SetIndex(self.m_index,self.m_ABIndex)
    local battleStyle = EBattleStyle.Encount
    -- local missionId = OpenSystemMgr:GetInstance():GetMissionId()
    -- if missionId and missionId > 0 then
    --     battleStyle = EBattleStyle.Reward
    -- end
    UIContextMgr:GetInstance():Show(
        UIDefine.UITeamConfig,
        false,
        eMissionCfg.missionId,
        EnumConst.TeamConfigStyle.Battle,
        0,
        battleStyle
    )
end


function M:OnClickSeason(go)
    -- body
end

return M
