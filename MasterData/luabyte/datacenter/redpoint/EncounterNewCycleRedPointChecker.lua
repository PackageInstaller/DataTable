local EncounterNewCycleRedPointChecker = BaseClass("EncounterNewCycleRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = EncounterNewCycleRedPointChecker

function M:Check()
    self.checkResult = 0
    local openCfg = ConfigHelper.GetCfgByLua("functionOpen", 27) or {}
    local conditionLst = GameHelper.GetLockConditions(openCfg.openCondition)
    if #conditionLst > 0 then
        --未解锁
        return
    end
    self.isChecking = true
    self._OnResponseEnterEncounterHandler = self._OnResponseEnterEncounterHandler or Bind(self, self._OnResponseEnterEncounter)
    EncounterConfMgr:GetInstance():LoadData(self._OnResponseEnterEncounterHandler)
end

function M:_OnResponseEnterEncounter(teams, encounteData)
    self.isChecking = false
    local list = encounteData:GetZoneDatas()
    for i = 1, #list do
        if list[i]:CanGainReward(EncountConst.EEncountTeamType.ETeamA) then 
            self.checkResult = 1
            return
        end
        if list[i]:CanGainReward(EncountConst.EEncountTeamType.EteamB) then 
            self.checkResult = 1
            return
        end
    end
    self.checkResult = 0
end


return EncounterNewCycleRedPointChecker