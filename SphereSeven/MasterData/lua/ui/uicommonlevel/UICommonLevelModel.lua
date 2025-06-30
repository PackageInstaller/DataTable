---
---

local UICommonLevel = BaseClass("UICommonLevel",UIBaseModel)
local base = UIBaseModel
local this = UICommonLevel

function this.OnCreate(self)
    base.OnCreate(self)
    self.challengeType = 1
    self.levelType = LevelType.LevelTypeChallenge
end


function this.OnEnable(self, data)
    base.OnEnable(self)
    if data == nil then
        self.levelType = UIData.commonLevelData.levelType
        self.challengeType = UIData.commonLevelData.challengeType
        self.isOpenDetail = UIData.commonLevelData.isOpenDetail
        self.openId = UIData.commonLevelData.openId
    else
        UIData.SaveCommonLevelData(data)
        self.levelType = data.levelType
        self.challengeType = data.challengeType
        self.isOpenDetail = data.isOpenDetail
        self.openId = data.openId
    end
end

function this.OnRefresh(self)
    
end

local function OnTimeReset(self)
    --self:UIBroadcast(UIMessageNames.ON_TIME_RESET)
end

local function OnChallengeDiffChg(self)
    self:UIBroadcast(UIMessageNames.ON_CHALLENGE_DIFF_CHG)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    -- self:AddDataListener(DataMessageNames.ON_TIME_RESET,OnTimeReset)
    -- self:AddDataListener(DataMessageNames.ON_CHALLENGE_DIFF_CHG, OnChallengeDiffChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    -- self:RemoveDataListener(DataMessageNames.ON_TIME_RESET)
    -- self:RemoveDataListener(DataMessageNames.ON_CHALLENGE_DIFF_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end


return this